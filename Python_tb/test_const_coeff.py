from item_basic import item_basic
from item_const_coeff import item_const_coeff
from pyuvm import *
from test import test

class test_const_coeff(test):

    def build_phase(self):
        super().build_phase()
        uvm_factory().set_type_override_by_type(item_basic, item_const_coeff)
