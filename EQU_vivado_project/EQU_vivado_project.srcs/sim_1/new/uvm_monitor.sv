import basic_sequence_item::*;
import "DPI-C" function void dpi_init_filter();

class my_monitor extends uvm_monitor;
   
   `uvm_component_utils(my_monitor)

   basic_sequence_item#() item;   
   uvm_analysis_port#(basic_sequence_item#()) monitor_port;   
   virtual IIR_if my_if;

   function new ( string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase (uvm_phase phase);
      super.build_phase(phase);
      item = basic_sequence_item#()::type_id::create($sformatf("item"));
      monitor_port = new("monitor_port", this);
   endfunction

   virtual task run_phase(uvm_phase phase);

      fork
         begin : monitor_inputs
            forever begin
               @(posedge(my_if.clk_i))
                 if((my_if.valid_i === 1'b1) && (my_if.ready_and_o === '1)) begin
                    item.x_i = my_if.x_i;
                    item.coeff_index = my_if.coeff_index;
                    `uvm_info("MONITOR",
                              $sformatf("Recieved input: %d", $signed(item.x_i)),
                              UVM_MEDIUM)
                 end
            end
         end

         begin : monitor_outputs
            forever begin
               @(posedge my_if.valid_o);
               item.y_o = my_if.y_o;
               `uvm_info("MONITOR",
                         $sformatf("Sent input: %d sent index %d", $signed(item.x_i), item.coeff_index),
                         UVM_MEDIUM)
               monitor_port.write(item);
            end
         end // block: monitor_outputs

         begin : monitor_reset
            forever begin
               @(negedge my_if.rst_i);
               `uvm_info("MONITOR",
                         "Observed the reset!",
                         UVM_MEDIUM)
               dpi_init_filter();
            end
         end
         
    join_none
   endtask

endclass
