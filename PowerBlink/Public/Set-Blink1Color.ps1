function Set-Blink1Color {
    Param(
		[Parameter()]
		[Int]$DeviceNumber,
        [Parameter()]
		[System.Drawing.Color]$Color,
		[Parameter()]
		[ValidateRange(0, 2)]
		[int16]$Address = 0
    )

	$Global:HidDevices | ?{$_.Id -eq $DeviceNumber} | % {
		if ((-not $_.HIDInterface.IsOpen) -and $_.HIDInterface.IsConnected) {
			$_.HIDInterface.OpenDevice()
		}

		$BufferMax = $_.HIDInterface.Capabilities.FeatureReportByteLength
		[byte[]]$InputBuffer = [byte[]]::CreateInstance([byte], $BufferMax)

		$Color.ToARGB()

		$InputBuffer[0] = [Convert]::ToByte(1);
		$InputBuffer[1] = [Convert]::ToByte([char]'c');
		$InputBuffer[2] = [Convert]::ToByte($Color.R); #Red
		$InputBuffer[3] = [Convert]::ToByte($Color.G); #Green
		$InputBuffer[4] = [Convert]::ToByte($Color.B); #Blue
		$InputBuffer[5] = [Convert]::ToByte(3); #TH Fadetime
		$InputBuffer[6] = [Convert]::ToByte(2); #TL Fadetime
		$InputBuffer[7] = [Convert]::ToByte(1); #LED Number

		$_.HIDInterface.WriteFeatureData($InputBuffer)
	}

	<#
		[ValidateRange(0, 255)]
		[int16]$Red,
		[ValidateRange(0, 255)]
		[int16]$Green,
		[ValidateRange(0, 255)]
		[int16]$Blue,
	#>
}