`include "uvm_macros.svh"
import uvm_pkg::*;

class my_test extends uvm_test;

   `uvm_component_utils(my_test)

   my_env env;
   
   //Constructor
   function new(string name = "my_test", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = my_env::type_id::create("env" , this);
   endfunction // build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction // connect_phase

   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("my_test", "Hellooo I'm here", UVM_LOW);
      #10;
      `uvm_info("my_test", $sformatf("Time is now: %0t", $time), UVM_LOW);
      phase.drop_objection(this);
   endtask

endclass   
