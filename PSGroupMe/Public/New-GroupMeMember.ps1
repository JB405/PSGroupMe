function New-GroupMeMember {
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
    PS>   New-GroupMeMember -GroupID <GroupID>  -NicName <Name> -Email <email>
    
#>
    [CmdletBinding(DefaultParametersetName='Phone')]
    Param(
        [parameter(Mandatory=$true,Position = 0)]

        [int64]$GroupID,
        [parameter(Mandatory=$true,Position = 1)]
        [String]$NicName,
        [parameter(Mandatory=$true,Position = 3,ParameterSetName='UserID')]
        [int64]$User_ID,
        [parameter(Mandatory=$true,Position = 3,ParameterSetName='Phone')]
        [ValidatePattern("\b\d{3}\d{3}\d{4}\b")]
        [int64]$CellPhone,
        [parameter(Mandatory=$true,Position = 3,ParameterSetName='Email')]
        [System.Net.Mail.MailAddress]$Email,
        [String]$rest_path = "v3/groups/$GroupID/members/add"
    )
    $BodyObj = [PSCustomObject]@{ Data = @{} }
    $BodyObj.Data.add( 'nickname' , $NicName )
    $BodyObj.Data.add( 'guid' , "$((New-Guid).Guid)" )
    if ( $CellPhone ) { $BodyObj.Data.add( 'phone_number' , "+1 $($CellPhone)" ) }
    if ( $Email ) { $BodyObj.Data.add( 'email' , $Email ) }
    if ( $User_ID ) { $BodyObj.Data.add( 'user_id' , "$($User_ID)" ) }
    $Body = "{ `"members`" : [ $($BodyObj.Data |ConvertTo-Json -Depth 20) ]  }"
    Write-Verbose $Body
    Invoke-GroupMeAPI -rest_path "$($rest_path)" -Method Post  -Body $body
}