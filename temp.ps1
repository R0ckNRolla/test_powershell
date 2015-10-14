$si = new-object System.Diagnostics.ProcessStartInfo
$si.WorkingDirectory = $pwd
$si.UseShellExecute = $false
$si.FileName = (get-command powershell.exe).Definition
$si.CreateNoWindow = $true
$si.WindowStyle = 'Hidden'
$si.Arguments = "(New-Object -ComObject InternetExplorer.Application).Navigate('http://www.google.com')"
$p = New-Object System.Diagnostics.Process
$p.StartInfo = $si
$p.start()

# ?