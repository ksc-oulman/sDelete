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
echo. >>l:\DiskWipeResults.txt
echo Date:     		%TimeStamp% >>l:\DiskWipeResults.txt
echo Serial:   		%serial% >>l:\DiskWipeResults.txt
echo Vendor:   		%compvendor% >>l:\DiskWipeResults.txt
echo Model:    		%compname% >>l:\DiskWipeResults.txt
echo CPU Type \ Speed:  	%CPUname% >>l:\DiskWipeResults.txt
echo Memory:  		%Memory%MB >>l:\DiskWipeResults.txt
echo HDD Size: 		%hdd%GB >>l:\DiskWipeResults.txt
echo ____________________________________________________________ >>l:\DiskWipeResults.txt


REM Creates Network Label for Machine
echo Vendor:   		%compvendor% >>l:\DiskWipe-%serial%.txt
echo Model:    		%compname% >>l:\DiskWipe-%serial%.txt
echo Serial:   		%serial% >>l:\DiskWipe-%serial%.txt
echo CPU Type \ Speed:  	%CPUname% >>l:\DiskWipe-%serial%.txt
echo Memory:  		%Memory%MB >>l:\DiskWipe-%serial%.txt
echo HDD Size: 		%hdd%GB >>l:\DiskWipe-%serial%.txt
echo. >>l:\DiskWipe-%serial%.txt
echo. >>l:\DiskWipe-%serial%.txt
echo DoD 5220.22-M sanitization Wipe using MS SDELETE - 3 Passes >>l:\DiskWipe-%serial%.txt
echo Date Sanitzed:	%TimeStamp% >>l:\DiskWipe-%serial%.txt
echo. >>l:\DiskWipe-%serial%.txt
echo. >>l:\DiskWipe-%serial%.txt

REM Creates Local Log file that displays at end of Process

echo Disk Wipe Complete, Please Record Data for Records >>X:\Windows\JobComplete.txt
echo This computer has finished with a DoD 5220.22-M sanitization of the local hard drive. >>X:\Windows\JobComplete.txt
echo Please close this file and turn off the computer. >>X:\Windows\JobComplete.txt
echo. >>X:\Windows\JobComplete.txt
echo Date:     		%TimeStamp% >>X:\Windows\JobComplete.txt
echo Serial:   		%serial% >>X:\Windows\JobComplete.txt
echo Vendor:   		%compvendor% >>X:\Windows\JobComplete.txt
echo Model:    		%compname% >>X:\Windows\JobComplete.txt
echo CPU Type \ Speed:  	%CPUname% >>X:\Windows\JobComplete.txt
echo Memory:  		%Memory%MB >>X:\Windows\JobComplete.txt
echo HDD Size: 		%hdd%GB >>X:\Windows\JobComplete.txt
