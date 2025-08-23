import basic_sequence_item::*;

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
      item = basic_sequence_item#()::type_id::create("item");
      monitor_port = new("monitor_port", this);

      if(!uvm_config_db#(virtual IIR_if)::get(this, "", "if", my_if)) begin
         `uvm_fatal("NOVIF",{"Virtual interface must be set for: ", get_full_name()})
      end

   endfunction

   virtual task run_phase(uvm_phase phase);

      forever begin
         @(posedge my_if.data_DONE);
         item.y_o = my_if.y_o;
         monitor_port.write(item);         
      end
      
   endtask

endclass
