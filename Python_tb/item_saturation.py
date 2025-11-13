from item_basic import item_basic
import vsc

@vsc.randobj
class item_saturation(item_basic):

    @vsc.constraint
    def coeff_c(self):
        self.coeff_index in vsc.rangelist(1)

