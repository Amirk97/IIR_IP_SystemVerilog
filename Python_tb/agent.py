from pyuvm import uvm_agent, ConfigDB
from sequencer import sequencer
from driver import driver
from monitor import monitor

class agent(uvm_agent):

    def build_phase(self):
        IIR_if = ConfigDB().get(self, "", "if")
        self.sequencer = sequencer.create("sequencer", self)
        self.driver = driver.create("driver", self)
        self.monitor = monitor.create("monitor", self)
        self.driver.IIR_if = IIR_if
        self.monitor.IIR_if = IIR_if

    def connect_phase(self):
        self.driver.seq_item_port.connect(self.sequencer.seq_item_export);    
