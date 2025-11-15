from pyuvm import uvm_sequence
from item_basic import item_basic
import vsc as vsc


class sequence(uvm_sequence):

    def __init__(self, name="sequence"):
        super().__init__(name)
        self.NUMBER_OF_TESTS = None

    async def body(self):
        item = item_basic.create(name="item")

        for i in range(self.NUMBER_OF_TESTS):
            await self.start_item(item)
            item.randomize()
            await self.finish_item(item)
            print("Sent the item from sequence")
