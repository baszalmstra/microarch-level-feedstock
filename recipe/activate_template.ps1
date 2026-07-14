# Appends the microarchitecture level compiler flags to CFLAGS, CXXFLAGS
# and CPPFLAGS, backing up the previous values so that the deactivation
# script can restore them. Installed by install_scripts.py with the
# MSVC-style flags for the selected level baked in. PowerShell only runs
# .ps1 activation scripts; cmd.exe uses the .bat twin.
$Env:CONDA_MICROARCH_BACKUP_CFLAGS = $Env:CFLAGS
$Env:CONDA_MICROARCH_BACKUP_CXXFLAGS = $Env:CXXFLAGS
$Env:CONDA_MICROARCH_BACKUP_CPPFLAGS = $Env:CPPFLAGS
if ($Env:CFLAGS) { $Env:CFLAGS = "${Env:CFLAGS} @FLAGS@" } else { $Env:CFLAGS = "@FLAGS@" }
if ($Env:CXXFLAGS) { $Env:CXXFLAGS = "${Env:CXXFLAGS} @FLAGS@" } else { $Env:CXXFLAGS = "@FLAGS@" }
if ($Env:CPPFLAGS) { $Env:CPPFLAGS = "${Env:CPPFLAGS} @FLAGS@" } else { $Env:CPPFLAGS = "@FLAGS@" }
