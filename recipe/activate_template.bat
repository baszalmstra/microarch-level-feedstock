:: Appends the microarchitecture level compiler flags to CFLAGS, CXXFLAGS
:: and CPPFLAGS, backing up the previous values so that the deactivation
:: script can restore them. Installed by install_scripts.py with the
:: MSVC-style flags for the selected level baked in; cl.exe and clang-cl
:: use the last /arch option they recognize.
@set "CONDA_MICROARCH_BACKUP_CFLAGS=%CFLAGS%"
@set "CONDA_MICROARCH_BACKUP_CXXFLAGS=%CXXFLAGS%"
@set "CONDA_MICROARCH_BACKUP_CPPFLAGS=%CPPFLAGS%"
@if defined CFLAGS (set "CFLAGS=%CFLAGS% @FLAGS@") else (set "CFLAGS=@FLAGS@")
@if defined CXXFLAGS (set "CXXFLAGS=%CXXFLAGS% @FLAGS@") else (set "CXXFLAGS=@FLAGS@")
@if defined CPPFLAGS (set "CPPFLAGS=%CPPFLAGS% @FLAGS@") else (set "CPPFLAGS=@FLAGS@")
