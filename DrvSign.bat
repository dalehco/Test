@ECHO OFF
REM DrvSign.bat
REM This batch program will build and sign the driver package. 
REM It requires the following parameters.
REM		Arg1: Current Directory to execute from
REM		Arg2: Path to the driver package
REM		Arg3: Version
REM 
REM Timestamp the inf files
ECHO
CLS
call %1\SDK\stampinf -f  %2\LDFsf.inf -d * -v %3

REM Sign the drivers
call %1\SDK\signtool sign /v /ac "%1\SDK\DigiCert High Assurance EV Root CA.crt" /s my /n "DERRY TECHNOLOGICAL SERVICES" /t http://timestamp.digicert.com %2\LDFsf.sys

REM Create A CAT Files
call %1\SDK\inf2cat.exe /driver:%2 /os:"7_x64"

REM Sign the CAT files
call %1\SDK\signtool sign /v /ac "%1\SDK\DigiCert High Assurance EV Root CA.crt" /s my /n "DERRY TECHNOLOGICAL SERVICES" /t http://timestamp.digicert.com %2\derry.cat

REM Exit the main program
exit /B