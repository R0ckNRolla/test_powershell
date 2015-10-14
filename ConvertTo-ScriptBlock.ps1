function ConvertTo-ScriptBlock {
   param ([string]$string)
   $scriptblock = $executioncontext.invokecommand.NewScriptBlock($string)
   return $scriptblock
}