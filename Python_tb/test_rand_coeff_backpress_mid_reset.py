from item_basic import item_basic
from item_rand_coeff import item_rand_coeff
from driver import driver
from driver_backpress import driver_backpress
from driver_mid_reset_backpress import driver_mid_reset_backpress
from pyuvm import *
from test import test

class test_rand_coeff_backpress_mid_reset(test):

    def build_phase(self):
        super().build_phase()
        uvm_factory().set_type_override_by_type(item_basic, item_rand_coeff)
        uvm_factory().set_type_override_by_type(driver, driver_mid_reset_backpress)
        self.sequence.NUMBER_OF_TESTS = 100
        
