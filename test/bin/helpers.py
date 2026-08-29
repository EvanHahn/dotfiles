import subprocess
from collections.abc import Iterable
from pathlib import Path


def run_bin(
    name: str, args: Iterable[str] = None, env: dict[str, str] = None, stdin_input: str = None
) -> subprocess.CompletedProcess:
    args = args or []

    bin_path = Path(__file__).parent / ".." / ".." / "home" / "bin" / "bin" / name
    cmd = [str(bin_path), *args]
    return subprocess.run(
        cmd, capture_output=True, check=False, encoding="utf8", env=env, input=stdin_input
    )
