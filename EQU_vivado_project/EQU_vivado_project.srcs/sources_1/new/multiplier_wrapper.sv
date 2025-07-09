module multiplier_wrapper #(parameter USE_IP = 0, parameter A_WIDTH = 32, parameter B_WIDTH = 32) (
    input logic [A_WIDTH-1:0]              a,
    input logic [B_WIDTH-1:0]              b,
    input logic                          clk,
    output logic [(B_WIDTH+A_WIDTH)-1:0] y
);

   generate
      if (USE_IP) begin
         // Instantiate vendor-specific multiplier IP
         mult_gen_0 tech_mult_inst (
                                    .A(a),
                                    .B(b),
                                    .P(y),
                                    .CLK(clk));
      end else begin
         assign y = a*b;           
      end
   endgenerate
endmodule
