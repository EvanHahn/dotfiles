import subprocess
from pathlib import Path


def run_bin(name: str) -> subprocess.CompletedProcess:
    bin_path = Path(__file__).parent / ".." / ".." / "home" / "bin" / "bin" / name
    return subprocess.run([bin_path], capture_output=True, check=False, encoding="utf8")
