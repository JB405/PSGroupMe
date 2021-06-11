function New-GroupMeGroup {
    <#
.SYNOPSIS
	Creates group
.DESCRIPTION
    Creates a new group in groupMe
.Parameter Name
    primary name of Group, maximum 140 characters
.Parameter Description
    subheading fro group, maximum 255 characters
.Parameter Image_URL
    Group me Image Service URL
.Parameter Share
    Generate a share URL anybody with the URL can join the group
.Parameter rest_path
    Rest API for GroupMe 
.EXAMPLE
    PS>   New-GroupMeGroup -GroupName 'MyFamily' -Description 'Keeping in touch -Share -Image_URL  'https://i.groupme.com/123456789'
    

#>
    [CmdletBinding()]
    Param(
        [parameter(Mandatory=$true,Position = 0)]
        [ValidateLength(1,140)]
        [String]$GroupName,
        [parameter(Mandatory=$false,Position = 0)]
        [ValidateLength(1,255)]
        [String]$Description,
        [int]$Image_Url,
        [Switch]$Share,
        [String]$rest_path = "v3/groups"
    )
    $BodyObj = [PSCustomObject]@{ Data = @{} }
    $BodyObj.Data.add( 'name' , $GroupName )
    if ( $Description ) { $BodyObj.Data.add( 'description' , $Description ) }
    if ( $Image_Url ) { $BodyObj.Data.add( 'image_url' , $Image_URL ) }
    if ( $Share ) { $BodyObj.Data.add( 'share' , $true ) }

    $Body = $BodyObj.Data | ConvertTo-Json -Depth 20 
    Write-Verbose $Body    
    Invoke-GroupMeAPI -rest_path "$($rest_path)$param" -Method Post  -Body $Body
}
