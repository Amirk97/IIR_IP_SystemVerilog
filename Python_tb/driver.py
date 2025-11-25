from pyuvm import uvm_driver
from cocotb.triggers import RisingEdge, FallingEdge
import cocotb
import vsc

class driver(uvm_driver):

    def __init__(self, name="driver", parent=None):
        super().__init__(name,parent)
        self.IIR_if = None

    async def run_phase(self):
        cocotb.start_soon(self.driver_data())
        cocotb.start_soon(self.driver_ready())
        cocotb.start_soon(self.driver_valid())

    async def driver_data(self):

        while True:

            item = await self.seq_item_port.get_next_item()
            self.logger.info("Recieved the item in driver")

            self.IIR_if.dut.x_i.value = item.x_i
            self.IIR_if.dut.coeff_x_i.value = item.coeff_x_i
            self.IIR_if.dut.coeff_y_i.value = item.coeff_y_i
            self.IIR_if.coeff_index = item.coeff_index
            # This part can be problematic cause im waiting for and edge not a level
            await RisingEdge(self.IIR_if.dut.ready_and_o)
            # Wait until data gets eventually consumed
            await FallingEdge(self.IIR_if.dut.ready_and_o)
            
            self.logger.info("Drove the item in driver")
            self.seq_item_port.item_done()

    async def driver_ready(self):
        self.IIR_if.dut.ready_and_i.value = 1

    async def driver_valid(self):
        self.IIR_if.dut.valid_i.value = 1
