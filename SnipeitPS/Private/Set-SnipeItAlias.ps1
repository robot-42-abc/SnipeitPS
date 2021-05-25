function Set-SnipeItAlias()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param()
    Write-Verbose "Setting compatibility aliases.. "
    Write-Verbose "All aliases are deprediated."
    $SnipeItAliases = get-SnipeItAlias
    ForEach ($key in $SnipeItAliases.Keys ) {
        New-Alias -Name $key -Value $($SnipeItAliases[$key]) -Scope 1
        Write-Verbose ("{0,5} -> {1}" -f $key,$($SnipeItAliases[$key]))
    }
    Write-Verbose "Please start using native 'SnipeIt' prfixed functions instead."
    Get-Command -Module SnipeItPS -CommandType Alias | Select-Object -Property DisplayName,ResolvedCommand

}