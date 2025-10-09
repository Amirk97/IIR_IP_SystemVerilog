import basic_sequence_item::*;

class driver_mid_reset_backpress extends driver_backpress;

   `uvm_component_utils(driver_mid_reset_backpress)

   bit reset_rand;
   
   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);      
   endfunction

   virtual task run_phase(uvm_phase phase);
      super.run_phase(phase);

      forever begin : random_mid_reset
         @(posedge my_if.clk_i)
           assert(std::randomize(reset_rand) with {reset_rand dist {1 := 90, 0 := 10}; });               
         my_if.tb.rst_i = reset_rand;
         if(reset_rand == '0)
           `uvm_info("DRIVER",
                     "Random reset asserted!",
                     UVM_MEDIUM)

      end
      
   endtask
   
endclass
