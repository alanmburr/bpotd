Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$Main_Tool_Icon = New-Object System.Windows.Forms.NotifyIcon
$Main_Tool_Icon.Text = "bpotd"
$Main_Tool_Icon.Visible = $true

Invoke-WebRequest -Uri "https://www.google.com/favicon.ico" -ContentType "image/vnd.microsoft.icon" -OutFile $env:TEMP/bpotd.ico
$Main_Tool_Icon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($env:TEMP+'/bpotd.ico')

$Test_Thingy = New-Object System.Windows.Forms.ToolStripMenuItem
$Test_Thingy.Text = "Hello"
$Test_Thingy.Image = [System.Drawing.Icon]::ExtractAssociatedIcon($env:TEMP+'/bpotd.ico')

$Menu_Exit = New-Object System.Windows.Forms.ToolStripMenuItem
$Menu_Exit.Text = "Exit"

$contextmenu = New-Object System.Windows.Forms.ContextMenuStrip
$Main_Tool_Icon.ContextMenuStrip = $contextmenu
$Main_Tool_Icon.ContextMenuStrip.Items.AddRange($Test_Thingy)
$Main_Tool_Icon.contextMenuStrip.Items.AddRange($Menu_Exit)

# When Exit is clicked, close everything and kill the PowerShell process
$Menu_Exit.add_Click({
	$Main_Tool_Icon.Visible = $false
    Stop-Process $pid
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