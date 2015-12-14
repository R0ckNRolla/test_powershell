function Rewrite-Dlls
{
<#
.SYNOPSIS

    Rewrites and restores .dlls to the given one
 
.DESCRIPTION

    Rewrites all .dll files in -Path to the given one. Saves original to .bak. 
    Replacement is given by -Dll32 and -Dll64 pathnames according to executable type 32-bit/64-bit. Unknown bitness will not be rewrited.
    
    -Restore option restores all changed dlls from .bak files

.EXAMPLE

    PS C:\> Rewrite-Dlls -Path ./ -Dll32 c:\my32.dll -Dll64 c:\my64.dll

.EXAMPLE

    PS C:\> Rewrite-Dlls -Path ./ -Restore
    
.LINK
    
    https://www.github.com/tguglanaklona
#>
    
    [CmdletBinding()]
    Param(
        [string]
        $Path = "./",

        [string]
        $Dll32,

        [string]
        $Dll64,

        [Switch]
        $Restore
    )

    set-strictmode -version 2.0
    . "./Get-ExecutableType"


$b = ($Restore -and (-not($Dll32) -and -not($Dll64))) -or (-not($Restore) -and ($Dll32 -or $Dll64))
if (-not $b){ 
    Throw "You must supply a value for -Dll32 or -Dll64 or set -Restore" 
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
if ($Dll32){
    if (-not(Test-Path($Dll32))){
        Throw "The file $Dll32 does not exist"
    }
}
if ($Dll64){
    if (-not(Test-Path($Dll64))){
        Throw "The file $Dll64 does not exist"
    }
}


if ($Dll32){
    if ((Get-ExecutableType $Dll32) -ne "32-bit"){
        Throw "$Dll32 is not a 32-bit executable"
    }
}
if ($Dll64){
    if ((Get-ExecutableType $Dll64) -ne "64-bit"){
        Throw "$Dll64 is not a 64-bit executable"
    }
}


# Rewrite mode
if (-not($Restore)){
    foreach ($row in (Get-ChildItem $Path*.dll)){
        $fn = $row.Name; $fileFullName = $Path + $fn
        $type = Get-ExecutableType $fileFullName
        
        #write-host $fileFullName
        #write-host $Dll64
        #write-host $fileFullName.Equals($Dll64)

        switch ($type) 
        { 
            "32-bit" {
                if (($Dll32) -and (-not $fileFullName.Equals($Dll32))){
                    try{
                    copy-item $fileFullName $fileFullName".bak"
                    write-verbose $fn" (32-bit) is saved to "$fn".bak"
                    copy-item $Dll32 $fileFullName -Force -ErrorAction SilentlyContinue
                    write-verbose $fn" is changed by "$Dll32
                    }
                    catch [System.IO.IOException]{
                         write-verbose $fn" CATCHED HERE"

                    }
                }
            } 
            "64-bit" {
                if (($Dll64) -and (-not $fileFullName.Equals($Dll64))){
                    copy-item $fileFullName $fileFullName".bak"
                    write-verbose $fn" (64-bit) is saved to "$fn".bak"
                    copy-item $Dll64 $fileFullName -Force -ErrorAction SilentlyContinue
                    write-verbose $fn" is changed by "$Dll64
                }
            } 
            default {
                # do nothing
                write-verbose $fn" DO NOTHING"
            }
        }

    }
}
# Restore mode
else{

}
}

