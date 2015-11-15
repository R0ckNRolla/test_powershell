function My-Change-Dlls
{
<#
.SYNOPSIS

    Change or restore all dll files to the given one
 
.DESCRIPTION

    Rewrites all dll files in -Path to the given -DllName file. Restores them all from .bak-files with -Restore option

.EXAMPLE

    PS C:\> My-Change-Dlls -Path ./ -DllName my.dll

.EXAMPLE

    PS C:\> My-Change-Dlls -Path ./ -Restore
    
.LINK
    
    https://www.github.com/tguglanaklona
#>
    
    [CmdletBinding()]
    Param(
        [string]
        $Path = "./",

        [string]
        $DllName,

        [Switch]
        $Restore
    )

    $b = ((-not($Restore) -and (-not($DllName))))

    if ($b){ 
        Throw "You must supply a value for -DllName or set -Restore" 
    }

    ## test
    #get-childitem $Path
    #if (-not($Restore)){
    #    write-host $DllName 
    #}
    ## end test

}