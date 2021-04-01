<#
    .SYNOPSIS
        Accepts a string input and determines the first repeating character in the string
    .NOTES
        Name     		: func_Find-FirstRepeatingCharInString.ps1
        Author   		: steve_whitlock@hotmail.com
        Lastedit 		: 3/24/2021
	    Dependencies 	: None
        
    .PARAMETER
        -charString 
        Specifies a string for the script to evaluate
        
    .EXAMPLE
        Find-FirstRepeatingCharInString -charString 'abcdedcba'
               
 
    #>

function Find-FirstRepeatingCharInString {

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [ValidateScript({$_ -is [System.String]})] 
        [ValidateNotNull()]
        [string]$charString = ''
        )
    BEGIN {
        
        $objarrayinfo = @()

    }
    PROCESS {
        for($i = 0; $i -lt $charString.Length; $i++) {

            if($objarrayinfo -contains $charString[$i]) {

                return $charString[$i]

            }
            else {

                $objarrayinfo += $charString[$i]

            }
        }   
    }
}

                
