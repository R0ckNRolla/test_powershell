powershell Set-ExecutionPolicy Unrestricted
set shell = wscript.createobject("wscript.shell")
shell.run "powershell -file C:\scripts\hello.ps1",0,false