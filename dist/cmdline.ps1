Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

Invoke-WebRequest -Uri "https://bpotd.herokuapp.com/static/favicon.ico" -ContentType "image/vnd.microsoft.icon" -OutFile $env:TEMP/bpotd.ico
$logo_img = [System.Drawing.Icon]::ExtractAssociatedIcon($env:TEMP+'/bpotd.ico')
Try { $quit_img = [System.Drawing.Image]::FromFile("C:\Windows\System32\SecurityAndMaintenance_Error.png") } Catch { $quit_img = [System.Drawing.SystemIcons]::Error }
Invoke-WebRequest -Uri "https://alanmburr.github.io/bpotd/imageres_72.ico" -ContentType "image/vnd.microsoft.icon" -OutFile $env:TEMP/imageres_72.ico
$picture_img = [System.Drawing.Icon]::ExtractAssociatedIcon($env:TEMP+"/imageres_72.ico")
Try { $webbrowser_img = [System.Drawing.Icon]::ExtractAssociatedIcon("C:\Windows\System32\connect.dll") } Catch {
    Invoke-WebRequest -Uri "https://alanmburr.github.io/bpotd/connect_10101.ico" -ContentType "image/vnd.microsoft.icon" -OutFile $env:TEMP/connect_10101.ico
    $webbrowser_img = [System.Drawing.Icon]::ExtractAssociatedIcon($env:TEMP+"/connect_10101.ico")}

$Main_Tool_Icon = New-Object System.Windows.Forms.NotifyIcon
$Main_Tool_Icon.Text = "bpotd"
$Main_Tool_Icon.Visible = $true
$Main_Tool_Icon.Icon = $logo_img

$Openimg = New-Object System.Windows.Forms.ToolStripMenuItem
$Openimg.Text = "Open Image"
$Openimg.Image = $picture_img
$Openimg.Enabled = $false

$hr = New-Object System.Windows.Forms.ToolStripSeparator

$OpenApp = New-Object System.Windows.Forms.ToolStripMenuItem
$OpenApp.Text = "Open App"
$OpenApp.Image = $picture_img

$GoBingcom = New-Object System.Windows.Forms.ToolStripMenuItem
$GoBingcom.Text = "Go to Bing.com"
$GoBingcom.Image = $logo_img

$Menu_Exit = New-Object System.Windows.Forms.ToolStripMenuItem
$Menu_Exit.Text = "Exit"
$Menu_Exit.Image = $quit_img

$contextmenu = New-Object System.Windows.Forms.ContextMenuStrip
$Main_Tool_Icon.ContextMenuStrip = $contextmenu
$Main_Tool_Icon.ContextMenuStrip.Items.AddRange($Openimg)
$Main_Tool_Icon.ContextMenuStrip.Items.AddRange($hr)
$Main_Tool_Icon.ContextMenuStrip.Items.AddRange($Openapp)
$Main_Tool_Icon.ContextMenuStrip.Items.AddRange($GoBingcom)
$Main_Tool_Icon.contextMenuStrip.Items.AddRange($Menu_Exit)

# When Exit is clicked, close everything and kill the PowerShell process
$Menu_Exit.add_Click({
	$Main_Tool_Icon.Visible = $false
    Stop-Process $pid
 })

$OpenApp.add_Click({
    Start-Process ./bpotd.exe
})

$GoBingcom.add_Click({
    Start-Process https://www.bing.com
})

# Make PowerShell Disappear
$windowcode = '[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
$asyncwindow = Add-Type -MemberDefinition $windowcode -name Win32ShowWindowAsync -namespace Win32Functions -PassThru
$null = $asyncwindow::ShowWindowAsync((Get-Process -PID $pid).MainWindowHandle, 0)

# Force garbage collection just to start slightly lower RAM usage.
[System.GC]::Collect()


# Create an application context for it to all run within.
# This helps with responsiveness, especially when clicking Exit.
$appContext = New-Object System.Windows.Forms.ApplicationContext
[void][System.Windows.Forms.Application]::Run($appContext)