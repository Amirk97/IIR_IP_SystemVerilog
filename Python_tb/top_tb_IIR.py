import cocotb
import pyuvm
import test, test_const_coeff, test_rand_coeff, test_rand_coeff_backpress, test_saturation, test_rand_coeff_backpress_mid_reset, test_process_delay, test_rand_valid
import os

from cocotb.triggers import Timer, RisingEdge
from cocotb.clock import Clock
from pyuvm import uvm_root, ConfigDB

testcase = os.environ.get("PY_TESTCASE", "test_const_coeff")

@cocotb.test(name=testcase)
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
    
    await uvm_root().run_test(testcase)

    uvm_root().logger.info("Exiting the test")
