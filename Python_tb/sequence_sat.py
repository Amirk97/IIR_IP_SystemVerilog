from pyuvm import uvm_sequence
from item_basic import item_basic
import vsc as vsc
from sequence import sequence

class sequence_sat(sequence):
    
    def __init__(self, name="sequence_sat", NUMBER_OF_TESTS=20):
        super().__init__(name)
        self.NUMBER_OF_TESTS = NUMBER_OF_TESTS

    async def body(self):
        item = item_basic.create(name="item")

        for i in range(self.NUMBER_OF_TESTS):
            await self.start_item(item)
            item.randomize()
            if (i < (self.NUMBER_OF_TESTS/2)):
                item.x_i = (1 << (item.DATA_WIDTH-1))-1
            else:
                item.x_i = -(1 << (item.DATA_WIDTH-1))
            print(f"input in seq is: {item.x_i}")
            await self.finish_item(item)
            print("Sent the item from sequence")
