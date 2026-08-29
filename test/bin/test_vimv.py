import os
import shlex
import stat
import tempfile
import unittest
from pathlib import Path
from .helpers import run_bin


class TestVimv(unittest.TestCase):
    def get_tempdir(self):
        # pylint: disable=consider-using-with
        tmpdir_obj = tempfile.TemporaryDirectory()
        # pylint: enable=consider-using-with
        self.addCleanup(tmpdir_obj.cleanup)
        return Path(tmpdir_obj.name)

    def get_fake_bin(self, bash: str) -> Path:
        name = tempfile.mkstemp()[1]
        result = Path(name)
        self.addCleanup(result.unlink)
        result.write_text(
            "\n".join(
                ["#!/usr/bin/env bash", "set -e", "set -u", "set -o pipefail", bash]
            ),
            encoding="utf8",
        )
        os.chmod(name, stat.S_IRUSR | stat.S_IXUSR)
        return result

    def get_fake_editor(self, lines: list[Path]) -> Path:
        bash = f'echo -n {shlex.quote('\n'.join(map(str,lines)))} > "$1"'
        return self.get_fake_bin(bash)

    def test_no_args(self):
        result = run_bin("vimv")
        self.assertNotEqual(result.returncode, 0)

    def test_editor_error(self):
        tempdir = self.get_tempdir()
        old_path = tempdir / "old"
        old_path.touch()

        result = run_bin(
            "vimv",
            [old_path],
            env={"VISUAL": self.get_fake_bin("exit 99")},
        )

        self.assertEqual(result.returncode, 1)
        self.assertTrue(old_path.exists())

    def test_fewer_new_than_old(self):
        tempdir = self.get_tempdir()
        old_path_1 = tempdir / "one.txt"
        old_path_2 = tempdir / "two.png"
        old_path_3 = tempdir / "three"
        new_path_1 = tempdir / "1.txt"
        new_path_2 = tempdir / "2.png"
        old_path_1.touch()
        old_path_2.touch()
        old_path_3.touch()

        result = run_bin(
            "vimv",
            [old_path_1, old_path_2, old_path_3],
            env={"VISUAL": self.get_fake_editor([new_path_1, new_path_2])},
        )

        self.assertEqual(result.returncode, 1)
        self.assertTrue(old_path_1.exists())
        self.assertTrue(old_path_2.exists())
        self.assertTrue(old_path_3.exists())
        self.assertFalse(new_path_1.exists())
        self.assertFalse(new_path_2.exists())

    def test_fewer_more_than_old(self):
        tempdir = self.get_tempdir()
        old_path_1 = tempdir / "one.txt"
        old_path_2 = tempdir / "two.png"
        new_path_1 = tempdir / "1.txt"
        new_path_2 = tempdir / "2.png"
        new_path_3 = tempdir / "three"
        old_path_1.touch()
        old_path_2.touch()

        result = run_bin(
            "vimv",
            [old_path_1, old_path_2],
            env={"EDITOR": self.get_fake_bin("exit 99")},
        )

        self.assertEqual(result.returncode, 1)
        self.assertTrue(old_path_1.exists())
        self.assertTrue(old_path_2.exists())
        self.assertFalse(new_path_1.exists())
        self.assertFalse(new_path_2.exists())
        self.assertFalse(new_path_3.exists())

    def test_duplicate_old(self):
        tempdir = self.get_tempdir()
        old_path_1 = tempdir / "one.txt"
        old_path_2 = tempdir / "two.png"
        old_path_1.touch()
        old_path_2.touch()

        result = run_bin(
            "vimv",
            [old_path_1, old_path_1, old_path_2],
            env={"VISUAL": self.get_fake_bin("exit 99")},
        )

        self.assertEqual(result.returncode, 1)
        self.assertTrue(old_path_1.exists())
        self.assertTrue(old_path_2.exists())

    def test_duplicate_new(self):
        tempdir = self.get_tempdir()
        old_path_1 = tempdir / "one.txt"
        old_path_2 = tempdir / "two.png"
        old_path_3 = tempdir / "three"
        new_path_1 = tempdir / "1.txt"
        new_path_2_and_3 = tempdir / "3"
        old_path_1.touch()
        old_path_2.touch()
        old_path_3.touch()

        result = run_bin(
            "vimv",
            [old_path_1, old_path_2, old_path_3],
            env={
                "VISUAL": self.get_fake_editor(
                    [new_path_1, new_path_2_and_3, new_path_2_and_3]
                )
            },
        )

        self.assertEqual(result.returncode, 1)
        self.assertTrue(old_path_1.exists())
        self.assertTrue(old_path_2.exists())
        self.assertTrue(old_path_3.exists())
        self.assertFalse(new_path_1.exists())
        self.assertFalse(new_path_2_and_3.exists())

    def test_normal(self):
        tempdir = self.get_tempdir()
        old_path_1 = tempdir / "one.txt"
        old_path_2 = tempdir / "two.png"
        old_path_3 = tempdir / "three"
        new_path_1 = tempdir / "1.txt"
        new_path_2 = tempdir / "2.png"
        new_path_3 = tempdir / "3"
        old_path_1.write_text("first")
        old_path_2.write_text("second")
        old_path_3.write_text("third")

        result = run_bin(
            "vimv",
            [old_path_1, old_path_2, old_path_3],
            env={"VISUAL": self.get_fake_editor([new_path_1, new_path_2, new_path_3])},
        )

        self.assertEqual(result.returncode, 0)
        self.assertFalse(old_path_1.exists())
        self.assertFalse(old_path_2.exists())
        self.assertFalse(old_path_3.exists())

        self.assertEqual(new_path_1.read_text(), "first")
        self.assertEqual(new_path_2.read_text(), "second")
        self.assertEqual(new_path_3.read_text(), "third")

    def test_swap(self):
        tempdir = self.get_tempdir()
        a_path = tempdir / "a"
        b_path = tempdir / "b"
        a_path.write_text("started as A")
        b_path.write_text("started as B")

        result = run_bin(
            "vimv",
            [a_path, b_path],
            env={"VISUAL": self.get_fake_editor([b_path, a_path])},
        )

        self.assertEqual(result.returncode, 0)
        self.assertEqual(a_path.read_text(), "started as B")
        self.assertEqual(b_path.read_text(), "started as A")

    def test_dest_exists_and_user_denies(self):
        tempdir = self.get_tempdir()
        old_path_1 = tempdir / "one.txt"
        old_path_2 = tempdir / "two.png"
        new_path_1 = tempdir / "1.txt"
        new_path_2 = tempdir / "2.png"
        old_path_1.touch()
        old_path_2.touch()
        new_path_1.write_text("should be untouched")

        result = run_bin(
            "vimv",
            [old_path_1, old_path_2],
            env={"VISUAL": self.get_fake_editor([new_path_1, new_path_2])},
            stdin_input="no",
        )

        self.assertEqual(result.returncode, 1)
        self.assertTrue(old_path_1.exists())
        self.assertTrue(old_path_2.exists())
        self.assertEqual(new_path_1.read_text(), "should be untouched")
        self.assertFalse(new_path_2.exists())

    def test_dest_exists_and_user_approves(self):
        tempdir = self.get_tempdir()
        old_path = tempdir / "old"
        new_path = tempdir / "new"
        old_path.write_text("was old")
        new_path.touch()

        result = run_bin(
            "vimv",
            [old_path],
            env={"VISUAL": self.get_fake_editor([new_path])},
            stdin_input="yes",
        )

        self.assertEqual(result.returncode, 0)
        self.assertEqual(new_path.read_text(), "was old")

    def test_prefers_visual_env_var(self):
        tempdir = self.get_tempdir()
        old_path = tempdir / "old"
        new_path = tempdir / "new"
        old_path.touch()

        result = run_bin(
            "vimv",
            [old_path],
            env={
                "VISUAL": self.get_fake_editor([new_path]),
                "EDITOR": self.get_fake_bin("exit 99"),
            },
        )

        self.assertEqual(result.returncode, 0)
        self.assertTrue(new_path.exists())

    def test_works_with_editor_env_var(self):
        tempdir = self.get_tempdir()
        old_path = tempdir / "old"
        new_path = tempdir / "new"
        old_path.touch()

        result = run_bin(
            "vimv",
            [old_path],
            env={"EDITOR": self.get_fake_editor([new_path])},
        )

        self.assertEqual(result.returncode, 0)
        self.assertTrue(new_path.exists())

    def test_output(self):
        tempdir = self.get_tempdir()
        old_path = tempdir / "old"
        new_path = tempdir / "new"
        old_path.touch()
        new_path.touch()

        result = run_bin(
            "vimv",
            [old_path],
            env={"VISUAL": self.get_fake_editor([new_path])},
            stdin_input="yes",
        )

        self.assertEqual(result.returncode, 0)
        self.assertIn(f"overwrite {new_path}?", result.stdout)
        self.assertIn(f"renamed {old_path} -> {new_path}", result.stdout)


if __name__ == "__main__":
    unittest.main()
