﻿#Again, Udemy doesn't allow me to post ps1 files, so I've attached it as a text file. 
#Either rename the file with a .ps1 extension or copy and paste the contents into a blank PowerShell ISE window.

#Parameters
#The script should take 2 arguments $source and $destination (for the source and destination folders).

param([string]$source="C:\Users\rudra\OneDrive\Desktop\Work\PowerShell\Tom_Meservy_Udemy\Script_Testing",
      [string]$destination="C:\Users\rudra\OneDrive\Desktop\Work\PowerShell\Tom_Meservy_Udemy\Script_Testing\destination")


#Functions
#2)	Functions

#Create a function named CheckFolder that checks for the existence of a specific directory/folder that is passed 
#to it as a parameter. Also, include a switch parameter named create. If the directory/folder does not exist and 
#the create switch is specified, a new folder should be created using the name of the folder/directory that was 
#passed to the function.

function CheckFolder([string]$path, [switch]$create){
    $exists = Test-Path $path

    if(!$exists -and $create){
        #create the directory because it doesn't exist
        mkdir $path | out-null
        $exists = Test-Path $path
    }
    return $exists
}

CheckFolder $path

#Create a function named DisplayFolderStatistics to display folder statistics for a directory/path that is passed 
#to it. Output should include the name of the folder, number of files in the folder, and total size of all files in 
#that directory.

function DisplayFolderStats([string]$path){
 $files = dir $path -Recurse | where {!$_.PSIsContainer}
 $totals = $files | Measure-Object -Property length -sum
 $stats = "" | Select path,count,size
 $stats.path = $path
 $stats.count = $totals.count
 $stats.size = [math]::round($totals.sum/1MB,2)
 return $stats
}



#3)	Main processing

#a) Test for existence of the source folder (using the CheckFolder function).
$sourceexists = CheckFolder $source

if (!$sourceexists){
    Write-Host "The source directory is not found. Script can not continue."
    Exit
}

#b) Test for the existence of the destination folder; create it if it is not found (using the CheckFolder function 
#with the –create switch).Write-Host "Testing Destination Directory - $destination"

$destinationexists = CheckFolder $destination -create

if (!$destinationexists){
    Write-Host "The destination directory is not found. Script can not continue."
    Exit
}

#c) Copy each file to the appropriate destination.
#get all the files that need to be copied

$files = dir $source -Recurse | where {!$_.PSIsContainer}

#c-i) Display a message when copying a file. The message should list where the file is being
#moved from and where it is being moved to.
foreach ($file in $files){
    $ext = $file.Extension.Replace(".","")
    $extdestdir = "$destination\$ext"

    #check to see if the folder exists, if not create it
    $extdestdirexists = CheckFolder $extdestdir -create

    if (!$extdestdirexists){
        Write-Host "The destination directory ($extdestdir) can't be created."
        Exit
    }

    #move file
    move $file.fullname $extdestdir
}


#d) Display each target folder name with the file count and byte count for each folder.
$dirs = dir $destination | where {$_.PSIsContainer}

$allstats = @()
foreach($dir in $dirs){
    $allstats += DisplayFolderStats $dir.FullName
}

$allstats | sort size -Descending
