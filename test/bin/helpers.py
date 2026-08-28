import subprocess
from pathlib import Path


def run_bin(name: str, args: list[str] = None) -> subprocess.CompletedProcess:
    bin_path = Path(__file__).parent / ".." / ".." / "home" / "bin" / "bin" / name
    cmd = [str(bin_path), *(args or [])]
    return subprocess.run(cmd, capture_output=True, check=False, encoding="utf8")
