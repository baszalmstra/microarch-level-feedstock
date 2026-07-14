# Appends the microarchitecture level flags to the compiler flag
# variables, backing up the previous values for deactivation. The flags
# use MSVC syntax, so they are only applied when CC is cl or clang-cl.
$MicroarchCC = if ($Env:CC) { [IO.Path]::GetFileName($Env:CC) } else { "" }
if ($MicroarchCC -in "cl", "cl.exe", "clang-cl", "clang-cl.exe") {
    $Env:CONDA_MICROARCH_APPLIED = "1"
    $Env:CONDA_MICROARCH_BACKUP_CFLAGS = $Env:CFLAGS
    $Env:CONDA_MICROARCH_BACKUP_CXXFLAGS = $Env:CXXFLAGS
    $Env:CONDA_MICROARCH_BACKUP_CPPFLAGS = $Env:CPPFLAGS
    if ($Env:CFLAGS) { $Env:CFLAGS = "${Env:CFLAGS} @FLAGS@" } else { $Env:CFLAGS = "@FLAGS@" }
    if ($Env:CXXFLAGS) { $Env:CXXFLAGS = "${Env:CXXFLAGS} @FLAGS@" } else { $Env:CXXFLAGS = "@FLAGS@" }
    if ($Env:CPPFLAGS) { $Env:CPPFLAGS = "${Env:CPPFLAGS} @FLAGS@" } else { $Env:CPPFLAGS = "@FLAGS@" }
}
Remove-Variable MicroarchCC -ErrorAction SilentlyContinue
