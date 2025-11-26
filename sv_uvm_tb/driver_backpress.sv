
class driver_backpress extends my_driver;

   `uvm_component_utils(driver_backpress)

   bit     rand_ready;
   
   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);      
   endfunction

   virtual task run_phase(uvm_phase phase);
      basic_sequence_item#() item;
      fork
         begin : drive_DUT_input
            forever begin
               seq_item_port.get_next_item(item);
               my_if.x_i <= item.x_i;
               my_if.valid_i <= '1;
               my_if.coeff_x_i <= item.coeff_x_i;
               my_if.coeff_y_i <= item.coeff_y_i;
               my_if.coeff_index <= item.coeff_index;
               wait(my_if.ready_and_o == 1'b1);
               wait(my_if.ready_and_o == 1'b0);
               my_if.valid_i <= '0;        
               seq_item_port.item_done();
               `uvm_info("DRIVER",
                         "Drove item",
                         UVM_MEDIUM)
            end // forever begin
         end // block: drive_DUT_input

         begin : drive_DUT_output
            forever begin
               @(posedge my_if.clk_i)
                 assert(std::randomize(rand_ready) with {rand_ready dist {0 := 80, 1 := 20}; });               
               my_if.ready_and_i <= rand_ready;         
            end // forever begin
         end // block: drive_DUT_output
         
      join_none
   endtask
   
endclass
