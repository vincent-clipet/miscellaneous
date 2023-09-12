While ($true) {
    Write-Output ("{0:HH:mm:ss}{1}{2}" -f 
        (Get-Date), 
        (netsh wlan show interfaces | Select-String -Pattern "Channel"), 
        (netsh wlan show interfaces | Select-String -Pattern "Signal")
    )
    Start-Sleep -Seconds 1
}