import unittest
from .helpers import run_bin


class TestPwgen(unittest.TestCase):
    def test_default_length(self):
        result = run_bin("pwgen")
        self.assertEqual(result.returncode, 0)
        self.assertEqual(len(result.stdout.strip()), 64)


if __name__ == "__main__":
    unittest.main()
