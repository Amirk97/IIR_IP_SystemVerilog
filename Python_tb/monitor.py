from pyuvm import uvm_monitor, uvm_analysis_port
from item_basic import item_basic
from cocotb.triggers import RisingEdge, FallingEdge
import cocotb

class monitor(uvm_monitor):

    def __init__(self, name="driver", parent=None):
        super().__init__(name,parent)
        self.dut = None

    def build_phase(self):
        self.item = item_basic.create("item")
        self.monitor_port = uvm_analysis_port("monitor_port", self)

    async def run_phase(self):
        cocotb.start_soon(self.monitor_inputs())
#        self.start_task(self.monitor_outputs)
#        self.start_task(self.monitor_reset)

    async def monitor_inputs(self):
        while True:
            await RisingEdge(self.dut.clk_i)
            if((self.dut.valid_i.value == 1) and self.dut.ready_and_o.value == 1):
                self.item.x_i = self.dut.x_i.value
#                self.item.coeff_index = self.dut.coeff_index.value
                self.logger.info(f"Recieved input: {self.item.x_i}")
