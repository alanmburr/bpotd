#!/Windows/System32/WindowsPowerShell/v1.0/powershell.exe

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Request = Invoke-WebRequest -Uri "https://bpotd.herokuapp.com/api"
$RequestResponse = $Request.Content
$Response = $RequestResponse | ConvertFrom-Json

$Form = New-Object system.Windows.Forms.Form
$Form.Height = 800
$Form.Width = 1000
$Form.AutoSize = $true
$Form.Text = $Response.htmlTitle
$Form.ShowIcon = $true
$Form.ShowInTaskbar = $true

$RetriveIcon = Invoke-WebRequest -Uri "https://bpotd.herokuapp.com/static/favicon.ico" -ContentType "image/vnd.microsoft.icon" -OutFile $env:TEMP/bpotd.ico
$Form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($env:TEMP+'/bpotd.ico')

$WebBrowser = New-Object System.Windows.Forms.WebBrowser
$WebBrowser.Dock = "Fill"
$WebBrowser.Location = New-Object System.Drawing.Point(0,0)
$WebBrowser.ScriptErrorsSuppressed = $true
$WebBrowser.Url = "https://bpotd.herokuapp.com/ie/"
$WebBrowser.ScrollBarsEnabled = $false
$Form.Controls.Add($WebBrowser)

$Form.ShowDialog()