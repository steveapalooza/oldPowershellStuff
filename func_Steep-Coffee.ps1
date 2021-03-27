
<#
    .SYNOPSIS
        
    .PARAMETER
        
    .PARAMETER
        
    .EXAMPLE
        Steep-Coffee -Seconds 30 -Message Please wait while coffe brews...
    .NOTES
        Author:            steve_whitlock@hotmail.com          
 
    #>

Add-Type -AssemblyName System.Windows.Forms

function Steep-Coffee {
   
    Param(

        [Int32]$Seconds = 60,
        [string]$Message = "Coffee is brewing..."

    )

    ForEach ($Count in (1..$Seconds)){   
    
        Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1

    }

    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
    [System.Windows.Forms.MessageBox]::Show('Coffee is Ready!', 'COFFEE TIME!', 'OK', 'Exclamation')
}

