import uvm_pkg::*;
`include "uvm_macros.svh"

class my_test extends uvm_test;

   `uvm_component_utils(my_test)
   
   my_env env;
   my_sequence seq;
   virtual IIR_if my_if;

   //Constructor
   function new(string name = "my_test", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      env = my_env::type_id::create("env" , this);
      seq = my_sequence::type_id::create("seq", this);

      if(!uvm_config_db#(virtual IIR_if)::get(this, "", "if", my_if)) begin
         `uvm_fatal("NOVIF",{"Virtual interface must be set for: ", get_full_name()})
      end
   endfunction // build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction // connect_phase

   virtual function void start_of_simulation_phase(uvm_phase phase);
      super.start_of_simulation_phase(phase);
      factory.print();
   endfunction

   virtual task reset_phase(uvm_phase phase);
      super.reset_phase(phase);
      phase.raise_objection(this);  // Prevent phase from finishing
      `uvm_info("RESET_PHASE","waiting for reset", UVM_MEDIUM);     
      @(posedge my_if.rst_i);
      `uvm_info("RESET_PHASE","Reset was released!", UVM_MEDIUM);  
      phase.drop_objection(this);   // Let phase finish
   endtask

   virtual task main_phase(uvm_phase phase);
      super.main_phase(phase);
      phase.raise_objection(this);  // Prevent phase from finishing
      repeat(2) @(posedge my_if.clk_i);
      `uvm_info("MAIN_PHASE","Let clock run for a while before sequence", UVM_LOW);
      seq.start(env.agent.sequencer);     
      phase.drop_objection(this);   // Let phase finish
   endtask

   virtual task shutdown_phase(uvm_phase phase);
      super.shutdown_phase(phase);
      phase.raise_objection(this);  // Prevent phase from finishing
      repeat(2) @(posedge my_if.clk_i); // wait until last item is compared
      phase.drop_objection(this);   // Let phase finish
   endtask

   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("my_test", "Hellooo I'm here", UVM_LOW);
      #100;
      `uvm_info("my_test", $sformatf("Time is now: %0t", $time), UVM_LOW);
      phase.drop_objection(this);
   endtask

endclass   
