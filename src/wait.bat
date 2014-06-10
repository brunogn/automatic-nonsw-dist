@echo off

if "%1" == "/?" (
    echo Define um tempo, em segundos, que o script espera antes de continuar a
    echo execucao. Se nenhum argumento for passado, o padrao eh esperar zero [0]
    echo segundos.
    echo.
    echo wait [seconds]
    exit /b 0
)

set SECONDS=%1
if not defined SECONDS set SECONDS=0
set /A COUNT=%SECONDS%*1000

if %COUNT% GTR 0 (
    :loop
    set /A COUNT=%COUNT%-1
    if %COUNT% NEQ 0 goto loop
    exit /b 0
)