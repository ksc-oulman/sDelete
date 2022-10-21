Echo offFORMAT
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
echo. >>.\logs\DiskWipeResults.txt
echo Date:     		%TimeStamp% >>.\logs\DiskWipeResults.txt
echo Serial:   		%serial% >>.\logs\DiskWipeResults.txt
echo Vendor:   		%compvendor% >>.\logs\DiskWipeResults.txt
echo Model:    		%compname% >>.\logs\DiskWipeResults.txt
echo CPU Type \ Speed:  	%CPUname% >>.\logs\DiskWipeResults.txt
echo Memory:  		%Memory%MB >>.\logs\DiskWipeResults.txt
echo HDD Size: 		%hdd%GB >>.\logs\DiskWipeResults.txt
echo ____________________________________________________________ >>.\logs\DiskWipeResults.txt


REM Creates Network Label for Machine
echo Vendor:   		%compvendor% >>.\logs\DiskWipe-%serial%.txt
echo Model:    		%compname% >>.\logs\DiskWipe-%serial%.txt
echo Serial:   		%serial% >>.\logs\DiskWipe-%serial%.txt
echo CPU Type \ Speed:  	%CPUname% >>.\logs\DiskWipe-%serial%.txt
echo Memory:  		%Memory%MB >>.\logs\DiskWipe-%serial%.txt
echo HDD Size: 		%hdd%GB >>.\logs\DiskWipe-%serial%.txt
echo. >>.\logs\DiskWipe-%serial%.txt
echo. >>.\logs\DiskWipe-%serial%.txt
echo DoD 5220.22-M sanitization Wipe using MS SDELETE - 3 Passes >>.\logs\DiskWipe-%serial%.txt
echo Date Sanitzed:	%TimeStamp% >>.\logs\DiskWipe-%serial%.txt
echo. >>.\logs\DiskWipe-%serial%.txt
echo. >>.\logs\DiskWipe-%serial%.txt