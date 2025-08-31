
class my_env extends uvm_env;

   `uvm_component_utils(my_env)

   my_agent agent;   

   //Constructor
   function new(string name = "my_env", uvm_component parent = null);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent = my_agent::type_id::create("agent", this);
   endfunction // build_phase

   virtual function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
   endfunction // connect_phase

   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      phase.drop_objection(this);
   endtask

endclass   
