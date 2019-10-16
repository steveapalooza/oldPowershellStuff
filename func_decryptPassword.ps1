<#
.Synopsis
    Decrypts a string using a local certificate
        Accepts an encrypted string in base 64 format and returns the original string 
.Description
    
.Notes
    Name     		: func_decryptPassword.ps1
    Author   		: steve_whitlock@hotmail.com
    Lastedit 		: 6/13/2013
	Dependencies 	: Certificate that was used to encrypt the string passed to this function 
                      must reside on the server where this script executes with Private Key intact

.Example

Accepts an encrypted string in base 64 format:

    decryptPassword "MIIBsgYJKoZIhvcNAQcDoIIBozCCAZ8CAQAxggFjMIIBXwIBADBHMEAxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5HZW9UcnVzdCwgSW5jLjEYMBYGA1UEAxM
    PR2VvVHJ1c3QgU1NMIENBAgMBuD0wDQYJKoZIhvcNAQEBBQAEggEAfek7LVrxD0+ufZG7JVha+CsL5c6NNPpMKk0CFotXHF87zg+Iw2eDMncFare3GhO1nQ
    sQPWSpZ+G7HrePKrfrlQ1F9mx+zfwnRiSP2hWF0z6/cnVO89kbnm1wMVZYfHlZXdDHo8hsotc4+PgT5pdU53bzszph8aZQwP/8p8iz+l0n8Amr/8AF00jZF
    xLuOf05ZqDF+ToaESzEINKuBVecCLnkD1xE3e7tKPOvncVgoDD8NeUTWfmH034hu1031H7DIpSsP98ECfQZPyimX93NVRq0skbPvlRv5M2lZzeCs+U5WINx
    nDay5qj7sYHGoR4mAya+yjcOFTu0NIOHL3ZB9zAzBgkqhkiG9w0BBwEwFAYIKoZIhvcNAwcECPNx1/Zpcq7egBAaC4+jaSSQoaPwQS74d0cL"

Accepts a variable with a string:

    encryptPassword $securePassword
#>


function decryptPassword ($securePass){

            [System.Reflection.Assembly]::LoadWithPartialName("System.Security") | Out-Null
            $encryptedContent = [Convert]::FromBase64String($securePass)
            $objECms = New-Object Security.Cryptography.Pkcs.EnvelopedCms
            $objECms.Decode($encryptedContent)
            $objECms.Decrypt()
            $utf8content = [text.encoding]::UTF8.getstring($objECms.ContentInfo.Content)
            return $utf8content

}#end function decryptPassword
