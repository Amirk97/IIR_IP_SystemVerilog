from cocotb.triggers import RisingEdge, FallingEdge
import cocotb
import vsc
from driver_mid_reset_backpress import driver_mid_reset_backpress 

class driver_mid_reset_backpress_rand_valid(driver_mid_reset_backpress):

    def __init__(self, name="driver_mid_reset_backpress_rand_valid", parent=None):
        super().__init__(name,parent)
        self.rand_valid = vsc.rand_bit_t(1)

    async def driver_valid(self):

        while True:
            await RisingEdge(self.IIR_if.dut.clk_i)
            with vsc.randomize_with(self.rand_valid):
                vsc.dist(self.rand_valid, [
                    vsc.weight(0, 90),
                    vsc.weight(1, 10)])

            self.IIR_if.dut.valid_i.value = self.rand_valid.get_val()
