function Get-Blink1DeviceList {
    Param(
        [hidlibrary.hiddevice[]]$HidDevices = [hidlibrary.hiddevices]::Enumerate($Global:Blink1Constant.VendorID, $Global:Blink1Constant.ProductID)
    )

    if ($HidDevices.Count) {
        0..($HidDevices.Count - 1) | Select @{N = 'Id'; E = {$_}}, @{N = 'Open'; E = {$HidDevices[$_].IsOpen}}, @{N = 'Connected'; E = {$HidDevices[$_].IsConnected}}, @{N = 'HIDInterface'; E = {$HidDevices[$_]}}, @{N = 'DevicePath'; E = {$HidDevices[$_].DevicePath}} | Tee-Object -Variable Global:HidDevices
    }
}