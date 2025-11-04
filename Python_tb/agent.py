from pyuvm import uvm_agent, ConfigDB
from sequencer import sequencer
from driver import driver
from monitor import monitor

class agent(uvm_agent):

    def build_phase(self):
        dut = ConfigDB().get(self, "", "dut")
        self.sequencer = sequencer.create("sequencer", self)
        self.driver = driver.create("driver", self)
        self.monitor = monitor.create("monitor", self)
        self.driver.dut = dut
        self.monitor.dut = dut

    def connect_phase(self):
        self.driver.seq_item_port.connect(self.sequencer.seq_item_export);    
