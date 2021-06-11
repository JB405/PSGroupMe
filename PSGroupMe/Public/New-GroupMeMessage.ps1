function New-GroupMeMessage {
<#
.SYNOPSIS
	Create a group member
.DESCRIPTION
    Creates a group member in a group
.Parameter GroupID
    GroupId to remove
.Parameter rest_path
    Rest API for GroupMe 
.EXAMPLE
    PS>   New-GroupMeMember -GroupID <GroupID>  
    
#>
    [CmdletBinding()]
    Param(
        [parameter(Mandatory=$true,Position = 0)]
        [int64]$GroupID,
        [parameter(Mandatory=$true,Position = 1)]
        [ValidateLength(1,1000)]
        [string]$Message,
        [string]$GUID = (New-Guid).Guid,
        [String]$rest_path = "v3/groups/$GroupID/messages"
    )
    $BodyObj = [PSCustomObject]@{ message = @{} }
    $BodyObj.message.add( 'source_guid' , "$($GUID)" )
    $BodyObj.message.add( 'text' , $Message )
    
    $Body = $BodyObj |ConvertTo-Json -Depth 20
    Write-Verbose $Body
    Invoke-GroupMeAPI -rest_path "$($rest_path)" -Method Post  -Body $body
}