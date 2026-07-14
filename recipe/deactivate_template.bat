:: Restores CFLAGS, CXXFLAGS and CPPFLAGS to the values backed up by the
:: activation script and removes the backup variables. In cmd.exe,
:: `set "VAR="` unsets the variable, mirroring the POSIX script's
:: empty-means-unset semantics.
@if defined CONDA_MICROARCH_BACKUP_CFLAGS (set "CFLAGS=%CONDA_MICROARCH_BACKUP_CFLAGS%") else (set "CFLAGS=")
@if defined CONDA_MICROARCH_BACKUP_CXXFLAGS (set "CXXFLAGS=%CONDA_MICROARCH_BACKUP_CXXFLAGS%") else (set "CXXFLAGS=")
@if defined CONDA_MICROARCH_BACKUP_CPPFLAGS (set "CPPFLAGS=%CONDA_MICROARCH_BACKUP_CPPFLAGS%") else (set "CPPFLAGS=")
@set "CONDA_MICROARCH_BACKUP_CFLAGS="
@set "CONDA_MICROARCH_BACKUP_CXXFLAGS="
@set "CONDA_MICROARCH_BACKUP_CPPFLAGS="
