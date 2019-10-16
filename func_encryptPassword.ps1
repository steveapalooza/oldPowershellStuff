<#
.Synopsis
    Encrypts a string using a local certificate
        Accepts an unencrypted string and returns an encrypted string 
        in base64 format that has been encrypted using the specified certificate
.Description
    
.Notes
    Name     		: func_encryptPassword.ps1
    Author   		: steve_whitlock@hotmail.com
    Lastedit 		: 6/13/2013
	Dependencies 	: Certificate for encryption must reside on same machine where this script executes

.Example

Accepts a string:

    encryptPassword "pass@word1"

Accepts a variable with a string:

    encryptPassword $password

Sample output:

    PS C:\Windows\system32> encryptPassword "Password123"
    MIIBsgYJKoZIhvcNAQcDoIIBozCCAZ8CAQAxggFjMIIBXwIBADBHMEAxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5HZW9UcnVzdCwgSW5jLjEYMBYGA1UEAxM
    PR2VvVHJ1c3QgU1NMIENBAgMBuD0wDQYJKoZIhvcNAQEBBQAEggEAh20l5ocu/xDVQMDJHGzwgPkIaZ/eU426cfYA0pzPsPh3Bzd9k4Q77jjXCtCj4y9VQb
    yZ+5ZQsvBKaZ+m3qssTAPvoJaBfh/3QOgygHbcRkISsb6tP8gOLhQVtoE7/XfF6NPRhXsOwUVI21LCxLI4XvnqHtJRxrveQ586B7q5hHsRfLBwuR1YJ8aZ9
    M9OT0PX2V2EFUNKgibZkpqx/maDkoHQv6/tORONu5zYBoPSL4Vaq1f2JDbRs9NmJGBLy6V7j1+cR7NpdvWIebZtFjouyvwU1jBf13eQs+unwvUeiUpBnUV9
    PVr+d1HxAa17+KZD1wOjFTcwFJZtsNaKpX4mTjAzBgkqhkiG9w0BBwEwFAYIKoZIhvcNAwcECEjW9lgiZ+xPgBCh/CXtiT0L6D5RZIxvi1k3
    
#>


function encryptPassword ($unencryptedString){

    [System.Reflection.Assembly]::LoadWithPartialName("System.Security") | Out-Null
    $collection = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2Collection
    $certs = dir cert:\LocalMachine\My 
    $now = Get-Date 
    $certs | % { if(($_.NotAfter -gt $now) -and ($_.Issuer -notmatch "localhost")){$collection.Add($_)} } | Out-Null
    $cert = [System.Security.Cryptography.x509Certificates.X509Certificate2UI]::SelectFromCollection($collection, "", "Please select a certificate to use for the encryption", 0)
    
    $utf8content = [Text.Encoding]::UTF8.GetBytes($unencryptedString)
    $content = New-Object Security.Cryptography.Pkcs.ContentInfo -argumentList (,$utf8content)
    $env = New-Object Security.Cryptography.Pkcs.EnvelopedCms $content
    $recpient = (New-Object System.Security.Cryptography.Pkcs.CmsRecipient($cert))
    $env.Encrypt($recpient)
    $base64string = [Convert]::ToBase64String($env.Encode())

    return $base64string

}#end function encryptPassword
