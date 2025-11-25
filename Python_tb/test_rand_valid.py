from driver_mid_reset_backpress_rand_valid import driver_mid_reset_backpress_rand_valid
from driver_mid_reset_backpress import driver_mid_reset_backpress
from test_rand_coeff_backpress_mid_reset import test_rand_coeff_backpress_mid_reset
from pyuvm import *

class test_rand_valid(test_rand_coeff_backpress_mid_reset):

    def build_phase(self):
        super().build_phase()
        uvm_factory().set_type_override_by_type(driver_mid_reset_backpress, driver_mid_reset_backpress_rand_valid)
        self.sequence.NUMBER_OF_TESTS = 1000
        
