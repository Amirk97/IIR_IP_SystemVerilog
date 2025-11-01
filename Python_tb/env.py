import cocotb
import pyuvm
from agent import agent
#import item_basic
import sequencer
import driver

from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock
from pyuvm import *

class env(uvm_env):

#    def __init__(self, name="env", parent=None,

    def build_phase(self):
        self.logger.info("We are in the env build phase now!")
        self.agent = agent.create("agent", self)

    async def run_phase(self):
        self.raise_objection();
        self.drop_objection();
