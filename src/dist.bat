@echo off
rem ----------------------------------------------------------------------------
rem Script para distribuicao/tag automatizada.
rem
rem Script para geracao de tag, de forma automatizada, para projetos nao-relaci-
rem onados com desenvolvimento de software.
rem
rem
rem Copyright (c) 2014 Petroleo Brasileiro S/A - PETROBRAS
rem     Rio de Janeiro, RJ - Brasil.
rem     Todos os direitos reservados.
rem
rem Autor(es):
rem     Bruno Guerchon Nunes
rem
rem Datas:
rem     09/06/2014 inicio
rem ----------------------------------------------------------------------------

cls


set HR=--------------------------------------------------------------------

set WAIT=%CD%\wait.bat


set "ROOT_DIR=%CD%"

set "SRC_DIR=%ROOT_DIR%\matriz"
set "DIST_DIR=%SRC_DIR%\dist"
set "DIST_TAG_DIR=%DIST_DIR%\tag"
set "DIST_TARGET_DIR=%DIST_DIR%\target"

set "FINAL_DIR=%ROOT_DIR%\final"


rem Solicita que o usuario informe o goal, caso nao tenha sido passado como ar-
rem gumento no momento da execucao do script.
set ARG_GOAL=%1
if defined ARG_GOAL (
    set GOAL=%ARG_GOAL%
) else (
    echo.
    set /P GOAL=Informe o goal [clean^|tag]: 
)


rem GOAL: CLEAN

rem Apaga os arquivos e diretorios temporarios gerados por este script.
if "%GOAL%" == "clean" (
    echo.
    echo %HR%
    echo.
    if exist "%DIST_DIR%" (
        echo -- Limpando ambiente...
        call %WAIT% 2
        rmdir /S /Q "%DIST_DIR%" > nul
        call %WAIT% 2
        if exist "%DIST_DIR%" rmdir /S /Q "%DIST_DIR%"
    ) else (
        echo O ambiente ja esta limpo.
    )
    exit /b 0
)


rem GOAL: TAG

rem Solicita que o usuario informe um numero de versao, caso nao tenha sido pas-
rem sado como argumento no momento da execucao do script.
set ARG_VERSION=%2
if "%GOAL%" == "tag" if defined ARG_VERSION (
    set VERSION=%ARG_VERSION%
) else (
    echo.
    set /P VERSION=Informe o numero da versao ^(ex.: 01-00^): 
)

if "%GOAL%" == "tag" if defined VERSION (
    echo.
    echo %HR%
    echo.
    if exist "%FINAL_DIR%\%VERSION%.zip" (
        echo [ERROR] A versao %VERSION% ja existe.
        exit /b 1
    )
    echo -- Criando diretorios...
    call %WAIT% 2
    mkdir %DIST_TAG_DIR%
    mkdir %DIST_TARGET_DIR%
    echo.
    echo -- Copiando arquivos...
    call %WAIT% 2
    cd %SRC_DIR%
    rem ........................................................................
    rem Incluir aqui os arquivos e diretorios a serem copiados.
    copy *.txt %DIST_TARGET_DIR%
    rem ........................................................................
    echo.
    echo -- Gerando tag...
    call %WAIT% 2
    cd %DIST_TARGET_DIR%
    zip %DIST_TAG_DIR%\%VERSION%.zip *
    cd %ROOT_DIR%
) else (
    echo.
    echo [ERROR] Goal invalido: "%GOAL%".
    exit /b 1
)

call %WAIT% 3