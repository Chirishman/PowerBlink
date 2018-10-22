# PowerBlink
PowerShell module for controlling Blink(1) devices

## Usage Examples

### Setup

Run this before starting to work with the rest of the commands to open a communication session with the device(s).

```PowerShell
Initialize-Blink1Devices
```

### Basic Color Command

This example will set all LEDs on the first blink device (Device 0) to blue immediately

```PowerShell
Set-Blink1Color -DeviceNumber 0 -Color Blue
```

### Individual LED Control

This example demonstrates how to change the color of one of the two individually controllable RGB LEDs on a Blink(1)mk2 device. As is done in the native protocol, address 0 controls all LEDs (broadcast), address 1 controlls the first LED alone and address 2 the second.

```PowerShell
Set-Blink1Color -DeviceNumber 0 -Color Yellow -Address 1
```

### Fade Timing

The speed of transition to a new color can be specified using the `FadeTime` parameter which accepts millisecond values up to `[uint16]::MaxValue`

```PowerShell
Set-Blink1Color -DeviceNumber 0 -Color Green -FadeTime 100
```

### Basic Loop

```PowerShell
Set-Blink1Color -DeviceNumber 0 -Color White -Address 0
Start-Sleep -Milliseconds 500
while ($true) {
    Set-Blink1Color -DeviceNumber 0 -Color Green -Address 1 -FadeTime 100
    Set-Blink1Color -DeviceNumber 0 -Color Blue -Address 2 -FadeTime 100
    Start-Sleep -Seconds 2
    Set-Blink1Color -DeviceNumber 0 -Color Blue -Address 1 -FadeTime 100
    Set-Blink1Color -DeviceNumber 0 -Color Green -Address 2 -FadeTime 100
    Start-Sleep -Seconds 2
}
```