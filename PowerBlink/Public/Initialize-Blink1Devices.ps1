function Initialize-Blink1Devices {
    Param(

    )

	List-Blink1Devices | %{
		$_.HIDInterface.OpenDevice()
		$_.Open = $_.HIDInterface.IsOpen
	}
}