:: Appends the microarchitecture level flags to the compiler flag
:: variables, backing up the previous values for deactivation. The flags
:: use MSVC syntax, so they are only applied when CC is cl or clang-cl.
@set "_microarch_cc="
@if defined CC for %%i in ("%CC%") do @set "_microarch_cc=%%~nxi"
@set "CONDA_MICROARCH_APPLIED="
@if /I "%_microarch_cc%"=="cl.exe" set "CONDA_MICROARCH_APPLIED=1"
@if /I "%_microarch_cc%"=="cl" set "CONDA_MICROARCH_APPLIED=1"
@if /I "%_microarch_cc%"=="clang-cl.exe" set "CONDA_MICROARCH_APPLIED=1"
@if /I "%_microarch_cc%"=="clang-cl" set "CONDA_MICROARCH_APPLIED=1"
@set "_microarch_cc="
@if not defined CONDA_MICROARCH_APPLIED goto :microarch_end
@set "CONDA_MICROARCH_BACKUP_CFLAGS=%CFLAGS%"
@set "CONDA_MICROARCH_BACKUP_CXXFLAGS=%CXXFLAGS%"
@set "CONDA_MICROARCH_BACKUP_CPPFLAGS=%CPPFLAGS%"
@if defined CFLAGS (set "CFLAGS=%CFLAGS% @FLAGS@") else (set "CFLAGS=@FLAGS@")
@if defined CXXFLAGS (set "CXXFLAGS=%CXXFLAGS% @FLAGS@") else (set "CXXFLAGS=@FLAGS@")
@if defined CPPFLAGS (set "CPPFLAGS=%CPPFLAGS% @FLAGS@") else (set "CPPFLAGS=@FLAGS@")
:microarch_end
