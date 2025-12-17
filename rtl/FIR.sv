`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2025 01:25:07 PM
// Design Name: 
// Module Name: FIR
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FIR 
  #(
    parameter                                 INPUT_TAPS = 3,
    parameter                                 DATA_WIDTH = 24,
    parameter                                 COEFF_WIDTH = 18,
    parameter                                 DATA_FRAC_WIDTH = 0,
    parameter                                 COEFF_FRAC_WIDTH = 15,
    parameter                                 PROCESS_DELAY = 2, // This depends on the number of pipeline stages in the design, and is equal to 1 + PIPELINE_STAGE
    localparam                                FRAC_WIDTH = DATA_FRAC_WIDTH + COEFF_FRAC_WIDTH,
    localparam                                MULTIPLY_WIDTH = DATA_WIDTH + COEFF_WIDTH - 1,
    localparam                                I_ACC_WIDTH = MULTIPLY_WIDTH + INPUT_TAPS - 1,
    localparam                                RES_ACC_WIDTH = I_ACC_WIDTH +1, // 1 also considering rounding error summation
    localparam logic signed [RES_ACC_WIDTH:0] ROUNDING_ERROR = 2 ** (FRAC_WIDTH-1))
   (
    input logic [DATA_WIDTH-1:0]         x_i,
    output logic [DATA_WIDTH-1:0]        y_o,
    /* verilator coverage_off */
    // By purpose, coeffs are limited to finite sensible values
    input logic signed [COEFF_WIDTH-1:0] coeff_x_i [0:INPUT_TAPS-1], 
    /* verilator coverage_on */
    input logic                          valid_i,
    output logic                         ready_and_o,

    output logic                         valid_o,
    input logic                          ready_and_i,

    input logic                          clk_i,
    input logic                          rst_i);
   
   logic signed [DATA_WIDTH-1:0] input_tap [0:INPUT_TAPS-1];

   /* verilator coverage_off */
   // By purpose, coeffs are limited to finite sensible values
   logic signed [COEFF_WIDTH-1:0] coeff_x [0:INPUT_TAPS-1];      
   /* verilator coverage_on */

   logic signed [MULTIPLY_WIDTH:0] multi_prod_x [0:INPUT_TAPS-1];

   logic signed [I_ACC_WIDTH:0]    acc_x_reg ;
   logic signed [I_ACC_WIDTH:0]    acc_x_comb ;
   logic signed [RES_ACC_WIDTH:0]  acc_res_rounded;

   logic                           tap_en;
   logic                           output_en;   

   logic [DATA_WIDTH-1:0]          y;   
   logic [DATA_WIDTH-1:0]          y_tap;   

   // Data path
   genvar i;
   
   generate

      for (i=0; i<INPUT_TAPS; i++) begin :  input_taps
         always_ff @ (posedge clk_i or negedge rst_i) begin
            if (~rst_i) begin             
               input_tap[i] <= '0;
               coeff_x[i] <= '0;
            end
            else if (tap_en) begin
               coeff_x[i] <= coeff_x_i[i];
               if (i == '0)
                 input_tap [i] <= x_i;
               else
                 input_tap [i] <= input_tap[i-1];
            end
         end

         multiplier_wrapper
           #(.USE_IP(0),
             .A_WIDTH(DATA_WIDTH),
             .B_WIDTH(COEFF_WIDTH))
         i_muiltplier_inst (
                            .a(input_tap[i]),
                            .b(coeff_x[i]),
                            .clk(clk_i),
                            .y(multi_prod_x[i]));
      end : input_taps
   endgenerate
   
   // Turning off the verilator lint cause it's in a loop
   /* verilator lint_off WIDTHEXPAND */
   always_comb begin
      acc_x_comb = '0;   
      for (int i=0; i<INPUT_TAPS; i++) begin
         acc_x_comb += multi_prod_x[i];
      end
   end
   /* verilator lint_on WIDTHEXPAND */


   // This part is adding one pipeline stage therefore PROCESS_DELAY += 1
   always_ff @(posedge clk_i or negedge rst_i) begin
      if (~rst_i) begin
         acc_x_reg <= '0;
         y_tap <= '0;      
      end
      else begin
         if(state == PROCESS) begin
            acc_x_reg <= acc_x_comb;
         end
         if (output_en)
           y_tap <= y;         
      end
   end  
   assign y_o = y_tap ;
   
   assign acc_res_rounded = acc_x_reg + ROUNDING_ERROR;  // Also summation for negative numbers since later on slicing gonna round downwards

   // Check for saturation
   always_comb begin
      // Checking to see if the sign bits are uniform or not
      if (&acc_res_rounded[RES_ACC_WIDTH:(FRAC_WIDTH+DATA_WIDTH-1)] != |acc_res_rounded[RES_ACC_WIDTH:(FRAC_WIDTH+DATA_WIDTH-1)]) begin
         if(acc_res_rounded[RES_ACC_WIDTH])
           y  = {1'b1, {(DATA_WIDTH-1){1'b0}}};
         else
           y  = {1'b0, {(DATA_WIDTH-1){1'b1}}};
      end else begin
         y = acc_res_rounded[FRAC_WIDTH+DATA_WIDTH-1:FRAC_WIDTH];
      end
   end

   
   // Control part
   typedef enum bit [1:0] {IDLE, PROCESS, STORE} state_t;
   state_t  state;
   state_t  next_state;
   logic process_done;   

   always_ff @(posedge clk_i or negedge rst_i) begin : FSM
      if (~rst_i) begin
         state <= IDLE;
      end
      else begin
         state <= next_state;         
      end
   end  : FSM

   always_comb begin
      // Default assignments so not get latches
      tap_en = '0;
      output_en = '0;      

      case(state)

        IDLE: begin
           if (valid_i == '1 && ready_and_o == '1) begin
              next_state = PROCESS; // A mealy state for maximum speed hanshake between valid/ready
              tap_en = '1;
           end
           else
             next_state = IDLE;             
        end
        
        PROCESS: begin
           if (process_done == 1'b1 && valid_o == 1'b0) // If there's an output traffic on the output it will stall the IP here
             next_state = STORE;
           else
             next_state = PROCESS;             
        end

        STORE: begin
           output_en = '1;
           next_state = IDLE; 
           end
        // Turning coverage off cause this part is unreachable in simulation but necessary
        /* verilator coverage_off */
        default:
          next_state = IDLE;
        /* verilator coverage_on */
      endcase
   end // always_comb

   always_ff @(posedge clk_i or negedge rst_i) begin : VALID_O_READY_O
      if (~rst_i) begin
         valid_o <= 1'b0;
         ready_and_o <= 1'b0;         
      end
      else begin
         if (valid_o & ready_and_i)
           valid_o <= 1'b0;
         else if ((state == STORE))
           valid_o <= 1'b1;

         if (next_state == (IDLE) || ((next_state != PROCESS) && (state == (IDLE)))) begin 
            ready_and_o <= '1;
         end else begin
            ready_and_o <= '0;    
         end
      end
   end // block: VALID_O_READY_O


   generate
      if (PROCESS_DELAY <= 2) begin
         assign process_done = '1;
      end
      else begin
         // If the latency of the process state is custom(have used pipeline), then this part helps with generating appropriate done signal
         typedef logic unsigned [$clog2(PROCESS_DELAY):0] counter_t;   
         counter_t counter;
         
         always_ff @(posedge clk_i or negedge rst_i) begin : counter_reg
            if (~rst_i) begin
               counter <= '0;         
            end
            else if (state ==  PROCESS) begin
               counter <= counter + 1'b1;         
            end else
              counter <= '0;      
         end  : counter_reg

         always_comb begin
            if (counter == counter_t'(PROCESS_DELAY-2)) begin
               process_done = '1;         
            end 
            else begin
               process_done = '0;
            end
         end
      end // else: !if(PROCESS_DELAY <= 2)
   endgenerate
   
endmodule
