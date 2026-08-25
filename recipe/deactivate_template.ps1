# Restores the compiler flag variables from the backups made at
# activation, if activation applied any flags; assigning "" removes an
# Env: variable.
if ($Env:CONDA_MICROARCH_APPLIED) {
    if ($Env:CONDA_MICROARCH_BACKUP_CFLAGS) { $Env:CFLAGS = $Env:CONDA_MICROARCH_BACKUP_CFLAGS } else { $Env:CFLAGS = "" }
    if ($Env:CONDA_MICROARCH_BACKUP_CXXFLAGS) { $Env:CXXFLAGS = $Env:CONDA_MICROARCH_BACKUP_CXXFLAGS } else { $Env:CXXFLAGS = "" }
    if ($Env:CONDA_MICROARCH_BACKUP_CPPFLAGS) { $Env:CPPFLAGS = $Env:CONDA_MICROARCH_BACKUP_CPPFLAGS } else { $Env:CPPFLAGS = "" }
    $Env:CONDA_MICROARCH_APPLIED = ""
    $Env:CONDA_MICROARCH_BACKUP_CFLAGS = ""
    $Env:CONDA_MICROARCH_BACKUP_CXXFLAGS = ""
    $Env:CONDA_MICROARCH_BACKUP_CPPFLAGS = ""
}
