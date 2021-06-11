function Get-GroupMeGroups {
    <#
.SYNOPSIS
	Get all groups or group 
.DESCRIPTION
    Get all groups or group info from GroupID
.Parameter GroupID
    Get group information for spesific GroupID
.Parameter Limit
    Set the lmit of groups per page, default is 10
.Parameter Page
    Fetch a particular page of results, default is 1
.Parameter Page
    Comma separated list of data to omit from output. Currently supported value is only "memberships"
.Parameter rest_path
    Rest API for GroupMe 
.EXAMPLE
    PS>  Get-GroupMeGroups 
    PS>  Get-GroupMeGroups -GroupID <GroupID>
.EXAMPLE
    PS>  Get-GroupMeGroups -Former
.EXAMPLE
    PS>  Get-GroupMeGroups -Limit 1 -Page 2
#>
    [CmdletBinding()]
    Param(
        [parameter(Mandatory=$False,Position = 0)]
        [int]$GroupID,
        [Int]$Limit = 10,
        [int]$Page =1,
        [validateset('memberships')]
        [string[]]$Omit,
        [Switch]$Former,
        [String]$rest_path = "v3/groups"
    )
    
    if ($Former) {$rest_path = "$($rest_path)/former"}
    $Param = "?per_page=$($limit)"
    if ($Page){ $Param = "$($Param)&page=$($Page)" }
    if ($Omit){ $Param = "$($Param)&omit=$($omit -join ',')" }
    
    if ($GroupID){$rest_path = "$($rest_path.TrimEnd('/former'))/$($GroupID)"}

    Invoke-GroupMeAPI -rest_path "$($rest_path)$param" -Method get 
}
