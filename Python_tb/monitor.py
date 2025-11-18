from pyuvm import uvm_monitor, uvm_analysis_port
from item_basic import *
from cocotb.triggers import RisingEdge, FallingEdge, ReadOnly
import cocotb
from cocotb.utils import get_sim_time

class monitor(uvm_monitor):

    def __init__(self, name="driver", parent=None):
        super().__init__(name,parent)
        self.IIR_if = None
        self.reset_time = None

    def build_phase(self):
        self.item = item_basic.create("item")
        self.monitor_port = uvm_analysis_port("monitor_port", self)

    async def run_phase(self):
        cocotb.start_soon(self.monitor_inputs())
        cocotb.start_soon(self.monitor_outputs())
        cocotb.start_soon(self.monitor_reset())

    async def monitor_inputs(self):
        while True:
            await RisingEdge(self.IIR_if.dut.clk_i)
            if((self.IIR_if.dut.valid_i.value == 1) and self.IIR_if.dut.ready_and_o.value == 1):
                self.item.x_i = self.IIR_if.dut.x_i.value
                self.item.coeff_index = self.IIR_if.coeff_index
                self.logger.info(f"Observed input: {signed(self.item.x_i, self.item.DATA_WIDTH)}")

    async def monitor_outputs(self):
        while True:
            await ReadOnly()
            await RisingEdge(self.IIR_if.dut.valid_o)
            # If reset happens at the same time as valid output, ignore checking
            if (self.reset_time != get_sim_time('ns')):
                self.item.y_o = self.IIR_if.dut.y_o.value
                self.logger.info(f"Observed output: {signed(self.item.y_o, self.item.DATA_WIDTH)}")
                self.monitor_port.write(self.item)

    async def monitor_reset(self):
        while True:
            await ReadOnly()
            await FallingEdge(self.IIR_if.dut.rst_i)
            self.logger.info("Observed rest")
            clib.dpi_init_filter()
            self.reset_time = get_sim_time('ns')
