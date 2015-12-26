$docTemplate = ".\template.docx"
$doc = (Get-Item -Path $docTemplate -Verbose).FullName
if (! (test-path $doc))
{
    throw "$($doc) is not a valid path"
}

$msWord = New-Object -Com Word.Application #-strict
$msWord.visible = $false

$wordDoc = $msWord.Documents.Open($doc)
$wordDoc.Activate()

$path = (Get-Item -Path ".\" -Verbose).FullName
#$filename = $path + "\file.docx"
$filename = $path + "\file.rtf"
write-verbose "Document is saved to $($filename)"
$wordDoc.SaveAs([REF]$filename)
$wordDoc.Close()

$msWord.Application.Quit()
