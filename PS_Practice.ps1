echo "*******Foreach***********"

1..10 | foreach { if($_ % 2) {"This number: $_ is odd"}}

echo "********Arrays**********"

$array1 = @("Rudra","Pratap")
$array2 = @("Shalu","Singh")

$array1[1]
$array2[0]


$all = $array1 + $array2
$all

echo "********Hash Tables(kind of Dict.)**********"

$hash1 = @{"Shalu"=22; "Rudra"=18}
$hash1["Shalu"]

$hash1["Shalu"] = "Sep"
$hash1["Shalu"]

$hash1["Rani"] = 26

$hash1

#Remove Item

$hash1.Remove("Rani")

echo "*******Foreach***********"

1..10 | foreach { if($_ % 2) {"This number: $_ is odd"}}

echo "********Arrays**********"

$array1 = @("Rudra","Pratap")
$array2 = @("Shalu","Singh")

$array1[1]
$array2[0]


$all = $array1 + $array2
$all

echo "********Hash Tables(kind of Dict.)**********"

$hash1 = @{"Shalu"=22; "Rudra"=18}
$hash1["Shalu"]

$hash1["Shalu"] = "Sep"
$hash1["Shalu"]

$hash1["Rani"] = 26

$hash1

#Remove Item

$hash1.Remove("Rani")

$hash1

$hash1.Count

echo "************Formatting Output ***************"

$files = dir
$files

$files | Format-List
$files | Format-List -Property name, creationtime, length

$files | Format-Table

get-process | format-table -property path, id, name, company

#******************************************************

Get-Process | Sort -Property Company | Format-Table -GroupBy Company

Get-Process | Sort -Property Company | Format-Table -Property path, processname, id -GroupBy Company -AutoSize




#*****************SAVING OUTPUT**********************************************************




cd .\OneDrive\Desktop\Work\PowerShell\Tom_Meservy_Udemy
Get-Process | Out-file processes.txt

notepad .\processes.txt

# **************************************************

Get-Process | ConvertTo-Html | Out-file processes.html

Invoke-Expression .\processes.html

# **************************************************
Get-Process | Export-Csv processes.csv
Invoke-expression .\processes.csv

#path can also be given here if want to save in some other directory

Get-Process | Export-Csv C:\Users\rudra\OneDrive\Desktop\Work\PowerShell\Tom_Meservy_Udemy\processes2.csv

Invoke-expression .\processes2.csv

#**************************************************

Get-Process |  ConvertTo-Json | Out-File processes.json

Invoke-expression .\processes.json

########### IMPORTING DATA (CSV) ################################

Invoke-Expression .\Census1000.csv

$file = Import-Csv .\Census1000.csv

$file

$file | Format-Table

$file | gm #(Get-member)


############### SORT DATA #########################

$file | sort -Property pcthispanic -Descending | Format-Table -Property Name, count, pcthispanic

$data | sort -property pcthispanic -Descending | select -First 1 | Format-Table -p name, count, pcthispanic

($data | sort -property pcthispanic -Descending)[0].name

############## FUNCTIONS #################################################

function Do-something
{
    4+5
}

Do-something

# **************************************

function Add-Numbers
{
    param([int]$num1, [int]$num2)
    $num1 + $num2
#    return $num1 + $num2
}

# Add-Numbers 123 567

# Add-Numbers -num2 1234 -num1 789

$Sum = Add-Numbers 2 4

$Sum += Add-Numbers 3 7

$Sum

##########################################

[math]::round((dir 'C:\users\rudra\OneDrive\Desktop\Office Work\' -Recurse | Measure-Object -Property Length -sum).sum/1MB,4)


<# dir -Recurse

 dir -Recurse | Measure-Object -Property length -Sum #>

#*********************************

function Get-dirInfo($dir_path)
{
    $result = Get-ChildItem $dir_path -Recurse | Measure-Object -Property length -Sum
    [math]::Round(($result).Sum/1GB,4)
}

Get-dirInfo C:\Users\rudra\Videos

# #########################################