#!/usr/bin/env python3
import argparse
from pathlib import Path
import sys
import subprocess


def eprint(*args):
    print(*args, file=sys.stderr)


def drop_suffix(name, suffixes):
    for suffix in suffixes:
        if name.endswith(suffix):
            return name[: -len(suffix)]
    return None


def run(*args):
    subprocess.run(args, check=True)


def extract(archive_path):
    name = archive_path.name
    suffix = archive_path.suffix

    tar_name = drop_suffix(
        name, [".tar", ".tar.gz", ".tar.bz2", ".tar.xz", ".tgz", ".tbz2"]
    )
    if tar_name:
        out_dir = archive_path.parent / tar_name
        out_dir.mkdir(mode=0o700, exist_ok=True)
        run("tar", "-xf", archive_path, "-C", out_dir)
    elif suffix == ".zip":
        out_dir = archive_path.parent / name[:-4]
        out_dir.mkdir(mode=0o700, exist_ok=True)
        run("unzip", "-d", out_dir, archive_path)
    elif suffix == ".rar" and sys.platform == "darwin":
        out_dir = archive_path.parent / name[:-4]
        out_dir.mkdir(mode=0o700, exist_ok=True)
        run("/usr/bin/tar", "-xf", archive_path, "-C", out_dir)
    elif suffix == ".gz":
        run("gunzip", "--keep", archive_path)
    elif suffix == ".bz2":
        run("bunzip2", "--keep", archive_path)
    elif suffix == ".xz":
        run("unxz", "--keep", archive_path)
    else:
        eprint("can't extract", archive_path.name)
        sys.exit(1)


def main():
    parser = argparse.ArgumentParser(description="extract archives")
    parser.add_argument(
        "archive_path", nargs="+", help="archive(s) to extract", type=Path
    )
    archive_paths = parser.parse_args().archive_path

    for archive_path in archive_paths:
        extract(archive_path)


if __name__ == "__main__":
    main()
