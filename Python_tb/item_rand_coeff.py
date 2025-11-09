from item_basic import item_basic
import vsc

class item_rand_coeff(item_basic):

    @vsc.constraint
    def change_rand(self): 
        vsc.dist(self.enable_change, [
            vsc.weight(0, 95),
            vsc.weight(1, 5)])

    @vsc.constraint
    def coeff_rand(self):
        with vsc.if_then(self.enable_change == 0):
            self.coeff_index == self.prev_coeff_index
        with vsc.else_then:
            self.coeff_index in vsc.rangelist(vsc.rng(0,24))
            

