from pyuvm import uvm_scoreboard, uvm_subscriber, uvm_fatal
from item_basic import *

class scoreboard (uvm_scoreboard):

    def build_phase(self):
        self.analysis_imp = uvm_subscriber.uvm_AnalysisImp("analysis_imp", self, self.write)
        clib.dpi_init_filter()
        self.logger.info("C model initiated")


    def write(self, item):
        input_data = signed(item.x_i, item.DATA_WIDTH)
        observed_data = signed(item.y_o, item.DATA_WIDTH)
        expected_data = clib.dpi_compute_filter_output(signed(item.x_i, item.DATA_WIDTH), item.coeff_index)

        self.logger.info(f"With the observed inputs: {input_data} and {item.coeff_index}, output: {observed_data}")
        self.logger.info(f"The expected output is {expected_data}")

        if (observed_data != expected_data):
            uvm_fatal("SB: ", "Discrepancy between model and simulation!")
