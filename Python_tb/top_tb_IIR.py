import cocotb
import pyuvm
import test

from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock
from pyuvm import uvm_root, ConfigDB

@cocotb.test()
async def top_tb_IIR(IIR):
    uvm_root().logger.info("Starting PyUVM in cocotb")

    # Starting the clock
    clock = Clock(IIR.clk_i, 10, unit="ns")
    cocotb.start_soon(clock.start())

    # Doing the initial reset
    await RisingEdge(IIR.clk_i)
    IIR.rst_i.value = 0
    for _ in range(2):
        await RisingEdge(IIR.clk_i)
    IIR.rst_i.value = 1
    uvm_root().logger.info("[RSTDV] Reset was released here!")
    
#    ConfigDB().set(None, "uvm_test_top.env.agent", "dut", IIR)
    await uvm_root().run_test("test")

    uvm_root().logger.info("Exiting the test")
