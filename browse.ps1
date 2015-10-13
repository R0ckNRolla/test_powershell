
$ie = New-Object -ComObject InternetExplorer.Application
$ie.Navigate("http://www.google.com")
Start-Sleep -s 15

#	$ie.Document.Body.InnerText
#	$ie | Get-Member