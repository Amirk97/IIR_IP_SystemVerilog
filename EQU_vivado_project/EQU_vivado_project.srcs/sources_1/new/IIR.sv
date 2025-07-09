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
    parameter INPUT_TAPS = 3,
    parameter OUTPUT_TAPS = 2,
    parameter DATA_WIDTH = 24,
    parameter COEFF_WIDTH = 18,
    localparam MULTIPLY_WIDTH = DATA_WIDTH + COEFF_WIDTH - 1,
    localparam I_ACC_WIDTH = MULTIPLY_WIDTH + INPUT_TAPS - 1,
    localparam O_ACC_WIDTH = MULTIPLY_WIDTH + OUTPUT_TAPS - 1,
    localparam RES_ACC_WIDTH = (I_ACC_WIDTH>O_ACC_WIDTH) ? (I_ACC_WIDTH +1) : (O_ACC_WIDTH +1),
    localparam logic [RES_ACC_WIDTH:0] ROUNDING_ERROR = 2 ** (RES_ACC_WIDTH-DATA_WIDTH-1))
   (
    input logic [DATA_WIDTH-1:0]  x_i,
    output logic [DATA_WIDTH-1:0] y_o,

    input logic [COEFF_WIDTH-1:0] coeff_x_i [0:INPUT_TAPS],      
    input logic [COEFF_WIDTH-1:0] coeff_y_i [0:OUTPUT_TAPS-1],            
    
    input logic                         data_READY,
    output logic                        data_DONE,

    input logic                         clk_i,
    input logic                         rst_i);
   
   logic signed [DATA_WIDTH-1:0] input_tap [0:INPUT_TAPS-1];
   logic                         enable_itap;

   logic signed [DATA_WIDTH-1:0] output_tap [0:OUTPUT_TAPS-1];
   logic                         enable_otap;

   logic signed [COEFF_WIDTH-1:0] coeff_x [0:INPUT_TAPS-1];      
   logic signed [COEFF_WIDTH-1:0] coeff_y [0:OUTPUT_TAPS-1];

   logic signed [MULTIPLY_WIDTH:0] multi_prod_x [0:INPUT_TAPS-1];
   logic signed [MULTIPLY_WIDTH:0] multi_prod_y [0:OUTPUT_TAPS-1];

   logic signed [I_ACC_WIDTH:0]    acc_x ;
   logic signed [O_ACC_WIDTH:0]    acc_y ;
   logic signed [RES_ACC_WIDTH:0]  acc_res;

   logic [DATA_WIDTH-1:0] y;   
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
            else if (enable_itap) begin
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
      end

      multiplier_wrapper
        #(.USE_IP(1))
      i_muiltplier_inst (
                         .a(input_tap[i]),
                         .b(coeff_x[i]),
                         .clk(clk_i),
                         .y(multi_prod_x[i]));
      
   endgenerate


   generate

      for (i=0; i<OUTPUT_TAPS; i++) begin :  output_taps
         always_ff @ (posedge clk_i or negedge rst_i) begin
            if (~rst_i) begin             
               output_tap[i] <= '0;
               coeff_y[i] <= '0;
               acc_y[i] <= '0;               
            end
            else if (enable_otap) begin
               coeff_y[i] <= coeff_y_i[i];            
               if (i == '0)
                 output_tap [i] <= y;
               else
                 output_tap [i] <= output_tap[i-1];
            end
            else begin
               y <= acc_res[RES_ACC_WIDTH:RES_ACC_WIDTH-(DATA_WIDTH-1)];       
               acc_y += multi_prod_y[i];
            end
         end
      end :  output_taps

      multiplier_wrapper
        #(.USE_IP(1))
      o_muiltplier_inst (
                         .a(output_tap[i]),
                         .b(coeff_y[i]),
                         .clk(clk_i),
                         .y(multi_prod_y[i]));      
   endgenerate

   assign acc_res = acc_x - acc_y + ROUNDING_ERROR;   

endmodule
