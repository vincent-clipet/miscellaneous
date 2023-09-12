require 'fileutils'
require 'nokogiri'
require 'open-uri'





# CONFIG
# ======






# UTILS
# =====

def http_get(url)
	begin
		return URI.open(url)
	rescue Exception => exc
		puts "[ERROR] #{exc.backtrace}"
		exit 1
	end
end





# SCRIPT
# ======

# Build URL
base_url = "https://www.wowhead.com/battle-pets?filter=11;1;0#petspecies;_INDEX_"
index_start = 0
index_step = 100

url = base_url.gsub(/_INDEX_/, index_start.to_s)
#puts "[INFO] HTTP GET #{url}"

# HTTP GET
response = http_get(url)

parsed_html = Nokogiri::HTML(response)

content = parsed_html.css("#tab-petspecies").css(".q3 .listview-cleartext")
#content = parsed_html.at_css("#battle-pets-tabs > div > ul > li").text()
puts content.to_s