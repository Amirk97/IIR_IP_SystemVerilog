import basic_sequence_item::*;

class my_driver extends uvm_driver#(basic_sequence_item#());

   `uvm_component_utils(my_driver)

   virtual IIR_if my_if;   

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);      
   endfunction

   virtual task run_phase(uvm_phase phase);
      basic_sequence_item#() item;
      forever begin
         seq_item_port.get_next_item(item);
         my_if.ready_and_i <= '1;         
         my_if.x_i <= item.x_i;
         my_if.valid_i <= '1;
         my_if.coeff_x_i <= item.coeff_x_i;
         my_if.coeff_y_i <= item.coeff_y_i;
         wait(my_if.ready_and_o == 1'b1);
         wait(my_if.ready_and_o == 1'b0);
         my_if.valid_i <= '0;        
         seq_item_port.item_done();
         `uvm_info("DRIVER",
                   "Drove item",
                   UVM_MEDIUM)
      end
   endtask
   
endclass
