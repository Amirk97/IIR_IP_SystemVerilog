from pyuvm import uvm_sequencer

class sequencer(uvm_sequencer):

    def __init__(self, name="sequencer", parent=None):
        super().__init__(name, parent)
