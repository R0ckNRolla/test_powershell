function Rewrite-AllDlls
{
<#
.SYNOPSIS

    Rewrites and restores .dlls to the given one
 
.DESCRIPTION

    Rewrites all .dll files in -Path to the given one. Saves original to .bak. 
    Replacement is given by -Dll pathname.
    
    -Restore option restores all changed dlls from .bak files

.EXAMPLE

    PS C:\> Rewrite-AllDlls -Path ./ -Dll c:\my32or64.dll

.EXAMPLE

    PS C:\> Rewrite-AllDlls -Path ./ -Restore
    
.LINK
    
    https://www.github.com/tguglanaklona
#>
    
    [CmdletBinding()]
    Param(
        [string]
        $Path = "./",

        [string]
        $Dll,

        [Switch]
        $Restore
    )

    set-strictmode -version 2.0


$b = ($Restore -or $Dll)
if (-not $b){ 
    Throw "You must supply a value for -Dll or set -Restore" 
}

if ($Path){
    $Path = $Path -replace '/', '\'
    if ($Path[$Path.length-1] -ne '\') {
        $Path = $Path + '\'
    }
    if (-not(Test-Path($Path))){
        Throw "Bad value of $Path"
    }
}
if ($Dll){
    if (-not(Test-Path($Dll))){
        Throw "The file $Dll does not exist"
    }
}


# Rewrite mode
if (-not($Restore)){
    foreach ($row in (Get-ChildItem $Path*.dll)){
        $fn = $row.Name; $fileFullName = $Path + $fn
                
        
        if (($Dll) -and (-not $fileFullName.Equals($Dll))){
            try{
                copy-item $fileFullName $fileFullName".bak"
                write-verbose $fn" (32-bit) is saved to "$fn".bak"
                copy-item $Dll $fileFullName -Force -ErrorAction SilentlyContinue
                write-verbose $fn" is changed by "$Dll
            }
            catch [System.IO.IOException]{
                write-verbose $fn" CATCHED HERE"

            }
        }       
        

    }
}
# Restore mode
else{

}
}

