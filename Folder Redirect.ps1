$newPath = "$env:userprofile\OneDrive - Columbus Consolidated Government"
$key1 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"  
$key2 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders"
$Desktop = [environment]::GetFolderPath("desktop")
$Documents = [environment]::GetFolderPath("mydocuments") 
$Pictures = [environment]::GetFolderPath("mypictures") 
$Videos = [environment]::GetFolderPath("myvideos") 
$Music = [environment]::GetFolderPath("mymusic") 

#Stops onedrive
Stop-Process -processname "OneDrive" -ErrorAction SilentlyContinue

#Sleep to give time to stop current onedrive
Start-Sleep -s 60

#Installs onedrive
Start-Process "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe" /reset -ErrorAction SilentlyContinue

#Sleeps to give time to install
Start-Sleep -s 60

#Launches onedrive
#User will have to log in
start odopen://sync?useremail=$env:USERNAME@columbusga.gov

#Sleeps for time to log into onedrive
start-sleep -s 60


#Create Folders in OneDrive Location
New-Item -path $newPath\Desktop -ItemType Directory 
New-Item -path $newPath\Documents -ItemType Directory
New-Item -path $newPath\Pictures -ItemType Directory
New-Item -path $newPath\Videos -ItemType Directory
New-Item -path $newPath\Music -ItemType Directory  

#Copy Files from current documents folder to new location
move-item -path $Desktop\* -destination $newPath\Desktop
move-item -path $Documents\* -destination $newPath\Documents
move-item -path $Pictures\* -destination $newPath\Pictures
move-item -path $Videos\* -destination $newPath\Videos
move-item -path $Music\* -destination $newPath\Music


#Redirect Desktop, Documents, Picures, Videos, Music to the above created folders
set-ItemProperty -path $key1 -name Desktop $newPath\Desktop  
set-ItemProperty -path $key2 -name Desktop $newPath\Desktop
set-ItemProperty -path $key1 -name Documents $newPath\Documents 
set-ItemProperty -path $key2 -name Documents $newPath\Documents
set-ItemProperty -path $key1 -name Personal $newPath\Documents 
set-ItemProperty -path $key2 -name Personal $newPath\Documents
set-ItemProperty -path $key1 -name "{F42EE2D3-909F-4907-8871-4C22FC0BF756}" $newPath\Documents 
set-ItemProperty -path $key1 -name "My Pictures" $newPath\Pictures
set-ItemProperty -path $key2 -name "My Pictures" $newPath\Pictures
set-ItemProperty -path $key1 -name "{0DDD015D-B06C-45D5-8C4C-F59713854639}" $newPath\Pictures
set-ItemProperty -path $key1 -name "My Video" $newPath\Videos
set-ItemProperty -path $key2 -name "My Video" $newPath\Videos
set-ItemProperty -path $key1 -name "{35286A68-3C57-41A1-BBB1-0EAE73D76C95}" $newPath\Videos
set-ItemProperty -path $key1 -name "{A0C69A99-21C8-4671-8703-7934162FCF1D}" $newPath\Music
set-ItemProperty -path $key1 -name "My Music" $newPath\Music
set-ItemProperty -path $key2 -name "My Music" $newPath\Music

#Kills explorere so it will refresh and use new settings 
taskkill.exe -f -im explorer.exe

#Relaunches explorer
explorer.exe





