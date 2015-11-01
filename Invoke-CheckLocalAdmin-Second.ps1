if(($(whoami /groups) -like "*S-1-5-32-544*").length -eq 0) {
    "[!] Current user not a local administrator!"
    return $false
}
else{
    return $true
}