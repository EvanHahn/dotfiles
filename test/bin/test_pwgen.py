import unittest
import string
from .helpers import run_bin


class TestPwgen(unittest.TestCase):
    def test_invalid_length(self):
        result = run_bin("pwgen", ["--length", "0"])
        self.assertNotEqual(result.returncode, 0)

    def test_invalid_alphabet(self):
        result = run_bin("pwgen", ["--alphabet", ""])
        self.assertNotEqual(result.returncode, 0)

    def test_default_length(self):
        result = run_bin("pwgen")
        self.assertEqual(result.returncode, 0)
        self.assertEqual(len(result.stdout.strip()), 64)

    def test_length_variation(self):
        for l in [1, 32, 128]:
            result = run_bin("pwgen", ["--length", str(l)])
            self.assertEqual(result.returncode, 0)
            self.assertEqual(len(result.stdout.strip()), l)

    def test_special_alphabets(self):
        result = run_bin("pwgen", ["--alphabet", "alpha"])
        alpha_set = set(string.ascii_letters)
        self.assertEqual(result.returncode, 0)
        for char in result.stdout.strip():
            self.assertIn(char, alpha_set)

        result = run_bin("pwgen", ["--alphabet", "numeric"])
        numeric_set = set(string.digits)
        self.assertEqual(result.returncode, 0)
        for char in result.stdout.strip():
            self.assertIn(char, numeric_set)

        result = run_bin("pwgen", ["--alphabet", "alphanum"])
        alphanum_set = set(string.ascii_letters + string.digits)
        self.assertEqual(result.returncode, 0)
        for char in result.stdout.strip():
            self.assertIn(char, alphanum_set)

    def test_custom_alphabet(self):
        result = run_bin("pwgen", ["--alphabet", "ABCDE"])
        custom_set = set("ABCDE")
        self.assertEqual(result.returncode, 0)
        for char in result.stdout.strip():
            self.assertIn(char, custom_set)


if __name__ == "__main__":
    unittest.main()
