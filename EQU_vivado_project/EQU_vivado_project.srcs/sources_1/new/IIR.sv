`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2025 01:25:07 PM
// Design Name: 
// Module Name: IIR
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


module IIR 
  #(
    parameter                          INPUT_TAPS = 3,
    parameter                          OUTPUT_TAPS = 2,
    parameter                          DATA_WIDTH = 24,
    parameter                          COEFF_WIDTH = 18,
    localparam                         FRACTIONAL_WIDTH = 15,
    localparam                         MULTIPLY_WIDTH = DATA_WIDTH + COEFF_WIDTH - 1,
    localparam                         I_ACC_WIDTH = MULTIPLY_WIDTH + INPUT_TAPS - 1,
    localparam                         O_ACC_WIDTH = MULTIPLY_WIDTH + OUTPUT_TAPS - 1,
    localparam                         RES_ACC_WIDTH = (I_ACC_WIDTH>O_ACC_WIDTH) ? (I_ACC_WIDTH +2) : (O_ACC_WIDTH +2), //2 also considering rounding error summation
    localparam logic [RES_ACC_WIDTH:0] ROUNDING_ERROR = 2 ** (FRACTIONAL_WIDTH-1),
    localparam logic [1:0]             PROCESS_DELAY = 3)
   (
    input logic [DATA_WIDTH-1:0]  x_i,
    output logic [DATA_WIDTH-1:0] y_o,

    input logic [COEFF_WIDTH-1:0] coeff_x_i [0:INPUT_TAPS], 
    input logic [COEFF_WIDTH-1:0] coeff_y_i [0:OUTPUT_TAPS-1], 
   
    input logic                   data_READY,
    output logic                  data_DONE,

    input logic                   clk_i,
    input logic                   rst_i);
   
   logic signed [DATA_WIDTH-1:0] input_tap [0:INPUT_TAPS-1];
   logic signed [DATA_WIDTH-1:0] output_tap [0:OUTPUT_TAPS-1];

   logic signed [COEFF_WIDTH-1:0] coeff_x [0:INPUT_TAPS-1];      
   logic signed [COEFF_WIDTH-1:0] coeff_y [0:OUTPUT_TAPS-1];

   logic signed [MULTIPLY_WIDTH:0] multi_prod_x [0:INPUT_TAPS-1];
   logic signed [MULTIPLY_WIDTH:0] multi_prod_y [0:OUTPUT_TAPS-1];

   logic signed [I_ACC_WIDTH:0]    acc_x ;
   logic signed [O_ACC_WIDTH:0]    acc_y ;
   logic signed [RES_ACC_WIDTH:0]  acc_res;
   logic signed [RES_ACC_WIDTH:0]  acc_res_rounded;

   logic                           tap_en;
   logic                           output_en;   

   logic [DATA_WIDTH-1:0]          y;   
   assign y_o = y; 

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
            else begin
               acc_x += multi_prod_x[i];         
            end
         end


         multiplier_wrapper
           #(.USE_IP(1))
         i_muiltplier_inst (
                            .a(input_tap[i]),
                            .b(coeff_x[i]),
                            .clk(clk_i),
                            .y(multi_prod_x[i]));
      end : input_taps
   endgenerate


   generate

      for (i=0; i<OUTPUT_TAPS; i++) begin :  output_taps
         always_ff @ (posedge clk_i or negedge rst_i) begin
            if (~rst_i) begin             
               output_tap[i] <= '0;
               coeff_y[i] <= '0;
               acc_y[i] <= '0;               
            end
            else if (tap_en) begin
               coeff_y[i] <= coeff_y_i[i];            
               if (i == '0)
                 output_tap [i] <= y;
               else
                 output_tap [i] <= output_tap[i-1];
            end
            else begin
               acc_y += multi_prod_y[i];
               if (output_en)
                 y_o <= y;
            end
         end


         multiplier_wrapper
           #(.USE_IP(1))
         o_muiltplier_inst (
                            .a(output_tap[i]),
                            .b(coeff_y[i]),
                            .clk(clk_i),
                            .y(multi_prod_y[i]));
      end :  output_taps
   endgenerate
   
   // Rounding
   assign acc_res = acc_x - acc_y;   
   assign acc_res_rounded = (acc_res>=0) ?  acc_res + ROUNDING_ERROR : acc_res - ROUNDING_ERROR;

   // Check for OF and UF assuming 24bits of data  
   always_comb begin
      if (^acc_res_rounded[RES_ACC_WIDTH:(FRACTIONAL_WIDTH+DATA_WIDTH-2)]) begin
         if(acc_res_rounded[RES_ACC_WIDTH])
           y  = {1'b1, {(DATA_WIDTH-1){1'b0}}};
         else
           y  = {1'b0, {(DATA_WIDTH-1){1'b1}}};
      end else begin
         y = acc_res_rounded[FRACTIONAL_WIDTH:FRACTIONAL_WIDTH+DATA_WIDTH-1];         
      end
   end

   //Control part

   typedef enum bit [2:0] {IDLE, LOAD, PROCESS, STORE} state_t;
   state_t  state;
   state_t  next_state;
   logic process_done;   

   always_ff @(posedge clk_i or negedge rst_i) begin : FSM
      if (~rst_i) begin
         state = IDLE;         
      end
      else begin
         state = next_state;         
      end
   end  : FSM

   always_comb begin
      // Default assignments so not get latches
      tap_en = '0;
      output_en = '0;      
      data_DONE = '0;      

      case(state)

        IDLE: begin
           if (data_READY == '1)
             next_state = LOAD;
           else
             next_state = IDLE;             
        end

        LOAD: begin
           next_state = PROCESS;
           tap_en = '1;
        end

        PROCESS: begin
           if (process_done == '1)
             next_state = STORE;
           else
             next_state = PROCESS;             
        end

        STORE: begin
           next_state = IDLE;
           output_en = '1;
           data_DONE = '1;      
        end

        default:
          next_state = IDLE;
      endcase
   end // always_comb

   logic [$bits(PROCESS_DELAY)-1:0] counter;
   
   always_ff @(posedge clk_i or negedge rst_i) begin : counter_reg
      if (~rst_i) begin
         counter = '0;         
      end
      else if (state ==  PROCESS) begin
         counter += 1'b1;         
      end
   end  : counter_reg

   always_comb begin
      if (counter == PROCESS_DELAY - 1'b1) begin
         process_done = '1;         
      end 
      else
        process_done = '0;
   end

endmodule
