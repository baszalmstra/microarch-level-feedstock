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
    # MSVC-style flags for the .bat/.ps1 scripts. MSVC's x64 baseline (SSE2)
    # already matches level 1 and there is no /arch flag targeting the
    # level 2 feature set, so levels 1 and 2 set no flags on Windows. The
    # /arch options are monotonic: each subsumes the ones below it, so a
    # single flag per level is sufficient for cl.exe and clang-cl.
    win_flag = {
        "1": "",
        "2": "",
        "3": "/arch:AVX2",
        "4": "/arch:AVX512",
    }[level]
elif family == "ppc64le":
    unix_flag = f"-mcpu=power{level}"
    win_flag = None  # there is no Windows on ppc64le
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

    # Windows flavors: .bat for cmd.exe (conda-build/rattler-build builds and
    # `conda activate` from cmd), .ps1 for PowerShell (which does not fall
    # back to .bat scripts). .bat files need CRLF line endings: cmd.exe
    # misparses labels/multi-line constructs in LF-only batch files.
    for suffix, newline, comment in ((".bat", "\r\n", "::"), (".ps1", "\n", "#")):
        if win_flag:
            template = (recipe_dir / f"{nature}_template{suffix}").read_text()
            content = template.replace("@FLAGS@", win_flag)
        else:
            content = (
                f"{comment} No Windows compiler flags for {family} level {level}:\n"
                f"{comment} MSVC's x64 baseline already targets level 1 and there\n"
                f"{comment} is no /arch flag for the level 2 feature set.\n"
            )
        dest = dest_dir / f"~{nature}-{family}-level{suffix}"
        dest.write_text(content, newline=newline)
        print(f"installed {dest}")
