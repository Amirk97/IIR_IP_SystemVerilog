import basic_sequence_item::*;

class my_sequence extends uvm_sequence #(basic_sequence_item#());

   `uvm_object_utils(my_sequence)

   function new (string name = "my_sequence");
      super.new(name);
   endfunction

   task body();
      basic_sequence_item#() item;

      for(int i=0; i<1000; i++) begin
         item = basic_sequence_item#()::type_id::create("item");

         if (!item.randomize()) begin
            `uvm_fatal("RANDOM_FAIL","Failed to randomize the sequence");
         end

         start_item(item);
         finish_item(item);
      end
   endtask // body
   
endclass // my_sequence
