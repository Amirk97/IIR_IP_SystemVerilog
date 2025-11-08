import cocotb
import pyuvm
import test, test_const_coeff
import os

from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock
from pyuvm import uvm_root, ConfigDB

@cocotb.test()
async def top_tb_IIR(IIR):
    uvm_root().logger.info("Starting PyUVM in cocotb")

    testcase = os.environ.get("PY_TESTCASE", "test_const_coeff")

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
    
    await uvm_root().run_test(testcase)

    uvm_root().logger.info("Exiting the test")
