//import "DPI-C" function void dpi_init_filter();
import "DPI-C" function int dpi_compute_filter_output(input int val, input int index);
`define DIFF_MARG 0

class my_scoreboard extends uvm_component;

   `uvm_component_utils(my_scoreboard)

   uvm_analysis_imp#(basic_sequence_item#(), my_scoreboard) analysis_imp;
   int expected_data;
   int observed_data;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      analysis_imp = new("analysis_imp", this);
   endfunction

   virtual task reset_phase(uvm_phase phase);
      super.reset_phase(phase);      
      dpi_init_filter();
      `uvm_info("RESET_PHASE","C model initiated", UVM_MEDIUM);
   endtask

   virtual function void write(basic_sequence_item#() item);
      `uvm_info("SCOREBOARD",
                $sformatf("Recieved input: %d and index %d", $signed(item.x_i), item.coeff_index),
                UVM_MEDIUM)

      expected_data =  dpi_compute_filter_output($signed(item.x_i), $signed(item.coeff_index));
      observed_data =  $signed(item.y_o);

      `uvm_info("SCOREBOARD",
                $sformatf("expected_data: %0d", expected_data),
                UVM_MEDIUM)
      
      if($abs(expected_data - observed_data) > `DIFF_MARG)
        `uvm_fatal("SCOREBOARD",
                  $sformatf("Fail: Expected %d got %d", expected_data, observed_data))
      else
        `uvm_info("SCOREBOARD",
                  $sformatf("Success: Expected %d got %d", expected_data, observed_data),
                  UVM_MEDIUM)
   endfunction

endclass
