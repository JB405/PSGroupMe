function Set-GroupMeGroup {
    <#
.SYNOPSIS
	Update group details
.DESCRIPTION
    Set group settings
.Parameter Name
    primary name of Group, maximum 140 characters
.Parameter Description
    subheading fro group, maximum 255 characters
.Parameter Image_URL
    Group me Image Service URL
.Parameter UnShare
    Remvoes share URL, will take presidence of Share
.Parameter Share
    Generate a share URL anybody with the URL can join the group
.Parameter rest_path
    Rest API for GroupMe 
.EXAMPLE
    PS>   Set-GroupMeGroup -GroupID <GroupID> -GroupName 'MyFamily' -Description 'Keeping in touch -Share -Image_URL  'https://i.groupme.com/123456789' -OfficeMode
    

#>
    [CmdletBinding()]
    Param(
        [parameter(Mandatory=$true,Position = 0)]
        [int]$GroupID,
        [parameter(Mandatory=$false,Position = 1)]
        [ValidateLength(1,140)]
        [String]$GroupName,
        [parameter(Mandatory=$false,Position = 2)]
        [ValidateLength(1,255)]
        [String]$Description,
        [int]$Image_Url,
        [Switch]$OfficeMode,
        [Switch]$Share,
        [Switch]$UnShare,
        [String]$rest_path = "v3/groups/$GroupID/update"
    )
    $BodyObj = [PSCustomObject]@{ Data = @{} }
    if ($GroupName){ $BodyObj.Data.add( 'name' , $GroupName )}
    if ( $Description ) { $BodyObj.Data.add( 'description' , $Description ) }
    if ( $Image_Url ) { $BodyObj.Data.add( 'image_url' , $Image_URL ) }
    if ($UnShare) { $BodyObj.Data.add( 'share' , $false ) }
    else {
        if ( $Share ) { $BodyObj.Data.add( 'share' , $true ) }
    }
    if ($OfficeMode){ $BodyObj.Data.add( 'office_mode' , $true )  }
    else { $BodyObj.Data.add( 'office_mode' , $false ) }
    
    $Body = $BodyObj.Data | ConvertTo-Json -Depth 20 
    Write-Verbose $Body    
    Invoke-GroupMeAPI -rest_path "$($rest_path)$param" -Method Post  -Body $Body
}
