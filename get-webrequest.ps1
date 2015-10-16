#

$r = [System.Net.WebRequest]::Create("http://www.google.com")
$resp = $r.GetResponse()
$reqstream = $resp.GetResponseStream()
$sr = new-object System.IO.StreamReader $reqstream
$result = $sr.ReadToEnd()
write-host $result

#

$wc = New-Object System.Net.WebClient
$result = $wc.DownloadString('http://www.google.com')
write-host $result
