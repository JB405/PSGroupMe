function Remove-GroupMeGroup {
<#
.SYNOPSIS
	Removes a group
.DESCRIPTION
    Disband a group by groupid This action is only available to the group creator
.Parameter GroupID
    GroupId to remove
.Parameter rest_path
    Rest API for GroupMe 
.EXAMPLE
    PS>   Remove-GroupMeGroup -GroupID <GroupID> 
    

#>
    [CmdletBinding()]
    Param(
        [parameter(Mandatory=$true,Position = 0)]
        [int]$GroupID,
        
        [String]$rest_path = "v3/groups/$GroupID/destroy"
    )
    
    Invoke-GroupMeAPI -rest_path "$($rest_path)" -Method Post
}
