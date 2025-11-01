from item_basic import item_basic
import vsc

class item_const_coeff(item_basic):

    def __init__(self, name="item_const_coeff", *args, **kwargs):
        super().__init__(name, *args, **kwargs)

    @vsc.constraint
    def coeff_c(self):
        self.coeff_index in vsc.rangelist(0)
