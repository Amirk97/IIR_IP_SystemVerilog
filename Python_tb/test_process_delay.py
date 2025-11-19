from pyuvm import *
from test_rand_coeff_backpress_mid_reset import test_rand_coeff_backpress_mid_reset

# This test exercises the PROCESS_DELAY param in RTL, the configs get taken automatically from the config file based on the testcase name
class test_process_delay(test_rand_coeff_backpress_mid_reset):

    def build_phase(self):
        super().build_phase()
        self.sequence.NUMBER_OF_TESTS = 100
        
