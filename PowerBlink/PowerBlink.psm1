#handle PS2
    if(-not $PSScriptRoot)
    {
        $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
    }
    $ModuleRoot = $PSScriptRoot

#Get public and private function definition files.
    $Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
    $Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

#BlinkConstants
	$Global:Blink1Constant = @{
		VendorID  = 10168
		ProductID = 493
	}

#Dot source the files
    Foreach($import in @($Public + $Private))
    {
        Try
        {
            Write-Verbose -Message "Importing $($import.fullname)"
            . $import.fullname
        }
        Catch
        {
            Write-Error -Message "Failed to import $($import.fullname): $_"
        }
    }

Export-ModuleMember -Function ($Public | Select -ExpandProperty Basename)