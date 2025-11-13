from pyuvm import uvm_driver
from cocotb.triggers import RisingEdge, FallingEdge
import cocotb
import vsc
from driver import driver 

class driver_backpress(driver):

    def __init__(self, name="driver_backpress", parent=None):
        super().__init__(name,parent)
        self.rand_ready = vsc.rand_bit_t(1)

    async def run_phase(self):
        await super().run_phase()

    async def driver_ready(self):

        while True:
            await RisingEdge(self.IIR_if.dut.clk_i)
            with vsc.randomize_with(self.rand_ready):
                vsc.dist(self.rand_ready, [
                    vsc.weight(0, 80),
                    vsc.weight(1, 20)])
            self.IIR_if.dut.ready_and_i.value = self.rand_ready.get_val()   
