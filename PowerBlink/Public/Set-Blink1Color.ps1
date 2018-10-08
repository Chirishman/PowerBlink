function Set-Blink1Color {
    Param(
		[Parameter(Mandatory)]
		[Int]$DeviceNumber,
        [Parameter(Mandatory)]
		[System.Drawing.Color]$Color,
		[Parameter()]
		[ValidateRange(0, 65535)]
		[UInt16]$FadeTime = 0,
		[Parameter()]
		[ValidateRange(0, 2)]
		[int16]$Address = 0
    )

	$Global:HidDevices | ?{$_.Id -eq $DeviceNumber} | % {
		if ((-not $_.HIDInterface.IsOpen) -and $_.HIDInterface.IsConnected) {
			$_.HIDInterface.OpenDevice()
		}

		$BufferMax = $_.HIDInterface.Capabilities.FeatureReportByteLength
		#[byte[]]$InputBuffer = [byte[]]::CreateInstance([byte], $BufferMax)

		#Convert FadeTime to Bytes
		[byte[]]$FadeTimeBytes = [System.BitConverter]::GetBytes($FadeTime)
		#Convert Bytes to Big Endian
		[Array]::Reverse($FadeTimeBytes)

		$InputBuffer = [byte[]]@(
			1,
			([char]'c'),
			$Color.R,
			$Color.G,
			$Color.B,
			$FadeTimeBytes[0],
			$FadeTimeBytes[1],
			$Address
		)

		$_.HIDInterface.WriteFeatureData($InputBuffer)
	}
}