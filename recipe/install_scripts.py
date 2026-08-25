"""Cross-platform port of install_scripts.sh: installs the (de)activation
scripts that set the compiler flags for the selected level."""
import os
from pathlib import Path

family = os.environ["MICROARCH_FAMILY"]
level = os.environ["MICROARCH_LEVEL"]
prefix = Path(os.environ["PREFIX"])
recipe_dir = Path(os.environ["RECIPE_DIR"])

if family == "x86_64":
    unix_flag = "-march=x86-64" if level == "1" else f"-march=x86-64-v{level}"
    # MSVC has no /arch flag below AVX (levels 1 and 2), and each /arch
    # option subsumes the lower ones, so one flag per level suffices.
    win_flag = {
        "1": "",
        "2": "",
        "3": "/arch:AVX2",
        "4": "/arch:AVX512",
    }[level]
elif family == "ppc64le":
    unix_flag = f"-mcpu=power{level}"
    win_flag = None  # no Windows on ppc64le
else:
    raise ValueError(f"unknown family: {family}")

sh_template = (recipe_dir / "actdeact_template.sh").read_text()

for nature in ("activate", "deactivate"):
    dest_dir = prefix / "etc" / "conda" / f"{nature}.d"
    dest_dir.mkdir(parents=True, exist_ok=True)

    content = (
        sh_template
        .replace("@CFLAGS@", unix_flag)
        .replace("@CXXFLAGS@", unix_flag)
        .replace("@CPPFLAGS@", unix_flag)
        .replace("@actdeact@", nature)
    )
    dest = dest_dir / f"~{nature}-{family}-level.sh"
    dest.write_text(content, newline="\n")
    print(f"installed {dest}")

    if win_flag is None:
        continue

    # cmd.exe only runs .bat activation scripts and PowerShell only .ps1;
    # .bat files require CRLF line endings.
    for suffix, newline, comment in ((".bat", "\r\n", "::"), (".ps1", "\n", "#")):
        if win_flag:
            template = (recipe_dir / f"{nature}_template{suffix}").read_text()
            content = template.replace("@FLAGS@", win_flag)
        else:
            content = (
                f"{comment} No Windows compiler flags for {family} level"
                f" {level}: MSVC cannot target it.\n"
            )
        dest = dest_dir / f"~{nature}-{family}-level{suffix}"
        dest.write_text(content, newline=newline)
        print(f"installed {dest}")
