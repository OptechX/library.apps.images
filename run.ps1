# setup
if (Test-Path -Path _tmp){ Remove-Item -Path _tmp -Recurse -Confirm:$false -Force }
git clone https://github.com/optechx/library.apps _tmp
".github","lib" | ForEach-Object { Remove-Item -Path ./_tmp/$_ -Recurse -Force -Confirm:$false }
Get-ChildItem -Path ./_tmp -File -Force | ForEach-Object { Remove-Item -Path $_.FullName -Confirm:$false -Force }
"*.ps1","*.md","*.xml","*.json" | ForEach-Object {
    Get-ChildItem -Path ./_tmp -Recurse -File -Filter $_ | ForEach-Object { 
        Remove-Item -Path $_.FullName -Confirm:$false -Force
    }
}

# convert all SVG to PNG images (if not already so)
$inkscape = $(which inkscape)
Get-ChildItem -Path ./_tmp -Recurse -File -Filter "*.svg" | ForEach-Object {
    $old_name = $_.FullName
    $new_name = $_.FullName.Replace(".svg",".png")
    & $inkscape --export-type png --export-filename $new_name -w 1024 $old_name
}

# move all newly created files
Get-ChildItem -Path ./_tmp -Recurse -File -Filter "*.png" | ForEach-Object {
    $current_path = $_.FullName.Replace('^.*_tmp','')
    $new = $current_path -replace "^.*?_tmp/", "./"

    Move-Item -Path $current_path -Destination $new -Force -Confirm:$false
}

# clean up
if (Test-Path -Path _tmp){ Remove-Item -Path _tmp -Recurse -Confirm:$false -Force }