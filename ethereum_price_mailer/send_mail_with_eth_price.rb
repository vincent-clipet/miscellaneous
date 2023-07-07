require 'rest-client'
require 'json'
require 'mail'




# CONFIG ################################
URL = "https://api.coinmarketcap.com/v1/ticker/ethereum/"
MAIL_TO = "" # destination email address
MAIL_FROM = "" # source email address
MAIL_TYPE = ARGV[0]
TRIGGER_PERCENTAGE_DAILY = -5
TRIGGER_PERCENTAGE_HOURLY = -3
#########################################










def get_data_from_api(url)

	api_resp = nil
	puts "API request to #{URL} ..."

	begin
		api_resp = RestClient.get(URL)
		puts "API response (#{api_resp.code})"
	rescue RestClient::ExceptionWithResponse
		puts "[ERROR] API down"
		send_mail_error("API down")
		exit 1
	end

	json = JSON.parse(api_resp.body)[0]
	data = json.values_at("price_usd", "24h_volume_usd", "percent_change_1h", "percent_change_24h", "percent_change_7d")

	data[2] = "+#{data[2]}" if data[2].to_i > 0
	data[3] = "+#{data[3]}" if data[3].to_i > 0
	data[4] = "+#{data[4]}" if data[4].to_i > 0

	return data
end



def send_mail_error(error)
	msg = "[ERROR] #{error}"
	mail = Mail.new do
		from(MAIL_FROM)
		to(MAIL_TO)
		subject(msg)
		body(Time.now().to_s)
	end
	mail.deliver!
end



def get_prefix_or_exit(data)
	prefix = ""

	if MAIL_TYPE == "alert"
		prefix = "[alert]"
		data[2].to_i > TRIGGER_PERCENTAGE_HOURLY ? exit(0) :  prefix << " {1h}"
		data[3].to_i > TRIGGER_PERCENTAGE_DAILY ? exit(0) : prefix << " {24h}"
	elsif MAIL_TYPE == "report"
		prefix = "[report] "
		prefix << " {1h}" if data[2].to_i < TRIGGER_PERCENTAGE_HOURLY
		prefix << " {24h}" if data[3].to_i < TRIGGER_PERCENTAGE_DAILY
	end

	return prefix << " "
end



def build_mail(data, prefix)
	mail_body = []
	mail_body << "Prix : #{data[0]} $"
	mail_body << ""
	mail_body << "Volume 24h : #{data[1]} $" 
	mail_body << ""
	mail_body << "1h : #{data[2]} %"
	mail_body << "24h : #{data[3]} %"
	mail_body << "7j : #{data[4]} %"
	mail_body = mail_body.join("\n")

	mail_subject = []
	mail_subject << prefix
	mail_subject << "... #{data[0]}$ ... #{data[2]}% ... #{data[3]}%"
	mail_subject = mail_subject.join()

	return mail_subject, mail_body
end



def send_mail(mail_from, mail_to, mail_subject, mail_body)
	mail = Mail.new do
		from(mail_from)
		to(mail_to)
		subject(mail_subject)
		body(mail_body)
	end
	mail.delivery_method(:sendmail)
	mail.deliver!
end







puts "======================================================="

puts "#{Time.now()}"

data = get_data_from_api(URL)
puts "data = #{data.join(" | ")}"

prefix = get_prefix_or_exit(data)
puts "prefix = #{prefix}"

mail_subject, mail_body = build_mail(data, prefix)
puts "Sending mail ..."
send_mail(MAIL_FROM, MAIL_TO, mail_subject, mail_body)
puts "Mail sent"