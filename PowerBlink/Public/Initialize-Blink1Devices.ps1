function Initialize-Blink1Devices {
    Param(

    )

    Get-Blink1DeviceList | % {
        $_.HIDInterface.OpenDevice()
        $_.Open = $_.HIDInterface.IsOpen
    }
}