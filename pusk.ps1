$si = new-object System.Diagnostics.ProcessStartInfo
$si.WorkingDirectory = $pwd
$si.UseShellExecute = $false
$si.FileName = (get-command powershell.exe).Definition
$si.CreateNoWindow = $true
$si.WindowStyle = 'Hidden'

echo $si.WindowStyle

[diagnostics.process]::Start($si)
Start-Process calc.exe -WindowStyle Hidden
//$pws = New-Object system.diagnostics.ProcessWindowStyle


$p = New-Object System.Diagnostics.Process
$p.StartInfo = $si
$p.start()


$Process = new-Object System.Diagnostics.Process
$Process.StartInfo.WindowStyle="Hidden"
	$Process.StartInfo.CreateNoWindow = "true"
	$Process.StartInfo.UseShellExecute = "false"
$Process.StartInfo.FileName="cmd.exe"
$Process.Start()