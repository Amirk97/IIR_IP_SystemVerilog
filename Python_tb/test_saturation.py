from item_basic import item_basic
from item_saturation import item_saturation
from sequence_sat import sequence_sat
from sequence import sequence
from pyuvm import *
from test import test

class test_saturation(test):

    def build_phase(self):
        uvm_factory().set_type_override_by_type(item_basic, item_saturation)
        uvm_factory().set_type_override_by_type(sequence, sequence_sat)
        super().build_phase()
