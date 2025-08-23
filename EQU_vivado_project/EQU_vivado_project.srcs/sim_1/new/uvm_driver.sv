import basic_sequence_item::*;

class my_driver extends uvm_driver#(basic_sequence_item#());

   `uvm_component_utils(my_driver)

   virtual IIR_if my_if;   

   function new ( string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      if(!uvm_config_db#(virtual IIR_if)::get(this, "", "if", my_if)) begin
         `uvm_fatal("NOVIF",{"Virtual interface must be set for: ", get_full_name()})
      end
   endfunction

   virtual task run_phase(uvm_phase phase);
      basic_sequence_item#() item;
      forever begin
         seq_item_port.get_next_item(item);
         my_if.x_i <= item.x_i;
         my_if.data_READY <= '1;
         my_if.coeff_x_i <= item.coeff_x_i;
         my_if.coeff_y_i <= item.coeff_y_i;
         @(posedge my_if.data_DONE);
         my_if.data_READY <= '0;        
         seq_item_port.item_done(item);
      end
   endtask
   
endclass
