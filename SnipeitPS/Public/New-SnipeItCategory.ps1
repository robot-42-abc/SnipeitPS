<#
.SYNOPSIS
Create a new Snipe-IT Category

.PARAMETER name
Name of new category to be created

.PARAMETER type
Type of new category to be created (asset, accessory, consumable, component, license)

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeItInfo command

.PARAMETER apiKey
User's API Key for Snipeit, can be set using Set-SnipeItInfo command

.PARAMETER use_default_eula
If switch is present, use the primary default EULA

.PARAMETER require_acceptance
If switch is present, require users to confirm acceptance of assets in this category

.PARAMETER checkin_email
If switch is present, send email to user on checkin/checkout

.EXAMPLE
New-SnipeItCategory -name "Laptops" -category_type asset -url "Snipe-IT URL here..." -apiKey "API key here..."
#>

function New-SnipeItCategory()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [parameter(mandatory = $true)]
        [ValidateSet("asset", "accessory", "consumable", "component", "license")]
        [string]$category_type,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey,

        [switch]$use_default_eula,

        [switch]$require_acceptance,

        [switch]$checkin_email
    )

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = @{
        "name"          = $name
        "category_type" = $category_type
    }

    if ($use_default_eula) {
        $Values += @{"use_default_eula" = $true}
    }

    if ($require_acceptance) {
        $Values += @{"require_acceptance" = $true}
    }

    if ($checkin_email) {
        $Values += @{"checkin_email" = $true}
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/categories"
        Method = 'POST'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}