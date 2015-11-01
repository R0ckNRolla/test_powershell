  $IsLocalAdmin = $false

  $hostname = hostname

  # get the name, SID, and domain of the current user
  $obj = [System.Security.Principal.WindowsIdentity]::GetCurrent()
  $CurrentUserName = $obj.Name
  $CurrentUserSID = $obj.User.Value
  try{
      $CurrentUserDomain = ((([adsi]'').distinguishedname -replace 'DC=','' -replace ',','.')[0]).ToLower()
  }
  catch {
      $CurrentUserDomain = $Null
  }

  # resolve the SID for the local admin group - this should usually default to "Administrators"
  $objSID = New-Object System.Security.Principal.SecurityIdentifier('S-1-5-32-544')
  $objgroup = $objSID.Translate( [System.Security.Principal.NTAccount])
  $GroupName = ($objgroup.Value).Split('\')[1] #(+)

  try{
      # enumerate all members of the local administrators group and check
      #   if the user is a member of the specified groups
      @($([ADSI]"WinNT://$hostname/$groupname").psbase.Invoke('Members')) | ForEach-Object {

          # get the name of the object
          $name =  ( $_.GetType().InvokeMember('Adspath', 'GetProperty', $null, $_, $null)).Replace('WinNT://', '').Replace("/","\").Replace("WORKGROUP\","")

          # check if this object is the current user
          if($name.ToLower() -eq $CurrentUserName.ToLower()){
              $IsLocalAdmin = $True
              Write-Verbose "[+] User $CurrentUserName is in the local administrators group!"
          }

          # check if this object is local or a part of the domain
          $Domain = -not $(($_.GetType().InvokeMember('Adspath', 'GetProperty', $null, $_, $null)).Replace('WinNT://', '')-like "*/$hostname/*")

          # check if the object is a group
          $IsGroup = ($_.GetType().InvokeMember('Class', 'GetProperty', $Null, $_, $Null) -eq 'group')

          if($IsGroup){
              if($Domain -and $CurrentUserDomain){

                  $GroupDomain = $name.split("\")[0]
                  $GroupName = $name.split("\")[1]

                  # resolve the netbiod domain name to a FQDN
                  $DomainFQDN = [System.Net.Dns]::GetHostByName($GroupDomain).Hostname.ToLower()

                  # make sure we get a domain back and the current user is a part of it
                  if(($DomainFQDN) -and ($CurrentUserDomain -eq $DomainFQDN)){
                      # if the current user is a part of this group, flag
                      $GroupUsers = $(Get-NetGroup -GroupName $GroupName -Domain $DomainFQDN)
                      if ($GroupUsers -contains ($CurrentUserName.split("\")[1])) {
                          $IsLocalAdmin = $True
                          # Write-Verbose "[+] User $CurrentUserName is in the domain group `"$name`"!"
                      }
                  }
              }
              else{
                  $GroupName = $name.split("\")[1]
                  # otherwise we have a local group, so restart the enumeration
                  @($([ADSI]"WinNT://$hostname/$GroupName").psbase.Invoke('Members')) | ForEach-Object {

                      $name =  ( $_.GetType().InvokeMember('Adspath', 'GetProperty', $null, $_, $null)).Replace('WinNT://', '').Replace("/","\")

                      # check if this object is the current user
                      if($name -eq $CurrentUserName){
                          $IsLocalAdmin = $True
                          # Write-Verbose "[+] User $CurrentUserName is in the local group `"$name`"!"
                      }
                  }
              }
          }
      }
  }
  catch {
      Write-Warning "[!] Error: $_"
  }

  return $IsLocalAdmin