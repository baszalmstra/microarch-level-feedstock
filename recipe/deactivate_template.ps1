# Restores CFLAGS, CXXFLAGS and CPPFLAGS to the values backed up by the
# activation script and removes the backup variables. In PowerShell,
# assigning an empty string to an Env: variable removes it, mirroring the
# POSIX script's empty-means-unset semantics.
if ($Env:CONDA_MICROARCH_BACKUP_CFLAGS) { $Env:CFLAGS = $Env:CONDA_MICROARCH_BACKUP_CFLAGS } else { $Env:CFLAGS = "" }
if ($Env:CONDA_MICROARCH_BACKUP_CXXFLAGS) { $Env:CXXFLAGS = $Env:CONDA_MICROARCH_BACKUP_CXXFLAGS } else { $Env:CXXFLAGS = "" }
if ($Env:CONDA_MICROARCH_BACKUP_CPPFLAGS) { $Env:CPPFLAGS = $Env:CONDA_MICROARCH_BACKUP_CPPFLAGS } else { $Env:CPPFLAGS = "" }
$Env:CONDA_MICROARCH_BACKUP_CFLAGS = ""
$Env:CONDA_MICROARCH_BACKUP_CXXFLAGS = ""
$Env:CONDA_MICROARCH_BACKUP_CPPFLAGS = ""
