@echo off
echo Updating EthernetENC_Broadcast library...

REM 1. Update all #include references
powershell -Command "Get-ChildItem -Recurse -Include *.h,*.cpp | ForEach-Object { (Get-Content $_.FullName -Raw) -replace '#include \"EthernetENC.h\"', '#include \"EthernetENC_Broadcast.h\"' | Set-Content $_.FullName -NoNewline }"
powershell -Command "Get-ChildItem -Recurse -Include *.h,*.cpp | ForEach-Object { (Get-Content $_.FullName -Raw) -replace '#include \"EthernetUdp.h\"', '#include \"EthernetENC_BroadcastUdp.h\"' | Set-Content $_.FullName -NoNewline }"

REM 2. Update class names
powershell -Command "Get-ChildItem -Recurse -Include *.h,*.cpp | ForEach-Object { (Get-Content $_.FullName -Raw) -replace 'class EthernetClass', 'class EthernetENC_BroadcastClass' | Set-Content $_.FullName -NoNewline }"
powershell -Command "Get-ChildItem -Recurse -Include *.h,*.cpp | ForEach-Object { (Get-Content $_.FullName -Raw) -replace 'EthernetClass::', 'EthernetENC_BroadcastClass::' | Set-Content $_.FullName -NoNewline }"

REM 3. Update global instance
powershell -Command "Get-ChildItem -Recurse -Include *.h,*.cpp | ForEach-Object { (Get-Content $_.FullName -Raw) -replace 'EthernetClass Ethernet;', 'EthernetENC_BroadcastClass EthernetENC_Broadcast;' | Set-Content $_.FullName -NoNewline }"

echo Updates complete!
pause
