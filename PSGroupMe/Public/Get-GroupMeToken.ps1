Function Get-GroupMeToken {
    <#
    .SYNOPSIS
        Create GroupMe Token from Creds and stores the Rest_Host url
    .DESCRIPTION
        Create GroupMe token for accessing the API and set the rest path for other functions in the PSGroupMe module as object GroupMeToken
    .Parameter Credential
        Store username / password to request token or create basic auth.
    .Parameter rest_host
        Host address of GroupMe Instance default is api.groupme.com
    .Parameter rest_path
        Rest API path 
    .Example
        Get-GroupMeToken -Credential 'API Token'
    .NOTES
        NAME: John Burdick


    #>
    [CmdletBinding()]
    param (
        [parameter(HelpMessage="Enter the Credintials for GroupMe API",Position=0,ParameterSetName="Input")]
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,
        [string]$rest_host = 'api.groupme.com'
    )

    if ( !$Credential ){
            Write-Verbose "Enter Credential for GroupMe API account"
            Try { $Credential = Get-Credential -Message 'Enter GroupMe API Token' -ErrorAction Stop }
            Catch { Write-Warning "Need Credential info to create token." ; return  }
    }

    Write-Verbose "Credential $($Credential.username) will be used to create Authorization token"

    $rest_host = $rest_host -replace 'http.*/',''
    Remove-Variable gobal:GroupMe -ErrorAction SilentlyContinue
    
    $Global:GroupMetoken = [PSCustomObject]@{
        'Creds' = $Credential
        'DT' = get-date
        'Rest_Host' = $rest_host
    }
    Write-Verbose "Token was created at $($Global:GroupMetoken.dt)"
}#function