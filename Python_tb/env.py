import cocotb
import pyuvm
from agent import agent
from scoreboard import scoreboard

from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock
from pyuvm import *

class env(uvm_env):

    def build_phase(self):
        self.logger.info("We are in the env build phase now!")
        self.agent = agent.create("agent", self)
        self.scoreboard = scoreboard.create("scoreboard", self)

    def connect_phase(self):
        self.agent.monitor.monitor_port.connect(self.scoreboard.analysis_imp)

    async def run_phase(self):
        self.raise_objection();
        self.drop_objection();
