from pyuvm import uvm_driver
from cocotb.triggers import RisingEdge, FallingEdge

class driver(uvm_driver):

    def __init__(self, name="driver", parent=None):
        super().__init__(name,parent)
        self.dut = None

    async def run_phase(self):

        while True:

            item = await self.seq_item_port.get_next_item()
            self.logger.info("Recieved the item in driver")

            self.dut.ready_and_i.value = 1         
            self.dut.x_i.value = item.x_i
            self.dut.valid_i.value = 1
            self.dut.coeff_x_i.value = item.coeff_x_i
            self.dut.coeff_y_i.value = item.coeff_y_i
            # self.dut.coeff_index.value = item.coeff_index
            # This part can be problematic cause im waiting for and edge not a level
            await RisingEdge(self.dut.ready_and_o)
            await FallingEdge(self.dut.ready_and_o)
            self.dut.valid_i.value = 0
            
            self.logger.info("Drove the item in driver")
            self.seq_item_port.item_done()
