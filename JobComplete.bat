Echo off
REM - Not using this Command Here, Doing it in TS Now
REM net use l: \\Server\Share\DiskWipeResults /user:Domain\User Password

for /F "skip=2 tokens=2 delims=," %%A in ('wmic systemenclosure get serialnumber /FORMAT:csv') do (set "serial=%%A")
set serial=%serial:~-15%

for /F "skip=2 tokens=2 delims=," %%A in ('wmic csproduct get vendor /FORMAT:csv') do (set "compvendor=%%A")


for /F "skip=2 tokens=2 delims=," %%A in ('wmic csproduct get name /FORMAT:csv') do (set "compname=%%A")

for /F "skip=2 tokens=2 delims=," %%A in ('wmic CPU get name /FORMAT:csv') do (set "CPUname=%%A")

for /F "skip=2 tokens=2 delims=," %%A in ('wmic computersystem get totalphysicalmemory /FORMAT:csv') do (set "memory=%%A")
set /a memory = memory / 1048576

for /F "skip=2 tokens=2 delims=," %%A in ('wmic diskdrive get size /FORMAT:csv') do (set "hddsize=%%A")
set hdd=%hddsize:~0,-4%
set /a hdd=hdd/1048576



set TimeStamp=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%

REM Creates Network Log File
echo. >>C:\Wipes\DiskWipeResults.txt
echo Date:     		%TimeStamp% >>C:\Wipes\DiskWipeResults.txt
echo Serial:   		%serial% >>C:\Wipes\DiskWipeResults.txt
echo Vendor:   		%compvendor% >>C:\Wipes\DiskWipeResults.txt
echo Model:    		%compname% >>C:\Wipes\DiskWipeResults.txt
echo CPU Type \ Speed:  	%CPUname% >>C:\Wipes\DiskWipeResults.txt
echo Memory:  		%Memory%MB >>C:\Wipes\DiskWipeResults.txt
echo HDD Size: 		%hdd%GB >>C:\Wipes\DiskWipeResults.txt
echo ____________________________________________________________ >>C:\Wipes\DiskWipeResults.txt


REM Creates Network Label for Machine
echo Vendor:   		%compvendor% >>C:\Wipes\DiskWipe-%serial%.txt
echo Model:    		%compname% >>C:\Wipes\DiskWipe-%serial%.txt
echo Serial:   		%serial% >>C:\Wipes\DiskWipe-%serial%.txt
echo CPU Type \ Speed:  	%CPUname% >>C:\Wipes\DiskWipe-%serial%.txt
echo Memory:  		%Memory%MB >>C:\Wipes\DiskWipe-%serial%.txt
echo HDD Size: 		%hdd%GB >>C:\Wipes\DiskWipe-%serial%.txt
echo. >>C:\Wipes\DiskWipe-%serial%.txt
echo. >>C:\Wipes\DiskWipe-%serial%.txt
echo DoD 5220.22-M sanitization Wipe using MS SDELETE - 3 Passes >>C:\Wipes\DiskWipe-%serial%.txt
echo Date Sanitzed:	%TimeStamp% >>C:\Wipes\DiskWipe-%serial%.txt
echo. >>C:\Wipes\DiskWipe-%serial%.txt
echo. >>C:\Wipes\DiskWipe-%serial%.txt