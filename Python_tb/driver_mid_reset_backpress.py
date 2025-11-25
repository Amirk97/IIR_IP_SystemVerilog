from cocotb.triggers import RisingEdge, FallingEdge
import cocotb
import vsc
from driver_backpress import driver_backpress 

class driver_mid_reset_backpress(driver_backpress):

    def __init__(self, name="driver_mid_reset_backpress", parent=None):
        super().__init__(name,parent)
        self.rand_reset = vsc.rand_bit_t(1)

    async def run_phase(self):
        await super().run_phase()
        cocotb.start_soon(self.driver_reset())

    async def driver_reset(self):

        while True:
            await RisingEdge(self.IIR_if.dut.clk_i)
            with vsc.randomize_with(self.rand_reset):
                vsc.dist(self.rand_reset, [
                    vsc.weight(1, 90),
                    vsc.weight(0, 10)])

            self.IIR_if.dut.rst_i.value = self.rand_reset.get_val()
