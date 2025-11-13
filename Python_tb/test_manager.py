import subprocess
import os
import pytest

@pytest.mark.parametrize("PY_TESTCASE", ["test_const_coeff", "test_rand_coeff", "test_rand_coeff_backpress", "test_rand_coeff_mid_reset_backpress"])
def test_regression_suite(PY_TESTCASE):
    env = os.environ.copy()
    env["PY_TESTCASE"] = PY_TESTCASE
    print(os.path.abspath("../"))
    subprocess.run(["make","cocotb"], check=True, env=env)
