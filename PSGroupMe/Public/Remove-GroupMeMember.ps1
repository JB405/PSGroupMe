function Remove-GroupMeMember {
<#
.SYNOPSIS
	Remove a member from a group
.DESCRIPTION
    Removes a member from a group
.Parameter GroupID
    GroupId to remove
.Parameter MembersID
    The ID of the user from the Membership object not the User_ID
.Parameter rest_path
    Rest API for GroupMe 
.EXAMPLE
    S>   Remove-GroupMeMember -GroupID <GroupID>  -MembersID <MembersID>
    
#>
    [CmdletBinding(DefaultParametersetName='update')]
    Param(
        [parameter(Mandatory=$true,Position = 0)]
        [int64]$GroupID,
        [parameter(Mandatory=$true,Position = 1)]
        [int64]$MembersID,
        [String]$rest_path = "v3/groups/$GroupID/members/$MembersID/remove"
    )
    
    Invoke-GroupMeAPI -rest_path "$($rest_path)" -Method Post 
}

