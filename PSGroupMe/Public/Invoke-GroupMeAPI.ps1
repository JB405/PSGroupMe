function Invoke-GroupMeAPI
{
    <#
.SYNOPSIS
	Invok request for GroupMe API
.DESCRIPTION
    invoke restmethod API for GroupMe
.Parameter rest_path
    API Rest Path
.EXAMPLE
    PS>  Invoke-GroupMeAPI
#>
    [CmdletBinding()]
    Param(
        [string]$rest_path = 'v3/groups/former',
        [ValidateSet('Get','Post','Put','Patch','Delete')]
        [String]$Method = 'Get',
        [String]$Body
    )
    if (!$GroupMeToken){
        Get-GroupMeToken
    }
    #strip uri and only get the endpoint
    $rest_path= ($rest_path -replace 'http.*.com/','').TrimStart('/')

    #add-type "using System.Net; using System.Security.Cryptography.X509Certificates; public class TrustAllCertsPolicy : ICertificatePolicy { public bool CheckValidationResult(ServicePoint srvPoint, X509Certificate certificate,WebRequest request, int certificateProblem) {return true;}}"
    #[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
    #[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add('X-Access-Token' , $GroupMeToken.Creds.GetNetworkCredential().password)
    $headers.Add('content-type' , 'application/json')
    $headers.Add('Accept' , 'application/json')
    [uri]$URI = "https://$($GroupMeToken.Rest_Host)/$($rest_path)"
    try
    {
       switch ($Method){
        'Post' {$Response = Invoke-RestMethod -Uri $URI -Method $Method -Headers $Headers -Body $Body}
        default{$Response = Invoke-RestMethod -Uri $URI -Method $Method -Headers $Headers}
       }#Switch
        $Response
    }

    catch
    {
        #Write-error "$Response returned an error."
        write-error  "Status code: $($_.Exception.Response.StatusCode.value__)  `nException message: $_.Exception.Message "
    }

}