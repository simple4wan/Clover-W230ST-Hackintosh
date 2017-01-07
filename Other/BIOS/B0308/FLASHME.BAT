@echo off


@set BIOS.ROM=W230ST.08
:: Flash ME
fpt -f %BIOS.ROM% -l 0x200000 -y
if errorlevel 1 goto End

@if exist MSDM.BIN del MSDM.BIN   

::=======================
:: #define NG          0
:: #define PASS        1
:: #define ERR_FILE    2
:: #define ERR_NOMSDM  3
:: #define ERR_ACPI    4
:: #define ERR_CLEVO   5
::=======================
GMSDM.exe

if errorlevel 5 goto NoMessage 
if errorlevel 4 goto WithoutMessage
if errorlevel 3 goto NoMessage
if errorlevel 2 goto SaveMessageFail
if errorlevel 1 goto WithMessage
if errorlevel 0 goto Fail

goto  Help  

:NoMessage
goto    WithoutMessage   

:SaveMessageFail 
goto    End

:Fail
goto    End

:Help
goto    End   

:WithMessage

AFUDOS.exe %BIOS.ROM% /p /b /n /x
OAIDDOS MSDM.bin /OA
@if exist MSDM.BIN del MSDM.BIN
fpt /closemnf /y
AFUDOS.exe /s /shutdown 
goto   End 

:WithoutMessage

AFUDOS.exe %BIOS.ROM% /p /b /n /x
fpt /closemnf /y
AFUDOS.exe /s /shutdown 

goto   End 
:End
