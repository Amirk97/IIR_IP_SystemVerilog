from pyuvm import uvm_sequence
from item_basic import item_basic
import vsc as vsc


class sequence(uvm_sequence):

    def __init__(self, name="sequence"):
        super().__init__(name)

    async def body(self):
        item = item_basic.create(name="item")

        for i in range(1000):
            await self.start_item(item)
            item.randomize()
            await self.finish_item(item)
            print("Sent the item from sequence")
