from item_basic import item_basic
import vsc

@vsc.randobj
class item_rand_coeff(item_basic):

    @vsc.constraint
    def coeff_change(self): 
        vsc.dist(self.change, [
            vsc.weight(0, 90),
            vsc.weight(1, 10)])

    @vsc.constraint
    def coeff_rand(self):
        with vsc.if_then(self.change == 0):
            self.coeff_index == self.prev_coeff_index
        with vsc.else_then:
            self.coeff_index in vsc.rangelist(vsc.rng(0,24))
            

