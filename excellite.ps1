$docTemplate = ".\template.xlsx"
$doc = (Get-Item -Path $docTemplate -Verbose).FullName
if (! (test-path $doc))
{
    throw "$($doc) is not a valid path"
}

$msExcel = New-Object -Com Excel.Application #-strict
$msExcel.visible = $false 

$excelDoc = $msExcel.Workbooks.Open($doc)
$excelDoc.Activate()

$path = (Get-Item -Path ".\" -Verbose).FullName
$filename = $path + "\file.xlsx"
write-verbose "Document is saved to $($filename)"
$excelDoc.SaveAs($filename)
$excelDoc.Close()

$msExcel.Application.Quit()
