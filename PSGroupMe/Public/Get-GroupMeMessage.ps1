function Get-GroupMeMessage {
<#
.SYNOPSIS
	get group messages 
.DESCRIPTION
    Retrives group messages 
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
        [int]$Limit = 50,
        [String]$BeforeID,
        [String]$SinceID,
        [String]$AfterID,
        [string]$GUID = (New-Guid).Guid,
        [String]$rest_path = "v3/groups/$GroupID/messages"
    )
    $Param = "?limit=$($limit)"
    if ($BeforeID){ $Param = "$($Param)&before_id=$($BeforeID)" }
    elseif ($SinceID){ $Param = "$($Param)&since_id=$($SinceID)" }
    elseif ($AfterID){ $Param = "$($Param)&after_id=$($AfterID)" }
    
    Invoke-GroupMeAPI -rest_path "$($rest_path)$($Param)" -Method Get
}