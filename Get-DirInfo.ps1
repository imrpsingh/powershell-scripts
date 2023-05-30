#Parameters

param([string]$dir = "C:\Users\rudra")   # This dir is different from below parameter | This is global parameter

#Functions

function Get-dirInfo ($dir)
{

$result = Get-ChildItem $dir -Recurse | Measure-Object -Property length -Sum
return [math]::Round(($result).sum/1GB,4)

}

#Processing

Get-dirInfo $dir