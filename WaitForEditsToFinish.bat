@echo off
REM Configuration Variables
set search_dir=.\TestDir
set wait_seconds=5
set search_mask=*.*

REM Descriptive Output
set start_time=%date%
echo Script started at %date% %time%
echo Waiting until %search_mask% files in %search_dir% stop changing for %wait_seconds% seconds...]
echo.         

REM pseudocode
REM while last_edit_time != modif_time:
REM    last_edit_time = modif_time
REM    modif_time = latest edit time within directory
set last_edit_time=24:60:60
:loop
    REM modif_time = latest edit time within directory
    for /f "delims=" %%i in ('"forfiles /p %search_dir% /m %search_mask% /c "cmd /c echo @ftime" "') do set modif_time=%%i

    REM Base case
    if "%modif_time%" == "%last_edit_time%" (
        goto exitloop
    )

    set last_edit_time=%modif_time%
    timeout /t %wait_seconds% /nobreak > NUL
    goto loop
:exitloop

REM Descriptive Output
echo Last edit in %search_dir% occured at %last_edit_time%
echo Script finished at %date% %time%
