@ECHO OFF
SET psdir=%SystemRoot%\System32\WindowsPowerShell\v1.0
SET ps=%psdir%\powershell.exe

%ps% -Command "(Invoke-WebRequest -Uri https://bpotd.herokuapp.com/ie/).Content | Select-String -Pattern '(http|https):\/\/www\.bing\.com\/th\?id=[A-Za-z0-9\._\-]{0,}(\.png|\.jpg)'"