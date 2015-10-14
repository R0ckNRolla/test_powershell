$f=$env:TEMP;$f+='\__Temp.tmp'
"Write-Output 'Hello';" >> $f
$a = get-content $f
$s = $executioncontext.invokecommand.NewScriptBlock([string]($a))
Invoke-Command -scriptblock $s
