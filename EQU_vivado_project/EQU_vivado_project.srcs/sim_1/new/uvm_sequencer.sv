import basic_sequence_item::*;

class my_sequencer extends uvm_sequencer #(basic_sequence_item#());
   `uvm_component_utils(my_sequencer)

   function new ( string name, uvm_component parent);
      super.new(name, parent);      
   endfunction

endclass
