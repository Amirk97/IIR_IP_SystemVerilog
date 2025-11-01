import cocotb
import pyuvm
from env import env
from sequence import sequence
from item_basic import item_basic
from item_const_coeff import item_const_coeff

from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock
from pyuvm import *

class test(uvm_test):

    def build_phase(self):
        print(self.get_name())
        ConfigDB().set(self, "env.agent", "dut", cocotb.top)
        self.logger.info("We are in the test build phase now!")
        self.env = env.create("env", self)
        self.sequence = sequence.create("seq")

        uvm_factory().set_type_override_by_type(item_basic, item_const_coeff)

    async def run_phase(self):
        self.raise_objection();
        self.logger.info("We are in the test run phase now!")
        await self.sequence.start(self.env.agent.sequencer)
        await Timer(100, unit='ns')
        self.logger.info("Test is done!")
        self.drop_objection();
