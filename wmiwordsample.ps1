function ipaddr
{
    param([string]$CompName)
    $wmi = Get-WmiObject -Query "SELECT * from Win32_NetworkAdapterConfiguration WHERE IPEnabled='true'" -ComputerName $CompName #-Credential $cred
    foreach ($nic in $wmi)
    {
        $nic.IPAddress
    }
}

function osver
{
    param([string]$CompName)
    $osver = Get-WmiObject -Query "SELECT Caption from Win32_OperatingSystem" -ComputerName $CompName #-Credential $cred
    $osver.Caption
}

# specify full path to the list of servers you want to scan.
$hostInputFile = "C:\sct\servers.txt"
if (! (test-path $hostInputFile))
{
    throw "$($hostInputFile) is not a valid path."
}

# specify fill path to the word doc where bookmarks are defined.
$docTemplate = "C:\sct\template.docx"
if (! (test-path $docTemplate))
{
    throw "$($docTemplate) is not a valid path"
}

$computers = Get-Content $hostInputFile

$msWord = New-Object -Com Word.Application
$msWord.visible = $true

foreach ($computer in $computers)
{
    $wordDoc = $msWord.Documents.Open($docTemplate)
    $wordDoc.Activate()
    
    #defines IP address input
    $objRange = $wordDoc.Bookmarks.Item("ip").Range
    $objRange.Text = ipaddr -CompName $computer
    $wordDoc.Bookmarks.Add("ip",$objRange)
    
    #defines OS version input
    $objRange = $wordDoc.Bookmarks.Item("osversion").Range
    $objRange.Text = osver -CompName $computer
    $wordDoc.Bookmarks.Add("osversion",$objRange)
    
    #defines hostname input (from the $computer value above)
    $objRange = $wordDoc.Bookmarks.Item("hostname").Range
    $objRange.Text = $computer
    $wordDoc.Bookmarks.Add("hostname",$objRange)
    
    # Save the document to disk and close it. CHange $filename path to suit your environment.
    $filename = "C:\sct\" + $computer + ".docx"
    $wordDoc.SaveAs([REF]$filename)
    $wordDoc.Close()
}

$msWord.Application.Quit()