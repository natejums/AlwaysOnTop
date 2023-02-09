 $hotkey = "Ctrl+Shift"

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$notifyicon = New-Object System.Windows.Forms.NotifyIcon
$notifyicon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Process | Select-Object -First 1).Path)
$notifyicon.Visible = $true

$notifyicon.ContextMenu = New-Object System.Windows.Forms.ContextMenu
$notifyicon.ContextMenu.MenuItems.Add("Exit",{
    $notifyicon.Dispose()
    [System.Windows.Forms.Application]::Exit()
})

$script:onTop = $false
Function OnTop {
    param($sender,$event)
    if (-not $script:onTop) {
        $script:onTop = $true
        $sender.TopMost = $true
    }
    else {
        $script:onTop = $false
        $sender.TopMost = $false
    }
}

$keyboardHook = [System.Windows.Forms.KeyboardHook]::Start($hotkey, [System.Windows.Forms.KeyboardHookCallback]{OnTop $notifyicon $EventArgs})
[System.Windows.Forms.Application]::Run()


# This script uses the System.Windows.Forms assembly to create a Notify Icon in the system tray, and the System.Windows.Forms.KeyboardHook class to detect the hotkey press. The OnTop function is called when the hotkey is pressed and toggles the TopMost property of the Notify Icon, which will keep the window always on top. The hotkey is defined as Ctrl + Shift and can be changed by changing the value of the $hotkey variable. 
