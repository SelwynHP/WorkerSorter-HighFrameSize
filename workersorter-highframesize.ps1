$targetFramesize = 6000000
#Get files from dir
$fList = (Get-ChildItem *.avi, *.divx, *.dvx, *.f4p, *.f4v, *.fli, *.flv,
 *.mp4, *.mov, *.m4v, *.mpg, *.mpeg, *.wmv, *.mkv, *.xvid -File)
 #Identify framesize of each file
foreach($var in $fList){
    $framesize = -1
    # ffprobe returns framesize as a String representing the video dimensions(i.e. 1280x720)
    # we split the string to later perform a multiplication to get the framesize
    $fr = $(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 $var.FullName).Split('x')
    # performing multiplication to get framesize
    $framesize = $($fr[0] -as [int]) * $($fr[1] -as [int])
    $path = $('.\'+'4K+')
    if($(Test-Path $path) -ne $true){New-Item -Path $path -ItemType Directory}
#Move files based on condition
    if($framesize -ge $targetFramesize -and $framesize -gt -1)
    {
        Move-Item $var.FullName.Replace("[", "``[").replace("]", "``]") $path
    }#closes if statement (framerate)
}#closes foreach