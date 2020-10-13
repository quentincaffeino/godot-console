@echo off
setlocal enabledelayedexpansion

::Generates a reference.json file using the CLI script and godot, and runs 
::the python module on it to create markdown/hugo markdown.

::Test for godot
where /q godot*
if ERRORLEVEL 1 goto no-godot else (
   for /f "delims=" %%F in ('where godot*') do set godot=%%F
)

::Test for python
where /q python
if ERRORLEVEL 1 goto no-python

::Check for project path
if %1 == -p            goto help
if %1 == --path        goto help
if %1 == -f            goto help
if %1 == --format      goto help
if %1 == -d            goto help
if %1 == --date        goto help
if %1 == -a            goto help
if %1 == --author      goto help
if %1 == -v            goto help
if %1 == -vv           goto help
if %1 == --verbose     goto help
if %1 == -i            goto help
if %1 == --make-index  goto help
if %1 == --dry-run     goto help

::Check for project.godot
set project_path=%1
if not exist "%project_path%\project.godot" goto no-project

::No arguments
if [%2] == []          goto tail

::Parse arguments
set param_arg=0
set param_n=0
set flag_n=0

for %%x in (%*) do (
   if not %%x == %1 (
      call :process_argument %%x || goto help
   )
)

if %param_arg% == 1    goto help
if [%output_path%] == [] set output_path=%~dp0export

goto tail

:help
echo.
echo Creates and parses reference documentation for a GDScript based projects.
echo.
echo generate_reference path\to\godot\project [-p dest] [-f markdown ^| hugo]
echo      [-d YYYY-MM-DD] [-a id] [-v ^| -vv] [--dry-run] [-i]
echo.
echo   -p
echo   --path dest   Path to the output directory.
echo.
echo   -f
echo   --format      Output format for the markdown files. Either markdown (default)
echo                 or hugo for the hugo static website generator.
echo.
echo   -d
echo   --date        Date in ISO format: YYYY-MM-DD. Example: 2020-05-12 corresponds
echo                 to March 12, 2020. Only used for the hugo export format.
echo.
echo   -a
echo   --author      ID of the author for hugo's front-matter. Only used for the
echo                 hugo export format.
echo.
echo   -v
echo   --verbose     Set the verbosity level. For example, -vv sets the verbosity
echo                 level to 2.
echo.
echo   --dry-run     Run the script without actual rendering or creating files
echo                 and folders. For debugging purposes
echo.
echo   -i
echo   --make-index  If this flag is present, create an index.md page with a table
echo                 of contents.
echo.
goto end

:no-godot
echo Could not find godot - make sure it is in your PATH environment variable.
echo.
goto end

:no-python
echo Could not find python - make sure python3 is installed.
echo.
goto end

:no-project
echo Could not find project.godot at %project_path%.
echo.
goto end

:no-json
echo Collector failed to produce a reference.json object. Check scripts for errors.
echo.
goto end

:tail
set gdscript_path=godot-scripts
set gdscript_1=ReferenceCollectorCLI.gd
set gdscript_2=Collector.gd

::Copy CLI scripts to project location to be found in res://
copy /Y "%gdscript_path%\%gdscript_1%" "%project_path%\%gdscript_1%" > nul
copy /Y "%gdscript_path%\%gdscript_2%" "%project_path%\%gdscript_2%" > nul

echo Generating reference...

::Run godot in editor mode and runs the collector script
%godot% -e -q -s --no-window --path "%project_path%" %gdscript_1% > nul

::Clean up
erase /Q "%project_path%\%gdscript_1%"
erase /Q "%project_path%\%gdscript_2%"

::Check for json
if not exist "%project_path%\reference.json" goto no-json

echo Done.
echo Generating output...

::Build module caller
set python_string=python -m gdscript_docs_maker "%project_path%\reference.json"

for /l %%n in (0,1,%param_n%) do (
   if not [!parameters[%%n].option!] == [] (
      set python_string=!python_string! !parameters[%%n].option! !parameters[%%n].param!
   )
)

for /l %%n in (0,1,%flag_n%) do (
   if not [!flags[%%n]!] == [] (
      set python_string=!python_string! !flags[%%n]!
   )
)

::Build markdown
%python_string%

if not exist %output_path% (
   echo Module failed to build markdown.
) else (
   echo Done. Markdown generated in %output_path%
)
echo.
goto end

:process_argument
   if %~1 == -p           goto parameterized
   if %~1 == --path       goto parameterized
   if %~1 == -d           goto parameterized
   if %~1 == --date       goto parameterized
   if %~1 == -a           goto parameterized
   if %~1 == --author     goto parameterized
   if %~1 == -f           goto parameterized
   if %~1 == --format     goto parameterized
   
   if %~1 == -i           goto flags
   if %~1 == --make-index goto flags
   if %~1 == --dry-run    goto flags
   if %~1 == -v           goto flags
   if %~1 == -vv          goto flags
   if %~1 == --verbose    goto flags
   
   ::Parameter for parameterized argument
   if %param_arg% == 0 (
      echo Invalid parameter %1.
      goto sub_error
   )
   set param_arg=0
   
   if !parameters[%param_n%].option! == -p set output_path=%~f1
   if !parameters[%param_n%].option! == --path set output_path=%~f1
   
   set parameters[!param_n!].param=%~1
   set /A param_n+=1
   goto sub_end
   
   ::Set up to receive parameter
   :parameterized
   if %param_arg% == 1    goto sub_error
   
   set parsed=%~1
   if %parsed% == --path set parsed=-p
   if %parsed% == --date set parsed=-d
   if %parsed% == --author set parsed=-a
   if %parsed% == --format set parsed=-f
   
   for /l %%n in (0,1,%param_n%) do (
      if !parameters[%%n].option! == %parsed% (
	     echo Duplicate option %parsed%
	     goto sub_error
	  )
   )
   
   set parameters[!param_n!].option=%parsed%
   set param_arg=1
   goto sub_end
   
   :flags
   if %param_arg% == 1 (
      echo Incomplete parameter before %1 flag.
      goto sub_error
   )
   
   set parsed=%1
   
   if %parsed% == --make-index set parsed=-i
   
   for /l %%n in (0,1,%param_n%) do (
      if !flags[%%n]! == %parsed% (
	     echo Duplicate flag %parsed%.
	     goto sub_error
	  )
   )
   
   set flags[!flag_n!]=%parsed%
   set /A flag_n+=1
   goto sub_end
   
   :sub_error
   exit /b 1
   
   :sub_end
   exit /b 0

:end
endlocal
