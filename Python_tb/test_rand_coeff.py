from item_basic import item_basic
from item_rand_coeff import item_rand_coeff
from pyuvm import *
from test import test

class test_rand_coeff(test):

    def build_phase(self):
        super().build_phase()
        uvm_factory().set_type_override_by_type(item_basic, item_rand_coeff)
        self.sequence.NUMBER_OF_TESTS = 10000
