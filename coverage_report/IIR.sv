//      // verilator_coverage annotation
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
            parameter                                 INPUT_TAPS = 3,
            parameter                                 OUTPUT_TAPS = 2,
            parameter                                 DATA_WIDTH = 24,
            parameter                                 COEFF_WIDTH = 18,
            parameter                                 DATA_FRAC_WIDTH = 0,
            parameter                                 COEFF_FRAC_WIDTH = 15,
            parameter                                 PROCESS_DELAY = 2, // This depends on the number of pipeline stages in the design, and is equal to 1 + PIPELINE_STAGE
            localparam                                FRAC_WIDTH = DATA_FRAC_WIDTH + COEFF_FRAC_WIDTH,
            localparam                                MULTIPLY_WIDTH = DATA_WIDTH + COEFF_WIDTH - 1,
            localparam                                I_ACC_WIDTH = MULTIPLY_WIDTH + INPUT_TAPS - 1,
            localparam                                O_ACC_WIDTH = MULTIPLY_WIDTH + OUTPUT_TAPS - 1,
            localparam                                RES_ACC_WIDTH = (I_ACC_WIDTH>O_ACC_WIDTH) ? (I_ACC_WIDTH +2) : (O_ACC_WIDTH +2), // 2 also considering rounding error summation and summing acc_x and acc_y
            localparam logic signed [RES_ACC_WIDTH:0] ROUNDING_ERROR = 2 ** (FRAC_WIDTH-1))
           (
 001079     input logic [DATA_WIDTH-1:0]         x_i,
+001034  point: comment=x_i[0]:0->1 hier=IIR
+001030  point: comment=x_i[0]:1->0 hier=IIR
+001031  point: comment=x_i[10]:0->1 hier=IIR
+001028  point: comment=x_i[10]:1->0 hier=IIR
+001071  point: comment=x_i[11]:0->1 hier=IIR
+001068  point: comment=x_i[11]:1->0 hier=IIR
+001073  point: comment=x_i[12]:0->1 hier=IIR
+001071  point: comment=x_i[12]:1->0 hier=IIR
+001030  point: comment=x_i[13]:0->1 hier=IIR
+001027  point: comment=x_i[13]:1->0 hier=IIR
+001042  point: comment=x_i[14]:0->1 hier=IIR
+001042  point: comment=x_i[14]:1->0 hier=IIR
+001037  point: comment=x_i[15]:0->1 hier=IIR
+001032  point: comment=x_i[15]:1->0 hier=IIR
+001059  point: comment=x_i[16]:0->1 hier=IIR
+001055  point: comment=x_i[16]:1->0 hier=IIR
+001054  point: comment=x_i[17]:0->1 hier=IIR
+001050  point: comment=x_i[17]:1->0 hier=IIR
+001063  point: comment=x_i[18]:0->1 hier=IIR
+001059  point: comment=x_i[18]:1->0 hier=IIR
+001054  point: comment=x_i[19]:0->1 hier=IIR
+001049  point: comment=x_i[19]:1->0 hier=IIR
+001077  point: comment=x_i[1]:0->1 hier=IIR
+001075  point: comment=x_i[1]:1->0 hier=IIR
+001063  point: comment=x_i[20]:0->1 hier=IIR
+001059  point: comment=x_i[20]:1->0 hier=IIR
+001061  point: comment=x_i[21]:0->1 hier=IIR
+001059  point: comment=x_i[21]:1->0 hier=IIR
+001079  point: comment=x_i[22]:0->1 hier=IIR
+001074  point: comment=x_i[22]:1->0 hier=IIR
+001066  point: comment=x_i[23]:0->1 hier=IIR
+001062  point: comment=x_i[23]:1->0 hier=IIR
+001064  point: comment=x_i[2]:0->1 hier=IIR
+001062  point: comment=x_i[2]:1->0 hier=IIR
+001033  point: comment=x_i[3]:0->1 hier=IIR
+001029  point: comment=x_i[3]:1->0 hier=IIR
+001058  point: comment=x_i[4]:0->1 hier=IIR
+001055  point: comment=x_i[4]:1->0 hier=IIR
+001035  point: comment=x_i[5]:0->1 hier=IIR
+001032  point: comment=x_i[5]:1->0 hier=IIR
+001056  point: comment=x_i[6]:0->1 hier=IIR
+001053  point: comment=x_i[6]:1->0 hier=IIR
+001064  point: comment=x_i[7]:0->1 hier=IIR
+001060  point: comment=x_i[7]:1->0 hier=IIR
+001028  point: comment=x_i[8]:0->1 hier=IIR
+001024  point: comment=x_i[8]:1->0 hier=IIR
+001062  point: comment=x_i[9]:0->1 hier=IIR
+001059  point: comment=x_i[9]:1->0 hier=IIR
 000915     output logic [DATA_WIDTH-1:0]        y_o,
+000885  point: comment=y_o[0]:0->1 hier=IIR
+000881  point: comment=y_o[0]:1->0 hier=IIR
+000896  point: comment=y_o[10]:0->1 hier=IIR
+000893  point: comment=y_o[10]:1->0 hier=IIR
+000886  point: comment=y_o[11]:0->1 hier=IIR
+000883  point: comment=y_o[11]:1->0 hier=IIR
+000915  point: comment=y_o[12]:0->1 hier=IIR
+000913  point: comment=y_o[12]:1->0 hier=IIR
+000880  point: comment=y_o[13]:0->1 hier=IIR
+000877  point: comment=y_o[13]:1->0 hier=IIR
+000888  point: comment=y_o[14]:0->1 hier=IIR
+000886  point: comment=y_o[14]:1->0 hier=IIR
+000898  point: comment=y_o[15]:0->1 hier=IIR
+000895  point: comment=y_o[15]:1->0 hier=IIR
+000882  point: comment=y_o[16]:0->1 hier=IIR
+000877  point: comment=y_o[16]:1->0 hier=IIR
+000862  point: comment=y_o[17]:0->1 hier=IIR
+000860  point: comment=y_o[17]:1->0 hier=IIR
+000899  point: comment=y_o[18]:0->1 hier=IIR
+000896  point: comment=y_o[18]:1->0 hier=IIR
+000890  point: comment=y_o[19]:0->1 hier=IIR
+000887  point: comment=y_o[19]:1->0 hier=IIR
+000882  point: comment=y_o[1]:0->1 hier=IIR
+000880  point: comment=y_o[1]:1->0 hier=IIR
+000871  point: comment=y_o[20]:0->1 hier=IIR
+000867  point: comment=y_o[20]:1->0 hier=IIR
+000882  point: comment=y_o[21]:0->1 hier=IIR
+000881  point: comment=y_o[21]:1->0 hier=IIR
+000902  point: comment=y_o[22]:0->1 hier=IIR
+000898  point: comment=y_o[22]:1->0 hier=IIR
+000909  point: comment=y_o[23]:0->1 hier=IIR
+000904  point: comment=y_o[23]:1->0 hier=IIR
+000895  point: comment=y_o[2]:0->1 hier=IIR
+000894  point: comment=y_o[2]:1->0 hier=IIR
+000867  point: comment=y_o[3]:0->1 hier=IIR
+000865  point: comment=y_o[3]:1->0 hier=IIR
+000881  point: comment=y_o[4]:0->1 hier=IIR
+000878  point: comment=y_o[4]:1->0 hier=IIR
+000844  point: comment=y_o[5]:0->1 hier=IIR
+000841  point: comment=y_o[5]:1->0 hier=IIR
+000882  point: comment=y_o[6]:0->1 hier=IIR
+000881  point: comment=y_o[6]:1->0 hier=IIR
+000887  point: comment=y_o[7]:0->1 hier=IIR
+000886  point: comment=y_o[7]:1->0 hier=IIR
+000872  point: comment=y_o[8]:0->1 hier=IIR
+000867  point: comment=y_o[8]:1->0 hier=IIR
+000905  point: comment=y_o[9]:0->1 hier=IIR
+000903  point: comment=y_o[9]:1->0 hier=IIR
            /* verilator coverage_off */
            // By purpose, coeffs are limited to finite sensible values
            input logic signed [COEFF_WIDTH-1:0] coeff_x_i [0:INPUT_TAPS-1], 
            input logic signed [COEFF_WIDTH-1:0] coeff_y_i [0:OUTPUT_TAPS-1], 
            /* verilator coverage_on */
 000675     input logic                          valid_i,
+000675  point: comment=valid_i:0->1 hier=IIR
+000669  point: comment=valid_i:1->0 hier=IIR
 004221     output logic                         ready_and_o,
+004221  point: comment=ready_and_o:0->1 hier=IIR
+004220  point: comment=ready_and_o:1->0 hier=IIR
        
 002971     output logic                         valid_o,
+002971  point: comment=valid_o:0->1 hier=IIR
+002968  point: comment=valid_o:1->0 hier=IIR
 003690     input logic                          ready_and_i,
+003690  point: comment=ready_and_i:0->1 hier=IIR
+003685  point: comment=ready_and_i:1->0 hier=IIR
        
 027543     input logic                          clk_i,
+027543  point: comment=clk_i:0->1 hier=IIR
+027543  point: comment=clk_i:1->0 hier=IIR
 001250     input logic                          rst_i);
+001250  point: comment=rst_i:0->1 hier=IIR
+001243  point: comment=rst_i:1->0 hier=IIR
           
 001140    logic signed [DATA_WIDTH-1:0] input_tap [0:INPUT_TAPS-1];
+001089  point: comment=input_tap[0][0]:0->1 hier=IIR
+001085  point: comment=input_tap[0][0]:1->0 hier=IIR
+001085  point: comment=input_tap[0][10]:0->1 hier=IIR
+001082  point: comment=input_tap[0][10]:1->0 hier=IIR
+001117  point: comment=input_tap[0][11]:0->1 hier=IIR
+001115  point: comment=input_tap[0][11]:1->0 hier=IIR
+001093  point: comment=input_tap[0][12]:0->1 hier=IIR
+001091  point: comment=input_tap[0][12]:1->0 hier=IIR
+001106  point: comment=input_tap[0][13]:0->1 hier=IIR
+001103  point: comment=input_tap[0][13]:1->0 hier=IIR
+001119  point: comment=input_tap[0][14]:0->1 hier=IIR
+001119  point: comment=input_tap[0][14]:1->0 hier=IIR
+001100  point: comment=input_tap[0][15]:0->1 hier=IIR
+001096  point: comment=input_tap[0][15]:1->0 hier=IIR
+001105  point: comment=input_tap[0][16]:0->1 hier=IIR
+001102  point: comment=input_tap[0][16]:1->0 hier=IIR
+001095  point: comment=input_tap[0][17]:0->1 hier=IIR
+001092  point: comment=input_tap[0][17]:1->0 hier=IIR
+001120  point: comment=input_tap[0][18]:0->1 hier=IIR
+001117  point: comment=input_tap[0][18]:1->0 hier=IIR
+001093  point: comment=input_tap[0][19]:0->1 hier=IIR
+001089  point: comment=input_tap[0][19]:1->0 hier=IIR
+001092  point: comment=input_tap[0][1]:0->1 hier=IIR
+001090  point: comment=input_tap[0][1]:1->0 hier=IIR
+001104  point: comment=input_tap[0][20]:0->1 hier=IIR
+001101  point: comment=input_tap[0][20]:1->0 hier=IIR
+001110  point: comment=input_tap[0][21]:0->1 hier=IIR
+001109  point: comment=input_tap[0][21]:1->0 hier=IIR
+001136  point: comment=input_tap[0][22]:0->1 hier=IIR
+001131  point: comment=input_tap[0][22]:1->0 hier=IIR
+001140  point: comment=input_tap[0][23]:0->1 hier=IIR
+001136  point: comment=input_tap[0][23]:1->0 hier=IIR
+001099  point: comment=input_tap[0][2]:0->1 hier=IIR
+001097  point: comment=input_tap[0][2]:1->0 hier=IIR
+001075  point: comment=input_tap[0][3]:0->1 hier=IIR
+001072  point: comment=input_tap[0][3]:1->0 hier=IIR
+001102  point: comment=input_tap[0][4]:0->1 hier=IIR
+001100  point: comment=input_tap[0][4]:1->0 hier=IIR
+001085  point: comment=input_tap[0][5]:0->1 hier=IIR
+001083  point: comment=input_tap[0][5]:1->0 hier=IIR
+001114  point: comment=input_tap[0][6]:0->1 hier=IIR
+001111  point: comment=input_tap[0][6]:1->0 hier=IIR
+001092  point: comment=input_tap[0][7]:0->1 hier=IIR
+001089  point: comment=input_tap[0][7]:1->0 hier=IIR
+001086  point: comment=input_tap[0][8]:0->1 hier=IIR
+001083  point: comment=input_tap[0][8]:1->0 hier=IIR
+001100  point: comment=input_tap[0][9]:0->1 hier=IIR
+001098  point: comment=input_tap[0][9]:1->0 hier=IIR
+000785  point: comment=input_tap[1][0]:0->1 hier=IIR
+000782  point: comment=input_tap[1][0]:1->0 hier=IIR
+000776  point: comment=input_tap[1][10]:0->1 hier=IIR
+000773  point: comment=input_tap[1][10]:1->0 hier=IIR
+000824  point: comment=input_tap[1][11]:0->1 hier=IIR
+000822  point: comment=input_tap[1][11]:1->0 hier=IIR
+000796  point: comment=input_tap[1][12]:0->1 hier=IIR
+000794  point: comment=input_tap[1][12]:1->0 hier=IIR
+000788  point: comment=input_tap[1][13]:0->1 hier=IIR
+000786  point: comment=input_tap[1][13]:1->0 hier=IIR
+000805  point: comment=input_tap[1][14]:0->1 hier=IIR
+000805  point: comment=input_tap[1][14]:1->0 hier=IIR
+000776  point: comment=input_tap[1][15]:0->1 hier=IIR
+000772  point: comment=input_tap[1][15]:1->0 hier=IIR
+000797  point: comment=input_tap[1][16]:0->1 hier=IIR
+000793  point: comment=input_tap[1][16]:1->0 hier=IIR
+000785  point: comment=input_tap[1][17]:0->1 hier=IIR
+000783  point: comment=input_tap[1][17]:1->0 hier=IIR
+000806  point: comment=input_tap[1][18]:0->1 hier=IIR
+000802  point: comment=input_tap[1][18]:1->0 hier=IIR
+000802  point: comment=input_tap[1][19]:0->1 hier=IIR
+000799  point: comment=input_tap[1][19]:1->0 hier=IIR
+000788  point: comment=input_tap[1][1]:0->1 hier=IIR
+000787  point: comment=input_tap[1][1]:1->0 hier=IIR
+000784  point: comment=input_tap[1][20]:0->1 hier=IIR
+000780  point: comment=input_tap[1][20]:1->0 hier=IIR
+000792  point: comment=input_tap[1][21]:0->1 hier=IIR
+000792  point: comment=input_tap[1][21]:1->0 hier=IIR
+000805  point: comment=input_tap[1][22]:0->1 hier=IIR
+000800  point: comment=input_tap[1][22]:1->0 hier=IIR
+000813  point: comment=input_tap[1][23]:0->1 hier=IIR
+000808  point: comment=input_tap[1][23]:1->0 hier=IIR
+000801  point: comment=input_tap[1][2]:0->1 hier=IIR
+000799  point: comment=input_tap[1][2]:1->0 hier=IIR
+000773  point: comment=input_tap[1][3]:0->1 hier=IIR
+000771  point: comment=input_tap[1][3]:1->0 hier=IIR
+000801  point: comment=input_tap[1][4]:0->1 hier=IIR
+000799  point: comment=input_tap[1][4]:1->0 hier=IIR
+000794  point: comment=input_tap[1][5]:0->1 hier=IIR
+000792  point: comment=input_tap[1][5]:1->0 hier=IIR
+000787  point: comment=input_tap[1][6]:0->1 hier=IIR
+000784  point: comment=input_tap[1][6]:1->0 hier=IIR
+000788  point: comment=input_tap[1][7]:0->1 hier=IIR
+000785  point: comment=input_tap[1][7]:1->0 hier=IIR
+000773  point: comment=input_tap[1][8]:0->1 hier=IIR
+000770  point: comment=input_tap[1][8]:1->0 hier=IIR
+000818  point: comment=input_tap[1][9]:0->1 hier=IIR
+000815  point: comment=input_tap[1][9]:1->0 hier=IIR
+000611  point: comment=input_tap[2][0]:0->1 hier=IIR
+000608  point: comment=input_tap[2][0]:1->0 hier=IIR
+000610  point: comment=input_tap[2][10]:0->1 hier=IIR
+000608  point: comment=input_tap[2][10]:1->0 hier=IIR
+000638  point: comment=input_tap[2][11]:0->1 hier=IIR
+000637  point: comment=input_tap[2][11]:1->0 hier=IIR
+000635  point: comment=input_tap[2][12]:0->1 hier=IIR
+000635  point: comment=input_tap[2][12]:1->0 hier=IIR
+000618  point: comment=input_tap[2][13]:0->1 hier=IIR
+000617  point: comment=input_tap[2][13]:1->0 hier=IIR
+000632  point: comment=input_tap[2][14]:0->1 hier=IIR
+000631  point: comment=input_tap[2][14]:1->0 hier=IIR
+000604  point: comment=input_tap[2][15]:0->1 hier=IIR
+000602  point: comment=input_tap[2][15]:1->0 hier=IIR
+000635  point: comment=input_tap[2][16]:0->1 hier=IIR
+000633  point: comment=input_tap[2][16]:1->0 hier=IIR
+000629  point: comment=input_tap[2][17]:0->1 hier=IIR
+000627  point: comment=input_tap[2][17]:1->0 hier=IIR
+000645  point: comment=input_tap[2][18]:0->1 hier=IIR
+000642  point: comment=input_tap[2][18]:1->0 hier=IIR
+000623  point: comment=input_tap[2][19]:0->1 hier=IIR
+000621  point: comment=input_tap[2][19]:1->0 hier=IIR
+000622  point: comment=input_tap[2][1]:0->1 hier=IIR
+000621  point: comment=input_tap[2][1]:1->0 hier=IIR
+000618  point: comment=input_tap[2][20]:0->1 hier=IIR
+000617  point: comment=input_tap[2][20]:1->0 hier=IIR
+000627  point: comment=input_tap[2][21]:0->1 hier=IIR
+000626  point: comment=input_tap[2][21]:1->0 hier=IIR
+000632  point: comment=input_tap[2][22]:0->1 hier=IIR
+000630  point: comment=input_tap[2][22]:1->0 hier=IIR
+000625  point: comment=input_tap[2][23]:0->1 hier=IIR
+000622  point: comment=input_tap[2][23]:1->0 hier=IIR
+000624  point: comment=input_tap[2][2]:0->1 hier=IIR
+000623  point: comment=input_tap[2][2]:1->0 hier=IIR
+000603  point: comment=input_tap[2][3]:0->1 hier=IIR
+000602  point: comment=input_tap[2][3]:1->0 hier=IIR
+000630  point: comment=input_tap[2][4]:0->1 hier=IIR
+000628  point: comment=input_tap[2][4]:1->0 hier=IIR
+000615  point: comment=input_tap[2][5]:0->1 hier=IIR
+000614  point: comment=input_tap[2][5]:1->0 hier=IIR
+000627  point: comment=input_tap[2][6]:0->1 hier=IIR
+000625  point: comment=input_tap[2][6]:1->0 hier=IIR
+000624  point: comment=input_tap[2][7]:0->1 hier=IIR
+000622  point: comment=input_tap[2][7]:1->0 hier=IIR
+000599  point: comment=input_tap[2][8]:0->1 hier=IIR
+000597  point: comment=input_tap[2][8]:1->0 hier=IIR
+000632  point: comment=input_tap[2][9]:0->1 hier=IIR
+000630  point: comment=input_tap[2][9]:1->0 hier=IIR
 000815    logic signed [DATA_WIDTH-1:0] output_tap [0:OUTPUT_TAPS-1];
+000793  point: comment=output_tap[0][0]:0->1 hier=IIR
+000789  point: comment=output_tap[0][0]:1->0 hier=IIR
+000792  point: comment=output_tap[0][10]:0->1 hier=IIR
+000789  point: comment=output_tap[0][10]:1->0 hier=IIR
+000790  point: comment=output_tap[0][11]:0->1 hier=IIR
+000787  point: comment=output_tap[0][11]:1->0 hier=IIR
+000805  point: comment=output_tap[0][12]:0->1 hier=IIR
+000803  point: comment=output_tap[0][12]:1->0 hier=IIR
+000787  point: comment=output_tap[0][13]:0->1 hier=IIR
+000784  point: comment=output_tap[0][13]:1->0 hier=IIR
+000795  point: comment=output_tap[0][14]:0->1 hier=IIR
+000793  point: comment=output_tap[0][14]:1->0 hier=IIR
+000799  point: comment=output_tap[0][15]:0->1 hier=IIR
+000796  point: comment=output_tap[0][15]:1->0 hier=IIR
+000793  point: comment=output_tap[0][16]:0->1 hier=IIR
+000788  point: comment=output_tap[0][16]:1->0 hier=IIR
+000769  point: comment=output_tap[0][17]:0->1 hier=IIR
+000767  point: comment=output_tap[0][17]:1->0 hier=IIR
+000797  point: comment=output_tap[0][18]:0->1 hier=IIR
+000794  point: comment=output_tap[0][18]:1->0 hier=IIR
+000806  point: comment=output_tap[0][19]:0->1 hier=IIR
+000803  point: comment=output_tap[0][19]:1->0 hier=IIR
+000783  point: comment=output_tap[0][1]:0->1 hier=IIR
+000781  point: comment=output_tap[0][1]:1->0 hier=IIR
+000764  point: comment=output_tap[0][20]:0->1 hier=IIR
+000760  point: comment=output_tap[0][20]:1->0 hier=IIR
+000789  point: comment=output_tap[0][21]:0->1 hier=IIR
+000788  point: comment=output_tap[0][21]:1->0 hier=IIR
+000803  point: comment=output_tap[0][22]:0->1 hier=IIR
+000799  point: comment=output_tap[0][22]:1->0 hier=IIR
+000792  point: comment=output_tap[0][23]:0->1 hier=IIR
+000787  point: comment=output_tap[0][23]:1->0 hier=IIR
+000790  point: comment=output_tap[0][2]:0->1 hier=IIR
+000789  point: comment=output_tap[0][2]:1->0 hier=IIR
+000772  point: comment=output_tap[0][3]:0->1 hier=IIR
+000770  point: comment=output_tap[0][3]:1->0 hier=IIR
+000780  point: comment=output_tap[0][4]:0->1 hier=IIR
+000777  point: comment=output_tap[0][4]:1->0 hier=IIR
+000755  point: comment=output_tap[0][5]:0->1 hier=IIR
+000752  point: comment=output_tap[0][5]:1->0 hier=IIR
+000790  point: comment=output_tap[0][6]:0->1 hier=IIR
+000789  point: comment=output_tap[0][6]:1->0 hier=IIR
+000790  point: comment=output_tap[0][7]:0->1 hier=IIR
+000789  point: comment=output_tap[0][7]:1->0 hier=IIR
+000781  point: comment=output_tap[0][8]:0->1 hier=IIR
+000776  point: comment=output_tap[0][8]:1->0 hier=IIR
+000815  point: comment=output_tap[0][9]:0->1 hier=IIR
+000813  point: comment=output_tap[0][9]:1->0 hier=IIR
+000616  point: comment=output_tap[1][0]:0->1 hier=IIR
+000614  point: comment=output_tap[1][0]:1->0 hier=IIR
+000601  point: comment=output_tap[1][10]:0->1 hier=IIR
+000599  point: comment=output_tap[1][10]:1->0 hier=IIR
+000617  point: comment=output_tap[1][11]:0->1 hier=IIR
+000614  point: comment=output_tap[1][11]:1->0 hier=IIR
+000630  point: comment=output_tap[1][12]:0->1 hier=IIR
+000629  point: comment=output_tap[1][12]:1->0 hier=IIR
+000624  point: comment=output_tap[1][13]:0->1 hier=IIR
+000621  point: comment=output_tap[1][13]:1->0 hier=IIR
+000630  point: comment=output_tap[1][14]:0->1 hier=IIR
+000628  point: comment=output_tap[1][14]:1->0 hier=IIR
+000630  point: comment=output_tap[1][15]:0->1 hier=IIR
+000627  point: comment=output_tap[1][15]:1->0 hier=IIR
+000622  point: comment=output_tap[1][16]:0->1 hier=IIR
+000620  point: comment=output_tap[1][16]:1->0 hier=IIR
+000618  point: comment=output_tap[1][17]:0->1 hier=IIR
+000615  point: comment=output_tap[1][17]:1->0 hier=IIR
+000638  point: comment=output_tap[1][18]:0->1 hier=IIR
+000635  point: comment=output_tap[1][18]:1->0 hier=IIR
+000622  point: comment=output_tap[1][19]:0->1 hier=IIR
+000620  point: comment=output_tap[1][19]:1->0 hier=IIR
+000606  point: comment=output_tap[1][1]:0->1 hier=IIR
+000605  point: comment=output_tap[1][1]:1->0 hier=IIR
+000601  point: comment=output_tap[1][20]:0->1 hier=IIR
+000600  point: comment=output_tap[1][20]:1->0 hier=IIR
+000621  point: comment=output_tap[1][21]:0->1 hier=IIR
+000620  point: comment=output_tap[1][21]:1->0 hier=IIR
+000630  point: comment=output_tap[1][22]:0->1 hier=IIR
+000628  point: comment=output_tap[1][22]:1->0 hier=IIR
+000603  point: comment=output_tap[1][23]:0->1 hier=IIR
+000600  point: comment=output_tap[1][23]:1->0 hier=IIR
+000625  point: comment=output_tap[1][2]:0->1 hier=IIR
+000623  point: comment=output_tap[1][2]:1->0 hier=IIR
+000614  point: comment=output_tap[1][3]:0->1 hier=IIR
+000613  point: comment=output_tap[1][3]:1->0 hier=IIR
+000615  point: comment=output_tap[1][4]:0->1 hier=IIR
+000613  point: comment=output_tap[1][4]:1->0 hier=IIR
+000592  point: comment=output_tap[1][5]:0->1 hier=IIR
+000591  point: comment=output_tap[1][5]:1->0 hier=IIR
+000627  point: comment=output_tap[1][6]:0->1 hier=IIR
+000626  point: comment=output_tap[1][6]:1->0 hier=IIR
+000618  point: comment=output_tap[1][7]:0->1 hier=IIR
+000617  point: comment=output_tap[1][7]:1->0 hier=IIR
+000598  point: comment=output_tap[1][8]:0->1 hier=IIR
+000596  point: comment=output_tap[1][8]:1->0 hier=IIR
+000626  point: comment=output_tap[1][9]:0->1 hier=IIR
+000623  point: comment=output_tap[1][9]:1->0 hier=IIR
        
           /* verilator coverage_off */
           // By purpose, coeffs are limited to finite sensible values
           logic signed [COEFF_WIDTH-1:0] coeff_x [0:INPUT_TAPS-1];      
           logic signed [COEFF_WIDTH-1:0] coeff_y [0:OUTPUT_TAPS-1];
           /* verilator coverage_on */
        
 001141    logic signed [MULTIPLY_WIDTH:0] multi_prod_x [0:INPUT_TAPS-1];
+000747  point: comment=multi_prod_x[0][0]:0->1 hier=IIR
+000746  point: comment=multi_prod_x[0][0]:1->0 hier=IIR
+001033  point: comment=multi_prod_x[0][10]:0->1 hier=IIR
+001032  point: comment=multi_prod_x[0][10]:1->0 hier=IIR
+001057  point: comment=multi_prod_x[0][11]:0->1 hier=IIR
+001057  point: comment=multi_prod_x[0][11]:1->0 hier=IIR
+000994  point: comment=multi_prod_x[0][12]:0->1 hier=IIR
+000991  point: comment=multi_prod_x[0][12]:1->0 hier=IIR
+001020  point: comment=multi_prod_x[0][13]:0->1 hier=IIR
+001017  point: comment=multi_prod_x[0][13]:1->0 hier=IIR
+001026  point: comment=multi_prod_x[0][14]:0->1 hier=IIR
+001025  point: comment=multi_prod_x[0][14]:1->0 hier=IIR
+000994  point: comment=multi_prod_x[0][15]:0->1 hier=IIR
+000992  point: comment=multi_prod_x[0][15]:1->0 hier=IIR
+001020  point: comment=multi_prod_x[0][16]:0->1 hier=IIR
+001017  point: comment=multi_prod_x[0][16]:1->0 hier=IIR
+001022  point: comment=multi_prod_x[0][17]:0->1 hier=IIR
+001020  point: comment=multi_prod_x[0][17]:1->0 hier=IIR
+001015  point: comment=multi_prod_x[0][18]:0->1 hier=IIR
+001013  point: comment=multi_prod_x[0][18]:1->0 hier=IIR
+001007  point: comment=multi_prod_x[0][19]:0->1 hier=IIR
+001005  point: comment=multi_prod_x[0][19]:1->0 hier=IIR
+000868  point: comment=multi_prod_x[0][1]:0->1 hier=IIR
+000866  point: comment=multi_prod_x[0][1]:1->0 hier=IIR
+001010  point: comment=multi_prod_x[0][20]:0->1 hier=IIR
+001009  point: comment=multi_prod_x[0][20]:1->0 hier=IIR
+001003  point: comment=multi_prod_x[0][21]:0->1 hier=IIR
+001002  point: comment=multi_prod_x[0][21]:1->0 hier=IIR
+000999  point: comment=multi_prod_x[0][22]:0->1 hier=IIR
+000996  point: comment=multi_prod_x[0][22]:1->0 hier=IIR
+001015  point: comment=multi_prod_x[0][23]:0->1 hier=IIR
+001014  point: comment=multi_prod_x[0][23]:1->0 hier=IIR
+000993  point: comment=multi_prod_x[0][24]:0->1 hier=IIR
+000990  point: comment=multi_prod_x[0][24]:1->0 hier=IIR
+001004  point: comment=multi_prod_x[0][25]:0->1 hier=IIR
+001000  point: comment=multi_prod_x[0][25]:1->0 hier=IIR
+001026  point: comment=multi_prod_x[0][26]:0->1 hier=IIR
+001023  point: comment=multi_prod_x[0][26]:1->0 hier=IIR
+001028  point: comment=multi_prod_x[0][27]:0->1 hier=IIR
+001026  point: comment=multi_prod_x[0][27]:1->0 hier=IIR
+001032  point: comment=multi_prod_x[0][28]:0->1 hier=IIR
+001029  point: comment=multi_prod_x[0][28]:1->0 hier=IIR
+001019  point: comment=multi_prod_x[0][29]:0->1 hier=IIR
+001018  point: comment=multi_prod_x[0][29]:1->0 hier=IIR
+000955  point: comment=multi_prod_x[0][2]:0->1 hier=IIR
+000953  point: comment=multi_prod_x[0][2]:1->0 hier=IIR
+000993  point: comment=multi_prod_x[0][30]:0->1 hier=IIR
+000991  point: comment=multi_prod_x[0][30]:1->0 hier=IIR
+001121  point: comment=multi_prod_x[0][31]:0->1 hier=IIR
+001116  point: comment=multi_prod_x[0][31]:1->0 hier=IIR
+001089  point: comment=multi_prod_x[0][32]:0->1 hier=IIR
+001085  point: comment=multi_prod_x[0][32]:1->0 hier=IIR
+001106  point: comment=multi_prod_x[0][33]:0->1 hier=IIR
+001103  point: comment=multi_prod_x[0][33]:1->0 hier=IIR
+001075  point: comment=multi_prod_x[0][34]:0->1 hier=IIR
+001072  point: comment=multi_prod_x[0][34]:1->0 hier=IIR
+001075  point: comment=multi_prod_x[0][35]:0->1 hier=IIR
+001071  point: comment=multi_prod_x[0][35]:1->0 hier=IIR
+001083  point: comment=multi_prod_x[0][36]:0->1 hier=IIR
+001079  point: comment=multi_prod_x[0][36]:1->0 hier=IIR
+001122  point: comment=multi_prod_x[0][37]:0->1 hier=IIR
+001119  point: comment=multi_prod_x[0][37]:1->0 hier=IIR
+001081  point: comment=multi_prod_x[0][38]:0->1 hier=IIR
+001079  point: comment=multi_prod_x[0][38]:1->0 hier=IIR
+001090  point: comment=multi_prod_x[0][39]:0->1 hier=IIR
+001086  point: comment=multi_prod_x[0][39]:1->0 hier=IIR
+001057  point: comment=multi_prod_x[0][3]:0->1 hier=IIR
+001056  point: comment=multi_prod_x[0][3]:1->0 hier=IIR
+001098  point: comment=multi_prod_x[0][40]:0->1 hier=IIR
+001094  point: comment=multi_prod_x[0][40]:1->0 hier=IIR
+001110  point: comment=multi_prod_x[0][41]:0->1 hier=IIR
+001108  point: comment=multi_prod_x[0][41]:1->0 hier=IIR
+001095  point: comment=multi_prod_x[0][42]:0->1 hier=IIR
+001091  point: comment=multi_prod_x[0][42]:1->0 hier=IIR
+001102  point: comment=multi_prod_x[0][43]:0->1 hier=IIR
+001099  point: comment=multi_prod_x[0][43]:1->0 hier=IIR
+001086  point: comment=multi_prod_x[0][44]:0->1 hier=IIR
+001081  point: comment=multi_prod_x[0][44]:1->0 hier=IIR
+001091  point: comment=multi_prod_x[0][45]:0->1 hier=IIR
+001089  point: comment=multi_prod_x[0][45]:1->0 hier=IIR
+001104  point: comment=multi_prod_x[0][46]:0->1 hier=IIR
+001100  point: comment=multi_prod_x[0][46]:1->0 hier=IIR
+001100  point: comment=multi_prod_x[0][47]:0->1 hier=IIR
+001095  point: comment=multi_prod_x[0][47]:1->0 hier=IIR
+001090  point: comment=multi_prod_x[0][48]:0->1 hier=IIR
+001088  point: comment=multi_prod_x[0][48]:1->0 hier=IIR
+001111  point: comment=multi_prod_x[0][49]:0->1 hier=IIR
+001108  point: comment=multi_prod_x[0][49]:1->0 hier=IIR
+000994  point: comment=multi_prod_x[0][4]:0->1 hier=IIR
+000992  point: comment=multi_prod_x[0][4]:1->0 hier=IIR
+001081  point: comment=multi_prod_x[0][50]:0->1 hier=IIR
+001077  point: comment=multi_prod_x[0][50]:1->0 hier=IIR
+001102  point: comment=multi_prod_x[0][51]:0->1 hier=IIR
+001099  point: comment=multi_prod_x[0][51]:1->0 hier=IIR
+001106  point: comment=multi_prod_x[0][52]:0->1 hier=IIR
+001103  point: comment=multi_prod_x[0][52]:1->0 hier=IIR
+001131  point: comment=multi_prod_x[0][53]:0->1 hier=IIR
+001125  point: comment=multi_prod_x[0][53]:1->0 hier=IIR
+001141  point: comment=multi_prod_x[0][54]:0->1 hier=IIR
+001138  point: comment=multi_prod_x[0][54]:1->0 hier=IIR
+001140  point: comment=multi_prod_x[0][55]:0->1 hier=IIR
+001136  point: comment=multi_prod_x[0][55]:1->0 hier=IIR
+001140  point: comment=multi_prod_x[0][56]:0->1 hier=IIR
+001136  point: comment=multi_prod_x[0][56]:1->0 hier=IIR
+001140  point: comment=multi_prod_x[0][57]:0->1 hier=IIR
+001136  point: comment=multi_prod_x[0][57]:1->0 hier=IIR
+001003  point: comment=multi_prod_x[0][5]:0->1 hier=IIR
+001002  point: comment=multi_prod_x[0][5]:1->0 hier=IIR
+000984  point: comment=multi_prod_x[0][6]:0->1 hier=IIR
+000983  point: comment=multi_prod_x[0][6]:1->0 hier=IIR
+001022  point: comment=multi_prod_x[0][7]:0->1 hier=IIR
+001020  point: comment=multi_prod_x[0][7]:1->0 hier=IIR
+001007  point: comment=multi_prod_x[0][8]:0->1 hier=IIR
+001006  point: comment=multi_prod_x[0][8]:1->0 hier=IIR
+001012  point: comment=multi_prod_x[0][9]:0->1 hier=IIR
+001011  point: comment=multi_prod_x[0][9]:1->0 hier=IIR
+000359  point: comment=multi_prod_x[1][0]:0->1 hier=IIR
+000357  point: comment=multi_prod_x[1][0]:1->0 hier=IIR
+000810  point: comment=multi_prod_x[1][10]:0->1 hier=IIR
+000807  point: comment=multi_prod_x[1][10]:1->0 hier=IIR
+000771  point: comment=multi_prod_x[1][11]:0->1 hier=IIR
+000769  point: comment=multi_prod_x[1][11]:1->0 hier=IIR
+000771  point: comment=multi_prod_x[1][12]:0->1 hier=IIR
+000768  point: comment=multi_prod_x[1][12]:1->0 hier=IIR
+000764  point: comment=multi_prod_x[1][13]:0->1 hier=IIR
+000762  point: comment=multi_prod_x[1][13]:1->0 hier=IIR
+000775  point: comment=multi_prod_x[1][14]:0->1 hier=IIR
+000771  point: comment=multi_prod_x[1][14]:1->0 hier=IIR
+000823  point: comment=multi_prod_x[1][15]:0->1 hier=IIR
+000821  point: comment=multi_prod_x[1][15]:1->0 hier=IIR
+000791  point: comment=multi_prod_x[1][16]:0->1 hier=IIR
+000788  point: comment=multi_prod_x[1][16]:1->0 hier=IIR
+000810  point: comment=multi_prod_x[1][17]:0->1 hier=IIR
+000808  point: comment=multi_prod_x[1][17]:1->0 hier=IIR
+000779  point: comment=multi_prod_x[1][18]:0->1 hier=IIR
+000775  point: comment=multi_prod_x[1][18]:1->0 hier=IIR
+000806  point: comment=multi_prod_x[1][19]:0->1 hier=IIR
+000801  point: comment=multi_prod_x[1][19]:1->0 hier=IIR
+000569  point: comment=multi_prod_x[1][1]:0->1 hier=IIR
+000567  point: comment=multi_prod_x[1][1]:1->0 hier=IIR
+000796  point: comment=multi_prod_x[1][20]:0->1 hier=IIR
+000796  point: comment=multi_prod_x[1][20]:1->0 hier=IIR
+000786  point: comment=multi_prod_x[1][21]:0->1 hier=IIR
+000785  point: comment=multi_prod_x[1][21]:1->0 hier=IIR
+000780  point: comment=multi_prod_x[1][22]:0->1 hier=IIR
+000779  point: comment=multi_prod_x[1][22]:1->0 hier=IIR
+000791  point: comment=multi_prod_x[1][23]:0->1 hier=IIR
+000789  point: comment=multi_prod_x[1][23]:1->0 hier=IIR
+000796  point: comment=multi_prod_x[1][24]:0->1 hier=IIR
+000795  point: comment=multi_prod_x[1][24]:1->0 hier=IIR
+000806  point: comment=multi_prod_x[1][25]:0->1 hier=IIR
+000804  point: comment=multi_prod_x[1][25]:1->0 hier=IIR
+000781  point: comment=multi_prod_x[1][26]:0->1 hier=IIR
+000777  point: comment=multi_prod_x[1][26]:1->0 hier=IIR
+000788  point: comment=multi_prod_x[1][27]:0->1 hier=IIR
+000785  point: comment=multi_prod_x[1][27]:1->0 hier=IIR
+000786  point: comment=multi_prod_x[1][28]:0->1 hier=IIR
+000784  point: comment=multi_prod_x[1][28]:1->0 hier=IIR
+000780  point: comment=multi_prod_x[1][29]:0->1 hier=IIR
+000778  point: comment=multi_prod_x[1][29]:1->0 hier=IIR
+000640  point: comment=multi_prod_x[1][2]:0->1 hier=IIR
+000636  point: comment=multi_prod_x[1][2]:1->0 hier=IIR
+000794  point: comment=multi_prod_x[1][30]:0->1 hier=IIR
+000792  point: comment=multi_prod_x[1][30]:1->0 hier=IIR
+000770  point: comment=multi_prod_x[1][31]:0->1 hier=IIR
+000767  point: comment=multi_prod_x[1][31]:1->0 hier=IIR
+000792  point: comment=multi_prod_x[1][32]:0->1 hier=IIR
+000792  point: comment=multi_prod_x[1][32]:1->0 hier=IIR
+000791  point: comment=multi_prod_x[1][33]:0->1 hier=IIR
+000789  point: comment=multi_prod_x[1][33]:1->0 hier=IIR
+000794  point: comment=multi_prod_x[1][34]:0->1 hier=IIR
+000790  point: comment=multi_prod_x[1][34]:1->0 hier=IIR
+000786  point: comment=multi_prod_x[1][35]:0->1 hier=IIR
+000782  point: comment=multi_prod_x[1][35]:1->0 hier=IIR
+000793  point: comment=multi_prod_x[1][36]:0->1 hier=IIR
+000791  point: comment=multi_prod_x[1][36]:1->0 hier=IIR
+000785  point: comment=multi_prod_x[1][37]:0->1 hier=IIR
+000781  point: comment=multi_prod_x[1][37]:1->0 hier=IIR
+000788  point: comment=multi_prod_x[1][38]:0->1 hier=IIR
+000786  point: comment=multi_prod_x[1][38]:1->0 hier=IIR
+000779  point: comment=multi_prod_x[1][39]:0->1 hier=IIR
+000779  point: comment=multi_prod_x[1][39]:1->0 hier=IIR
+000691  point: comment=multi_prod_x[1][3]:0->1 hier=IIR
+000689  point: comment=multi_prod_x[1][3]:1->0 hier=IIR
+000745  point: comment=multi_prod_x[1][40]:0->1 hier=IIR
+000741  point: comment=multi_prod_x[1][40]:1->0 hier=IIR
+000790  point: comment=multi_prod_x[1][41]:0->1 hier=IIR
+000787  point: comment=multi_prod_x[1][41]:1->0 hier=IIR
+000772  point: comment=multi_prod_x[1][42]:0->1 hier=IIR
+000769  point: comment=multi_prod_x[1][42]:1->0 hier=IIR
+000795  point: comment=multi_prod_x[1][43]:0->1 hier=IIR
+000793  point: comment=multi_prod_x[1][43]:1->0 hier=IIR
+000777  point: comment=multi_prod_x[1][44]:0->1 hier=IIR
+000775  point: comment=multi_prod_x[1][44]:1->0 hier=IIR
+000797  point: comment=multi_prod_x[1][45]:0->1 hier=IIR
+000796  point: comment=multi_prod_x[1][45]:1->0 hier=IIR
+000778  point: comment=multi_prod_x[1][46]:0->1 hier=IIR
+000776  point: comment=multi_prod_x[1][46]:1->0 hier=IIR
+000766  point: comment=multi_prod_x[1][47]:0->1 hier=IIR
+000764  point: comment=multi_prod_x[1][47]:1->0 hier=IIR
+000818  point: comment=multi_prod_x[1][48]:0->1 hier=IIR
+000817  point: comment=multi_prod_x[1][48]:1->0 hier=IIR
+000789  point: comment=multi_prod_x[1][49]:0->1 hier=IIR
+000788  point: comment=multi_prod_x[1][49]:1->0 hier=IIR
+000770  point: comment=multi_prod_x[1][4]:0->1 hier=IIR
+000770  point: comment=multi_prod_x[1][4]:1->0 hier=IIR
+000801  point: comment=multi_prod_x[1][50]:0->1 hier=IIR
+000798  point: comment=multi_prod_x[1][50]:1->0 hier=IIR
+000779  point: comment=multi_prod_x[1][51]:0->1 hier=IIR
+000775  point: comment=multi_prod_x[1][51]:1->0 hier=IIR
+000793  point: comment=multi_prod_x[1][52]:0->1 hier=IIR
+000792  point: comment=multi_prod_x[1][52]:1->0 hier=IIR
+000805  point: comment=multi_prod_x[1][53]:0->1 hier=IIR
+000799  point: comment=multi_prod_x[1][53]:1->0 hier=IIR
+000795  point: comment=multi_prod_x[1][54]:0->1 hier=IIR
+000794  point: comment=multi_prod_x[1][54]:1->0 hier=IIR
+000764  point: comment=multi_prod_x[1][55]:0->1 hier=IIR
+000763  point: comment=multi_prod_x[1][55]:1->0 hier=IIR
+000764  point: comment=multi_prod_x[1][56]:0->1 hier=IIR
+000763  point: comment=multi_prod_x[1][56]:1->0 hier=IIR
+000764  point: comment=multi_prod_x[1][57]:0->1 hier=IIR
+000763  point: comment=multi_prod_x[1][57]:1->0 hier=IIR
+000790  point: comment=multi_prod_x[1][5]:0->1 hier=IIR
+000788  point: comment=multi_prod_x[1][5]:1->0 hier=IIR
+000754  point: comment=multi_prod_x[1][6]:0->1 hier=IIR
+000752  point: comment=multi_prod_x[1][6]:1->0 hier=IIR
+000754  point: comment=multi_prod_x[1][7]:0->1 hier=IIR
+000751  point: comment=multi_prod_x[1][7]:1->0 hier=IIR
+000800  point: comment=multi_prod_x[1][8]:0->1 hier=IIR
+000797  point: comment=multi_prod_x[1][8]:1->0 hier=IIR
+000808  point: comment=multi_prod_x[1][9]:0->1 hier=IIR
+000806  point: comment=multi_prod_x[1][9]:1->0 hier=IIR
+000213  point: comment=multi_prod_x[2][0]:0->1 hier=IIR
+000212  point: comment=multi_prod_x[2][0]:1->0 hier=IIR
+000630  point: comment=multi_prod_x[2][10]:0->1 hier=IIR
+000628  point: comment=multi_prod_x[2][10]:1->0 hier=IIR
+000611  point: comment=multi_prod_x[2][11]:0->1 hier=IIR
+000609  point: comment=multi_prod_x[2][11]:1->0 hier=IIR
+000623  point: comment=multi_prod_x[2][12]:0->1 hier=IIR
+000621  point: comment=multi_prod_x[2][12]:1->0 hier=IIR
+000621  point: comment=multi_prod_x[2][13]:0->1 hier=IIR
+000619  point: comment=multi_prod_x[2][13]:1->0 hier=IIR
+000619  point: comment=multi_prod_x[2][14]:0->1 hier=IIR
+000616  point: comment=multi_prod_x[2][14]:1->0 hier=IIR
+000645  point: comment=multi_prod_x[2][15]:0->1 hier=IIR
+000643  point: comment=multi_prod_x[2][15]:1->0 hier=IIR
+000621  point: comment=multi_prod_x[2][16]:0->1 hier=IIR
+000619  point: comment=multi_prod_x[2][16]:1->0 hier=IIR
+000635  point: comment=multi_prod_x[2][17]:0->1 hier=IIR
+000635  point: comment=multi_prod_x[2][17]:1->0 hier=IIR
+000624  point: comment=multi_prod_x[2][18]:0->1 hier=IIR
+000622  point: comment=multi_prod_x[2][18]:1->0 hier=IIR
+000614  point: comment=multi_prod_x[2][19]:0->1 hier=IIR
+000613  point: comment=multi_prod_x[2][19]:1->0 hier=IIR
+000457  point: comment=multi_prod_x[2][1]:0->1 hier=IIR
+000454  point: comment=multi_prod_x[2][1]:1->0 hier=IIR
+000618  point: comment=multi_prod_x[2][20]:0->1 hier=IIR
+000615  point: comment=multi_prod_x[2][20]:1->0 hier=IIR
+000610  point: comment=multi_prod_x[2][21]:0->1 hier=IIR
+000609  point: comment=multi_prod_x[2][21]:1->0 hier=IIR
+000625  point: comment=multi_prod_x[2][22]:0->1 hier=IIR
+000624  point: comment=multi_prod_x[2][22]:1->0 hier=IIR
+000605  point: comment=multi_prod_x[2][23]:0->1 hier=IIR
+000602  point: comment=multi_prod_x[2][23]:1->0 hier=IIR
+000625  point: comment=multi_prod_x[2][24]:0->1 hier=IIR
+000624  point: comment=multi_prod_x[2][24]:1->0 hier=IIR
+000603  point: comment=multi_prod_x[2][25]:0->1 hier=IIR
+000602  point: comment=multi_prod_x[2][25]:1->0 hier=IIR
+000619  point: comment=multi_prod_x[2][26]:0->1 hier=IIR
+000617  point: comment=multi_prod_x[2][26]:1->0 hier=IIR
+000633  point: comment=multi_prod_x[2][27]:0->1 hier=IIR
+000632  point: comment=multi_prod_x[2][27]:1->0 hier=IIR
+000634  point: comment=multi_prod_x[2][28]:0->1 hier=IIR
+000631  point: comment=multi_prod_x[2][28]:1->0 hier=IIR
+000627  point: comment=multi_prod_x[2][29]:0->1 hier=IIR
+000627  point: comment=multi_prod_x[2][29]:1->0 hier=IIR
+000571  point: comment=multi_prod_x[2][2]:0->1 hier=IIR
+000570  point: comment=multi_prod_x[2][2]:1->0 hier=IIR
+000622  point: comment=multi_prod_x[2][30]:0->1 hier=IIR
+000619  point: comment=multi_prod_x[2][30]:1->0 hier=IIR
+000620  point: comment=multi_prod_x[2][31]:0->1 hier=IIR
+000618  point: comment=multi_prod_x[2][31]:1->0 hier=IIR
+000639  point: comment=multi_prod_x[2][32]:0->1 hier=IIR
+000636  point: comment=multi_prod_x[2][32]:1->0 hier=IIR
+000596  point: comment=multi_prod_x[2][33]:0->1 hier=IIR
+000593  point: comment=multi_prod_x[2][33]:1->0 hier=IIR
+000637  point: comment=multi_prod_x[2][34]:0->1 hier=IIR
+000634  point: comment=multi_prod_x[2][34]:1->0 hier=IIR
+000639  point: comment=multi_prod_x[2][35]:0->1 hier=IIR
+000635  point: comment=multi_prod_x[2][35]:1->0 hier=IIR
+000624  point: comment=multi_prod_x[2][36]:0->1 hier=IIR
+000623  point: comment=multi_prod_x[2][36]:1->0 hier=IIR
+000625  point: comment=multi_prod_x[2][37]:0->1 hier=IIR
+000622  point: comment=multi_prod_x[2][37]:1->0 hier=IIR
+000633  point: comment=multi_prod_x[2][38]:0->1 hier=IIR
+000632  point: comment=multi_prod_x[2][38]:1->0 hier=IIR
+000617  point: comment=multi_prod_x[2][39]:0->1 hier=IIR
+000614  point: comment=multi_prod_x[2][39]:1->0 hier=IIR
+000592  point: comment=multi_prod_x[2][3]:0->1 hier=IIR
+000591  point: comment=multi_prod_x[2][3]:1->0 hier=IIR
+000615  point: comment=multi_prod_x[2][40]:0->1 hier=IIR
+000612  point: comment=multi_prod_x[2][40]:1->0 hier=IIR
+000633  point: comment=multi_prod_x[2][41]:0->1 hier=IIR
+000631  point: comment=multi_prod_x[2][41]:1->0 hier=IIR
+000608  point: comment=multi_prod_x[2][42]:0->1 hier=IIR
+000605  point: comment=multi_prod_x[2][42]:1->0 hier=IIR
+000623  point: comment=multi_prod_x[2][43]:0->1 hier=IIR
+000621  point: comment=multi_prod_x[2][43]:1->0 hier=IIR
+000603  point: comment=multi_prod_x[2][44]:0->1 hier=IIR
+000599  point: comment=multi_prod_x[2][44]:1->0 hier=IIR
+000638  point: comment=multi_prod_x[2][45]:0->1 hier=IIR
+000637  point: comment=multi_prod_x[2][45]:1->0 hier=IIR
+000642  point: comment=multi_prod_x[2][46]:0->1 hier=IIR
+000640  point: comment=multi_prod_x[2][46]:1->0 hier=IIR
+000608  point: comment=multi_prod_x[2][47]:0->1 hier=IIR
+000608  point: comment=multi_prod_x[2][47]:1->0 hier=IIR
+000665  point: comment=multi_prod_x[2][48]:0->1 hier=IIR
+000663  point: comment=multi_prod_x[2][48]:1->0 hier=IIR
+000619  point: comment=multi_prod_x[2][49]:0->1 hier=IIR
+000615  point: comment=multi_prod_x[2][49]:1->0 hier=IIR
+000583  point: comment=multi_prod_x[2][4]:0->1 hier=IIR
+000582  point: comment=multi_prod_x[2][4]:1->0 hier=IIR
+000634  point: comment=multi_prod_x[2][50]:0->1 hier=IIR
+000632  point: comment=multi_prod_x[2][50]:1->0 hier=IIR
+000611  point: comment=multi_prod_x[2][51]:0->1 hier=IIR
+000609  point: comment=multi_prod_x[2][51]:1->0 hier=IIR
+000619  point: comment=multi_prod_x[2][52]:0->1 hier=IIR
+000618  point: comment=multi_prod_x[2][52]:1->0 hier=IIR
+000647  point: comment=multi_prod_x[2][53]:0->1 hier=IIR
+000645  point: comment=multi_prod_x[2][53]:1->0 hier=IIR
+000625  point: comment=multi_prod_x[2][54]:0->1 hier=IIR
+000622  point: comment=multi_prod_x[2][54]:1->0 hier=IIR
+000625  point: comment=multi_prod_x[2][55]:0->1 hier=IIR
+000622  point: comment=multi_prod_x[2][55]:1->0 hier=IIR
+000625  point: comment=multi_prod_x[2][56]:0->1 hier=IIR
+000622  point: comment=multi_prod_x[2][56]:1->0 hier=IIR
+000625  point: comment=multi_prod_x[2][57]:0->1 hier=IIR
+000622  point: comment=multi_prod_x[2][57]:1->0 hier=IIR
+000595  point: comment=multi_prod_x[2][5]:0->1 hier=IIR
+000594  point: comment=multi_prod_x[2][5]:1->0 hier=IIR
+000619  point: comment=multi_prod_x[2][6]:0->1 hier=IIR
+000617  point: comment=multi_prod_x[2][6]:1->0 hier=IIR
+000608  point: comment=multi_prod_x[2][7]:0->1 hier=IIR
+000605  point: comment=multi_prod_x[2][7]:1->0 hier=IIR
+000603  point: comment=multi_prod_x[2][8]:0->1 hier=IIR
+000601  point: comment=multi_prod_x[2][8]:1->0 hier=IIR
+000609  point: comment=multi_prod_x[2][9]:0->1 hier=IIR
+000608  point: comment=multi_prod_x[2][9]:1->0 hier=IIR
 000827    logic signed [MULTIPLY_WIDTH:0] multi_prod_y [0:OUTPUT_TAPS-1];
+000636  point: comment=multi_prod_y[0][0]:0->1 hier=IIR
+000632  point: comment=multi_prod_y[0][0]:1->0 hier=IIR
+000803  point: comment=multi_prod_y[0][10]:0->1 hier=IIR
+000801  point: comment=multi_prod_y[0][10]:1->0 hier=IIR
+000791  point: comment=multi_prod_y[0][11]:0->1 hier=IIR
+000789  point: comment=multi_prod_y[0][11]:1->0 hier=IIR
+000787  point: comment=multi_prod_y[0][12]:0->1 hier=IIR
+000784  point: comment=multi_prod_y[0][12]:1->0 hier=IIR
+000757  point: comment=multi_prod_y[0][13]:0->1 hier=IIR
+000754  point: comment=multi_prod_y[0][13]:1->0 hier=IIR
+000797  point: comment=multi_prod_y[0][14]:0->1 hier=IIR
+000793  point: comment=multi_prod_y[0][14]:1->0 hier=IIR
+000784  point: comment=multi_prod_y[0][15]:0->1 hier=IIR
+000781  point: comment=multi_prod_y[0][15]:1->0 hier=IIR
+000761  point: comment=multi_prod_y[0][16]:0->1 hier=IIR
+000756  point: comment=multi_prod_y[0][16]:1->0 hier=IIR
+000812  point: comment=multi_prod_y[0][17]:0->1 hier=IIR
+000810  point: comment=multi_prod_y[0][17]:1->0 hier=IIR
+000775  point: comment=multi_prod_y[0][18]:0->1 hier=IIR
+000771  point: comment=multi_prod_y[0][18]:1->0 hier=IIR
+000779  point: comment=multi_prod_y[0][19]:0->1 hier=IIR
+000776  point: comment=multi_prod_y[0][19]:1->0 hier=IIR
+000627  point: comment=multi_prod_y[0][1]:0->1 hier=IIR
+000625  point: comment=multi_prod_y[0][1]:1->0 hier=IIR
+000782  point: comment=multi_prod_y[0][20]:0->1 hier=IIR
+000779  point: comment=multi_prod_y[0][20]:1->0 hier=IIR
+000754  point: comment=multi_prod_y[0][21]:0->1 hier=IIR
+000751  point: comment=multi_prod_y[0][21]:1->0 hier=IIR
+000777  point: comment=multi_prod_y[0][22]:0->1 hier=IIR
+000775  point: comment=multi_prod_y[0][22]:1->0 hier=IIR
+000788  point: comment=multi_prod_y[0][23]:0->1 hier=IIR
+000784  point: comment=multi_prod_y[0][23]:1->0 hier=IIR
+000762  point: comment=multi_prod_y[0][24]:0->1 hier=IIR
+000761  point: comment=multi_prod_y[0][24]:1->0 hier=IIR
+000770  point: comment=multi_prod_y[0][25]:0->1 hier=IIR
+000766  point: comment=multi_prod_y[0][25]:1->0 hier=IIR
+000787  point: comment=multi_prod_y[0][26]:0->1 hier=IIR
+000783  point: comment=multi_prod_y[0][26]:1->0 hier=IIR
+000798  point: comment=multi_prod_y[0][27]:0->1 hier=IIR
+000798  point: comment=multi_prod_y[0][27]:1->0 hier=IIR
+000790  point: comment=multi_prod_y[0][28]:0->1 hier=IIR
+000787  point: comment=multi_prod_y[0][28]:1->0 hier=IIR
+000783  point: comment=multi_prod_y[0][29]:0->1 hier=IIR
+000780  point: comment=multi_prod_y[0][29]:1->0 hier=IIR
+000732  point: comment=multi_prod_y[0][2]:0->1 hier=IIR
+000729  point: comment=multi_prod_y[0][2]:1->0 hier=IIR
+000793  point: comment=multi_prod_y[0][30]:0->1 hier=IIR
+000790  point: comment=multi_prod_y[0][30]:1->0 hier=IIR
+000799  point: comment=multi_prod_y[0][31]:0->1 hier=IIR
+000796  point: comment=multi_prod_y[0][31]:1->0 hier=IIR
+000782  point: comment=multi_prod_y[0][32]:0->1 hier=IIR
+000780  point: comment=multi_prod_y[0][32]:1->0 hier=IIR
+000811  point: comment=multi_prod_y[0][33]:0->1 hier=IIR
+000808  point: comment=multi_prod_y[0][33]:1->0 hier=IIR
+000801  point: comment=multi_prod_y[0][34]:0->1 hier=IIR
+000798  point: comment=multi_prod_y[0][34]:1->0 hier=IIR
+000772  point: comment=multi_prod_y[0][35]:0->1 hier=IIR
+000768  point: comment=multi_prod_y[0][35]:1->0 hier=IIR
+000786  point: comment=multi_prod_y[0][36]:0->1 hier=IIR
+000783  point: comment=multi_prod_y[0][36]:1->0 hier=IIR
+000740  point: comment=multi_prod_y[0][37]:0->1 hier=IIR
+000737  point: comment=multi_prod_y[0][37]:1->0 hier=IIR
+000774  point: comment=multi_prod_y[0][38]:0->1 hier=IIR
+000773  point: comment=multi_prod_y[0][38]:1->0 hier=IIR
+000764  point: comment=multi_prod_y[0][39]:0->1 hier=IIR
+000762  point: comment=multi_prod_y[0][39]:1->0 hier=IIR
+000779  point: comment=multi_prod_y[0][3]:0->1 hier=IIR
+000777  point: comment=multi_prod_y[0][3]:1->0 hier=IIR
+000758  point: comment=multi_prod_y[0][40]:0->1 hier=IIR
+000755  point: comment=multi_prod_y[0][40]:1->0 hier=IIR
+000791  point: comment=multi_prod_y[0][41]:0->1 hier=IIR
+000790  point: comment=multi_prod_y[0][41]:1->0 hier=IIR
+000801  point: comment=multi_prod_y[0][42]:0->1 hier=IIR
+000798  point: comment=multi_prod_y[0][42]:1->0 hier=IIR
+000789  point: comment=multi_prod_y[0][43]:0->1 hier=IIR
+000785  point: comment=multi_prod_y[0][43]:1->0 hier=IIR
+000797  point: comment=multi_prod_y[0][44]:0->1 hier=IIR
+000796  point: comment=multi_prod_y[0][44]:1->0 hier=IIR
+000827  point: comment=multi_prod_y[0][45]:0->1 hier=IIR
+000825  point: comment=multi_prod_y[0][45]:1->0 hier=IIR
+000791  point: comment=multi_prod_y[0][46]:0->1 hier=IIR
+000789  point: comment=multi_prod_y[0][46]:1->0 hier=IIR
+000786  point: comment=multi_prod_y[0][47]:0->1 hier=IIR
+000783  point: comment=multi_prod_y[0][47]:1->0 hier=IIR
+000796  point: comment=multi_prod_y[0][48]:0->1 hier=IIR
+000793  point: comment=multi_prod_y[0][48]:1->0 hier=IIR
+000797  point: comment=multi_prod_y[0][49]:0->1 hier=IIR
+000795  point: comment=multi_prod_y[0][49]:1->0 hier=IIR
+000810  point: comment=multi_prod_y[0][4]:0->1 hier=IIR
+000808  point: comment=multi_prod_y[0][4]:1->0 hier=IIR
+000780  point: comment=multi_prod_y[0][50]:0->1 hier=IIR
+000778  point: comment=multi_prod_y[0][50]:1->0 hier=IIR
+000783  point: comment=multi_prod_y[0][51]:0->1 hier=IIR
+000779  point: comment=multi_prod_y[0][51]:1->0 hier=IIR
+000782  point: comment=multi_prod_y[0][52]:0->1 hier=IIR
+000781  point: comment=multi_prod_y[0][52]:1->0 hier=IIR
+000808  point: comment=multi_prod_y[0][53]:0->1 hier=IIR
+000803  point: comment=multi_prod_y[0][53]:1->0 hier=IIR
+000791  point: comment=multi_prod_y[0][54]:0->1 hier=IIR
+000789  point: comment=multi_prod_y[0][54]:1->0 hier=IIR
+000744  point: comment=multi_prod_y[0][55]:0->1 hier=IIR
+000743  point: comment=multi_prod_y[0][55]:1->0 hier=IIR
+000744  point: comment=multi_prod_y[0][56]:0->1 hier=IIR
+000743  point: comment=multi_prod_y[0][56]:1->0 hier=IIR
+000744  point: comment=multi_prod_y[0][57]:0->1 hier=IIR
+000743  point: comment=multi_prod_y[0][57]:1->0 hier=IIR
+000769  point: comment=multi_prod_y[0][5]:0->1 hier=IIR
+000766  point: comment=multi_prod_y[0][5]:1->0 hier=IIR
+000787  point: comment=multi_prod_y[0][6]:0->1 hier=IIR
+000782  point: comment=multi_prod_y[0][6]:1->0 hier=IIR
+000775  point: comment=multi_prod_y[0][7]:0->1 hier=IIR
+000771  point: comment=multi_prod_y[0][7]:1->0 hier=IIR
+000753  point: comment=multi_prod_y[0][8]:0->1 hier=IIR
+000750  point: comment=multi_prod_y[0][8]:1->0 hier=IIR
+000801  point: comment=multi_prod_y[0][9]:0->1 hier=IIR
+000798  point: comment=multi_prod_y[0][9]:1->0 hier=IIR
+000273  point: comment=multi_prod_y[1][0]:0->1 hier=IIR
+000273  point: comment=multi_prod_y[1][0]:1->0 hier=IIR
+000649  point: comment=multi_prod_y[1][10]:0->1 hier=IIR
+000647  point: comment=multi_prod_y[1][10]:1->0 hier=IIR
+000611  point: comment=multi_prod_y[1][11]:0->1 hier=IIR
+000609  point: comment=multi_prod_y[1][11]:1->0 hier=IIR
+000616  point: comment=multi_prod_y[1][12]:0->1 hier=IIR
+000615  point: comment=multi_prod_y[1][12]:1->0 hier=IIR
+000612  point: comment=multi_prod_y[1][13]:0->1 hier=IIR
+000612  point: comment=multi_prod_y[1][13]:1->0 hier=IIR
+000592  point: comment=multi_prod_y[1][14]:0->1 hier=IIR
+000590  point: comment=multi_prod_y[1][14]:1->0 hier=IIR
+000637  point: comment=multi_prod_y[1][15]:0->1 hier=IIR
+000635  point: comment=multi_prod_y[1][15]:1->0 hier=IIR
+000616  point: comment=multi_prod_y[1][16]:0->1 hier=IIR
+000615  point: comment=multi_prod_y[1][16]:1->0 hier=IIR
+000634  point: comment=multi_prod_y[1][17]:0->1 hier=IIR
+000633  point: comment=multi_prod_y[1][17]:1->0 hier=IIR
+000630  point: comment=multi_prod_y[1][18]:0->1 hier=IIR
+000628  point: comment=multi_prod_y[1][18]:1->0 hier=IIR
+000613  point: comment=multi_prod_y[1][19]:0->1 hier=IIR
+000611  point: comment=multi_prod_y[1][19]:1->0 hier=IIR
+000606  point: comment=multi_prod_y[1][1]:0->1 hier=IIR
+000604  point: comment=multi_prod_y[1][1]:1->0 hier=IIR
+000613  point: comment=multi_prod_y[1][20]:0->1 hier=IIR
+000610  point: comment=multi_prod_y[1][20]:1->0 hier=IIR
+000604  point: comment=multi_prod_y[1][21]:0->1 hier=IIR
+000603  point: comment=multi_prod_y[1][21]:1->0 hier=IIR
+000628  point: comment=multi_prod_y[1][22]:0->1 hier=IIR
+000626  point: comment=multi_prod_y[1][22]:1->0 hier=IIR
+000606  point: comment=multi_prod_y[1][23]:0->1 hier=IIR
+000605  point: comment=multi_prod_y[1][23]:1->0 hier=IIR
+000589  point: comment=multi_prod_y[1][24]:0->1 hier=IIR
+000587  point: comment=multi_prod_y[1][24]:1->0 hier=IIR
+000598  point: comment=multi_prod_y[1][25]:0->1 hier=IIR
+000595  point: comment=multi_prod_y[1][25]:1->0 hier=IIR
+000617  point: comment=multi_prod_y[1][26]:0->1 hier=IIR
+000617  point: comment=multi_prod_y[1][26]:1->0 hier=IIR
+000591  point: comment=multi_prod_y[1][27]:0->1 hier=IIR
+000589  point: comment=multi_prod_y[1][27]:1->0 hier=IIR
+000625  point: comment=multi_prod_y[1][28]:0->1 hier=IIR
+000624  point: comment=multi_prod_y[1][28]:1->0 hier=IIR
+000597  point: comment=multi_prod_y[1][29]:0->1 hier=IIR
+000595  point: comment=multi_prod_y[1][29]:1->0 hier=IIR
+000609  point: comment=multi_prod_y[1][2]:0->1 hier=IIR
+000607  point: comment=multi_prod_y[1][2]:1->0 hier=IIR
+000617  point: comment=multi_prod_y[1][30]:0->1 hier=IIR
+000615  point: comment=multi_prod_y[1][30]:1->0 hier=IIR
+000633  point: comment=multi_prod_y[1][31]:0->1 hier=IIR
+000632  point: comment=multi_prod_y[1][31]:1->0 hier=IIR
+000614  point: comment=multi_prod_y[1][32]:0->1 hier=IIR
+000612  point: comment=multi_prod_y[1][32]:1->0 hier=IIR
+000610  point: comment=multi_prod_y[1][33]:0->1 hier=IIR
+000608  point: comment=multi_prod_y[1][33]:1->0 hier=IIR
+000612  point: comment=multi_prod_y[1][34]:0->1 hier=IIR
+000610  point: comment=multi_prod_y[1][34]:1->0 hier=IIR
+000625  point: comment=multi_prod_y[1][35]:0->1 hier=IIR
+000623  point: comment=multi_prod_y[1][35]:1->0 hier=IIR
+000628  point: comment=multi_prod_y[1][36]:0->1 hier=IIR
+000626  point: comment=multi_prod_y[1][36]:1->0 hier=IIR
+000632  point: comment=multi_prod_y[1][37]:0->1 hier=IIR
+000629  point: comment=multi_prod_y[1][37]:1->0 hier=IIR
+000609  point: comment=multi_prod_y[1][38]:0->1 hier=IIR
+000607  point: comment=multi_prod_y[1][38]:1->0 hier=IIR
+000603  point: comment=multi_prod_y[1][39]:0->1 hier=IIR
+000600  point: comment=multi_prod_y[1][39]:1->0 hier=IIR
+000607  point: comment=multi_prod_y[1][3]:0->1 hier=IIR
+000606  point: comment=multi_prod_y[1][3]:1->0 hier=IIR
+000632  point: comment=multi_prod_y[1][40]:0->1 hier=IIR
+000629  point: comment=multi_prod_y[1][40]:1->0 hier=IIR
+000621  point: comment=multi_prod_y[1][41]:0->1 hier=IIR
+000620  point: comment=multi_prod_y[1][41]:1->0 hier=IIR
+000615  point: comment=multi_prod_y[1][42]:0->1 hier=IIR
+000612  point: comment=multi_prod_y[1][42]:1->0 hier=IIR
+000621  point: comment=multi_prod_y[1][43]:0->1 hier=IIR
+000619  point: comment=multi_prod_y[1][43]:1->0 hier=IIR
+000608  point: comment=multi_prod_y[1][44]:0->1 hier=IIR
+000605  point: comment=multi_prod_y[1][44]:1->0 hier=IIR
+000635  point: comment=multi_prod_y[1][45]:0->1 hier=IIR
+000633  point: comment=multi_prod_y[1][45]:1->0 hier=IIR
+000623  point: comment=multi_prod_y[1][46]:0->1 hier=IIR
+000621  point: comment=multi_prod_y[1][46]:1->0 hier=IIR
+000600  point: comment=multi_prod_y[1][47]:0->1 hier=IIR
+000598  point: comment=multi_prod_y[1][47]:1->0 hier=IIR
+000632  point: comment=multi_prod_y[1][48]:0->1 hier=IIR
+000631  point: comment=multi_prod_y[1][48]:1->0 hier=IIR
+000614  point: comment=multi_prod_y[1][49]:0->1 hier=IIR
+000611  point: comment=multi_prod_y[1][49]:1->0 hier=IIR
+000610  point: comment=multi_prod_y[1][4]:0->1 hier=IIR
+000608  point: comment=multi_prod_y[1][4]:1->0 hier=IIR
+000616  point: comment=multi_prod_y[1][50]:0->1 hier=IIR
+000615  point: comment=multi_prod_y[1][50]:1->0 hier=IIR
+000596  point: comment=multi_prod_y[1][51]:0->1 hier=IIR
+000593  point: comment=multi_prod_y[1][51]:1->0 hier=IIR
+000612  point: comment=multi_prod_y[1][52]:0->1 hier=IIR
+000611  point: comment=multi_prod_y[1][52]:1->0 hier=IIR
+000639  point: comment=multi_prod_y[1][53]:0->1 hier=IIR
+000637  point: comment=multi_prod_y[1][53]:1->0 hier=IIR
+000603  point: comment=multi_prod_y[1][54]:0->1 hier=IIR
+000600  point: comment=multi_prod_y[1][54]:1->0 hier=IIR
+000603  point: comment=multi_prod_y[1][55]:0->1 hier=IIR
+000600  point: comment=multi_prod_y[1][55]:1->0 hier=IIR
+000603  point: comment=multi_prod_y[1][56]:0->1 hier=IIR
+000600  point: comment=multi_prod_y[1][56]:1->0 hier=IIR
+000603  point: comment=multi_prod_y[1][57]:0->1 hier=IIR
+000600  point: comment=multi_prod_y[1][57]:1->0 hier=IIR
+000616  point: comment=multi_prod_y[1][5]:0->1 hier=IIR
+000616  point: comment=multi_prod_y[1][5]:1->0 hier=IIR
+000600  point: comment=multi_prod_y[1][6]:0->1 hier=IIR
+000597  point: comment=multi_prod_y[1][6]:1->0 hier=IIR
+000630  point: comment=multi_prod_y[1][7]:0->1 hier=IIR
+000628  point: comment=multi_prod_y[1][7]:1->0 hier=IIR
+000588  point: comment=multi_prod_y[1][8]:0->1 hier=IIR
+000587  point: comment=multi_prod_y[1][8]:1->0 hier=IIR
+000620  point: comment=multi_prod_y[1][9]:0->1 hier=IIR
+000619  point: comment=multi_prod_y[1][9]:1->0 hier=IIR
        
 001387    logic signed [I_ACC_WIDTH:0]    acc_x_reg ;
+000938  point: comment=acc_x_reg[0]:0->1 hier=IIR
+000936  point: comment=acc_x_reg[0]:1->0 hier=IIR
+001031  point: comment=acc_x_reg[10]:0->1 hier=IIR
+001029  point: comment=acc_x_reg[10]:1->0 hier=IIR
+001024  point: comment=acc_x_reg[11]:0->1 hier=IIR
+001023  point: comment=acc_x_reg[11]:1->0 hier=IIR
+001010  point: comment=acc_x_reg[12]:0->1 hier=IIR
+001007  point: comment=acc_x_reg[12]:1->0 hier=IIR
+001013  point: comment=acc_x_reg[13]:0->1 hier=IIR
+001012  point: comment=acc_x_reg[13]:1->0 hier=IIR
+001024  point: comment=acc_x_reg[14]:0->1 hier=IIR
+001023  point: comment=acc_x_reg[14]:1->0 hier=IIR
+001002  point: comment=acc_x_reg[15]:0->1 hier=IIR
+001000  point: comment=acc_x_reg[15]:1->0 hier=IIR
+001006  point: comment=acc_x_reg[16]:0->1 hier=IIR
+001005  point: comment=acc_x_reg[16]:1->0 hier=IIR
+001004  point: comment=acc_x_reg[17]:0->1 hier=IIR
+001002  point: comment=acc_x_reg[17]:1->0 hier=IIR
+001019  point: comment=acc_x_reg[18]:0->1 hier=IIR
+001015  point: comment=acc_x_reg[18]:1->0 hier=IIR
+001028  point: comment=acc_x_reg[19]:0->1 hier=IIR
+001026  point: comment=acc_x_reg[19]:1->0 hier=IIR
+000957  point: comment=acc_x_reg[1]:0->1 hier=IIR
+000955  point: comment=acc_x_reg[1]:1->0 hier=IIR
+001003  point: comment=acc_x_reg[20]:0->1 hier=IIR
+001000  point: comment=acc_x_reg[20]:1->0 hier=IIR
+000990  point: comment=acc_x_reg[21]:0->1 hier=IIR
+000988  point: comment=acc_x_reg[21]:1->0 hier=IIR
+001019  point: comment=acc_x_reg[22]:0->1 hier=IIR
+001016  point: comment=acc_x_reg[22]:1->0 hier=IIR
+001007  point: comment=acc_x_reg[23]:0->1 hier=IIR
+001003  point: comment=acc_x_reg[23]:1->0 hier=IIR
+001044  point: comment=acc_x_reg[24]:0->1 hier=IIR
+001041  point: comment=acc_x_reg[24]:1->0 hier=IIR
+001017  point: comment=acc_x_reg[25]:0->1 hier=IIR
+001012  point: comment=acc_x_reg[25]:1->0 hier=IIR
+001027  point: comment=acc_x_reg[26]:0->1 hier=IIR
+001024  point: comment=acc_x_reg[26]:1->0 hier=IIR
+001022  point: comment=acc_x_reg[27]:0->1 hier=IIR
+001018  point: comment=acc_x_reg[27]:1->0 hier=IIR
+001034  point: comment=acc_x_reg[28]:0->1 hier=IIR
+001033  point: comment=acc_x_reg[28]:1->0 hier=IIR
+001026  point: comment=acc_x_reg[29]:0->1 hier=IIR
+001024  point: comment=acc_x_reg[29]:1->0 hier=IIR
+001014  point: comment=acc_x_reg[2]:0->1 hier=IIR
+001012  point: comment=acc_x_reg[2]:1->0 hier=IIR
+001013  point: comment=acc_x_reg[30]:0->1 hier=IIR
+001011  point: comment=acc_x_reg[30]:1->0 hier=IIR
+001011  point: comment=acc_x_reg[31]:0->1 hier=IIR
+001009  point: comment=acc_x_reg[31]:1->0 hier=IIR
+001039  point: comment=acc_x_reg[32]:0->1 hier=IIR
+001034  point: comment=acc_x_reg[32]:1->0 hier=IIR
+001048  point: comment=acc_x_reg[33]:0->1 hier=IIR
+001042  point: comment=acc_x_reg[33]:1->0 hier=IIR
+001024  point: comment=acc_x_reg[34]:0->1 hier=IIR
+001021  point: comment=acc_x_reg[34]:1->0 hier=IIR
+000993  point: comment=acc_x_reg[35]:0->1 hier=IIR
+000988  point: comment=acc_x_reg[35]:1->0 hier=IIR
+001010  point: comment=acc_x_reg[36]:0->1 hier=IIR
+001005  point: comment=acc_x_reg[36]:1->0 hier=IIR
+001032  point: comment=acc_x_reg[37]:0->1 hier=IIR
+001030  point: comment=acc_x_reg[37]:1->0 hier=IIR
+001024  point: comment=acc_x_reg[38]:0->1 hier=IIR
+001021  point: comment=acc_x_reg[38]:1->0 hier=IIR
+001024  point: comment=acc_x_reg[39]:0->1 hier=IIR
+001023  point: comment=acc_x_reg[39]:1->0 hier=IIR
+001039  point: comment=acc_x_reg[3]:0->1 hier=IIR
+001035  point: comment=acc_x_reg[3]:1->0 hier=IIR
+001017  point: comment=acc_x_reg[40]:0->1 hier=IIR
+001015  point: comment=acc_x_reg[40]:1->0 hier=IIR
+001012  point: comment=acc_x_reg[41]:0->1 hier=IIR
+001008  point: comment=acc_x_reg[41]:1->0 hier=IIR
+001031  point: comment=acc_x_reg[42]:0->1 hier=IIR
+001030  point: comment=acc_x_reg[42]:1->0 hier=IIR
+001039  point: comment=acc_x_reg[43]:0->1 hier=IIR
+001035  point: comment=acc_x_reg[43]:1->0 hier=IIR
+001062  point: comment=acc_x_reg[44]:0->1 hier=IIR
+001058  point: comment=acc_x_reg[44]:1->0 hier=IIR
+001042  point: comment=acc_x_reg[45]:0->1 hier=IIR
+001040  point: comment=acc_x_reg[45]:1->0 hier=IIR
+001046  point: comment=acc_x_reg[46]:0->1 hier=IIR
+001042  point: comment=acc_x_reg[46]:1->0 hier=IIR
+001034  point: comment=acc_x_reg[47]:0->1 hier=IIR
+001031  point: comment=acc_x_reg[47]:1->0 hier=IIR
+001013  point: comment=acc_x_reg[48]:0->1 hier=IIR
+001010  point: comment=acc_x_reg[48]:1->0 hier=IIR
+001035  point: comment=acc_x_reg[49]:0->1 hier=IIR
+001032  point: comment=acc_x_reg[49]:1->0 hier=IIR
+001030  point: comment=acc_x_reg[4]:0->1 hier=IIR
+001027  point: comment=acc_x_reg[4]:1->0 hier=IIR
+001050  point: comment=acc_x_reg[50]:0->1 hier=IIR
+001045  point: comment=acc_x_reg[50]:1->0 hier=IIR
+001009  point: comment=acc_x_reg[51]:0->1 hier=IIR
+001006  point: comment=acc_x_reg[51]:1->0 hier=IIR
+001053  point: comment=acc_x_reg[52]:0->1 hier=IIR
+001049  point: comment=acc_x_reg[52]:1->0 hier=IIR
+001024  point: comment=acc_x_reg[53]:0->1 hier=IIR
+001021  point: comment=acc_x_reg[53]:1->0 hier=IIR
+001067  point: comment=acc_x_reg[54]:0->1 hier=IIR
+001065  point: comment=acc_x_reg[54]:1->0 hier=IIR
+001180  point: comment=acc_x_reg[55]:0->1 hier=IIR
+001178  point: comment=acc_x_reg[55]:1->0 hier=IIR
+001387  point: comment=acc_x_reg[56]:0->1 hier=IIR
+001385  point: comment=acc_x_reg[56]:1->0 hier=IIR
+001387  point: comment=acc_x_reg[57]:0->1 hier=IIR
+001385  point: comment=acc_x_reg[57]:1->0 hier=IIR
+001387  point: comment=acc_x_reg[58]:0->1 hier=IIR
+001385  point: comment=acc_x_reg[58]:1->0 hier=IIR
+001387  point: comment=acc_x_reg[59]:0->1 hier=IIR
+001385  point: comment=acc_x_reg[59]:1->0 hier=IIR
+001024  point: comment=acc_x_reg[5]:0->1 hier=IIR
+001023  point: comment=acc_x_reg[5]:1->0 hier=IIR
+001008  point: comment=acc_x_reg[6]:0->1 hier=IIR
+001007  point: comment=acc_x_reg[6]:1->0 hier=IIR
+000998  point: comment=acc_x_reg[7]:0->1 hier=IIR
+000995  point: comment=acc_x_reg[7]:1->0 hier=IIR
+001042  point: comment=acc_x_reg[8]:0->1 hier=IIR
+001038  point: comment=acc_x_reg[8]:1->0 hier=IIR
+001001  point: comment=acc_x_reg[9]:0->1 hier=IIR
+000998  point: comment=acc_x_reg[9]:1->0 hier=IIR
 001466    logic signed [I_ACC_WIDTH:0]    acc_x_comb ;
+000988  point: comment=acc_x_comb[0]:0->1 hier=IIR
+000986  point: comment=acc_x_comb[0]:1->0 hier=IIR
+001100  point: comment=acc_x_comb[10]:0->1 hier=IIR
+001098  point: comment=acc_x_comb[10]:1->0 hier=IIR
+001090  point: comment=acc_x_comb[11]:0->1 hier=IIR
+001089  point: comment=acc_x_comb[11]:1->0 hier=IIR
+001071  point: comment=acc_x_comb[12]:0->1 hier=IIR
+001068  point: comment=acc_x_comb[12]:1->0 hier=IIR
+001070  point: comment=acc_x_comb[13]:0->1 hier=IIR
+001069  point: comment=acc_x_comb[13]:1->0 hier=IIR
+001085  point: comment=acc_x_comb[14]:0->1 hier=IIR
+001084  point: comment=acc_x_comb[14]:1->0 hier=IIR
+001057  point: comment=acc_x_comb[15]:0->1 hier=IIR
+001055  point: comment=acc_x_comb[15]:1->0 hier=IIR
+001071  point: comment=acc_x_comb[16]:0->1 hier=IIR
+001070  point: comment=acc_x_comb[16]:1->0 hier=IIR
+001075  point: comment=acc_x_comb[17]:0->1 hier=IIR
+001073  point: comment=acc_x_comb[17]:1->0 hier=IIR
+001080  point: comment=acc_x_comb[18]:0->1 hier=IIR
+001076  point: comment=acc_x_comb[18]:1->0 hier=IIR
+001094  point: comment=acc_x_comb[19]:0->1 hier=IIR
+001092  point: comment=acc_x_comb[19]:1->0 hier=IIR
+001014  point: comment=acc_x_comb[1]:0->1 hier=IIR
+001012  point: comment=acc_x_comb[1]:1->0 hier=IIR
+001077  point: comment=acc_x_comb[20]:0->1 hier=IIR
+001074  point: comment=acc_x_comb[20]:1->0 hier=IIR
+001046  point: comment=acc_x_comb[21]:0->1 hier=IIR
+001044  point: comment=acc_x_comb[21]:1->0 hier=IIR
+001083  point: comment=acc_x_comb[22]:0->1 hier=IIR
+001080  point: comment=acc_x_comb[22]:1->0 hier=IIR
+001070  point: comment=acc_x_comb[23]:0->1 hier=IIR
+001066  point: comment=acc_x_comb[23]:1->0 hier=IIR
+001098  point: comment=acc_x_comb[24]:0->1 hier=IIR
+001095  point: comment=acc_x_comb[24]:1->0 hier=IIR
+001086  point: comment=acc_x_comb[25]:0->1 hier=IIR
+001081  point: comment=acc_x_comb[25]:1->0 hier=IIR
+001090  point: comment=acc_x_comb[26]:0->1 hier=IIR
+001087  point: comment=acc_x_comb[26]:1->0 hier=IIR
+001083  point: comment=acc_x_comb[27]:0->1 hier=IIR
+001079  point: comment=acc_x_comb[27]:1->0 hier=IIR
+001100  point: comment=acc_x_comb[28]:0->1 hier=IIR
+001099  point: comment=acc_x_comb[28]:1->0 hier=IIR
+001086  point: comment=acc_x_comb[29]:0->1 hier=IIR
+001084  point: comment=acc_x_comb[29]:1->0 hier=IIR
+001069  point: comment=acc_x_comb[2]:0->1 hier=IIR
+001067  point: comment=acc_x_comb[2]:1->0 hier=IIR
+001075  point: comment=acc_x_comb[30]:0->1 hier=IIR
+001073  point: comment=acc_x_comb[30]:1->0 hier=IIR
+001080  point: comment=acc_x_comb[31]:0->1 hier=IIR
+001078  point: comment=acc_x_comb[31]:1->0 hier=IIR
+001106  point: comment=acc_x_comb[32]:0->1 hier=IIR
+001101  point: comment=acc_x_comb[32]:1->0 hier=IIR
+001115  point: comment=acc_x_comb[33]:0->1 hier=IIR
+001109  point: comment=acc_x_comb[33]:1->0 hier=IIR
+001101  point: comment=acc_x_comb[34]:0->1 hier=IIR
+001098  point: comment=acc_x_comb[34]:1->0 hier=IIR
+001062  point: comment=acc_x_comb[35]:0->1 hier=IIR
+001057  point: comment=acc_x_comb[35]:1->0 hier=IIR
+001075  point: comment=acc_x_comb[36]:0->1 hier=IIR
+001070  point: comment=acc_x_comb[36]:1->0 hier=IIR
+001118  point: comment=acc_x_comb[37]:0->1 hier=IIR
+001116  point: comment=acc_x_comb[37]:1->0 hier=IIR
+001086  point: comment=acc_x_comb[38]:0->1 hier=IIR
+001083  point: comment=acc_x_comb[38]:1->0 hier=IIR
+001082  point: comment=acc_x_comb[39]:0->1 hier=IIR
+001081  point: comment=acc_x_comb[39]:1->0 hier=IIR
+001110  point: comment=acc_x_comb[3]:0->1 hier=IIR
+001106  point: comment=acc_x_comb[3]:1->0 hier=IIR
+001090  point: comment=acc_x_comb[40]:0->1 hier=IIR
+001088  point: comment=acc_x_comb[40]:1->0 hier=IIR
+001085  point: comment=acc_x_comb[41]:0->1 hier=IIR
+001081  point: comment=acc_x_comb[41]:1->0 hier=IIR
+001090  point: comment=acc_x_comb[42]:0->1 hier=IIR
+001089  point: comment=acc_x_comb[42]:1->0 hier=IIR
+001119  point: comment=acc_x_comb[43]:0->1 hier=IIR
+001115  point: comment=acc_x_comb[43]:1->0 hier=IIR
+001141  point: comment=acc_x_comb[44]:0->1 hier=IIR
+001137  point: comment=acc_x_comb[44]:1->0 hier=IIR
+001111  point: comment=acc_x_comb[45]:0->1 hier=IIR
+001109  point: comment=acc_x_comb[45]:1->0 hier=IIR
+001113  point: comment=acc_x_comb[46]:0->1 hier=IIR
+001109  point: comment=acc_x_comb[46]:1->0 hier=IIR
+001108  point: comment=acc_x_comb[47]:0->1 hier=IIR
+001105  point: comment=acc_x_comb[47]:1->0 hier=IIR
+001078  point: comment=acc_x_comb[48]:0->1 hier=IIR
+001075  point: comment=acc_x_comb[48]:1->0 hier=IIR
+001104  point: comment=acc_x_comb[49]:0->1 hier=IIR
+001101  point: comment=acc_x_comb[49]:1->0 hier=IIR
+001085  point: comment=acc_x_comb[4]:0->1 hier=IIR
+001082  point: comment=acc_x_comb[4]:1->0 hier=IIR
+001109  point: comment=acc_x_comb[50]:0->1 hier=IIR
+001104  point: comment=acc_x_comb[50]:1->0 hier=IIR
+001091  point: comment=acc_x_comb[51]:0->1 hier=IIR
+001088  point: comment=acc_x_comb[51]:1->0 hier=IIR
+001125  point: comment=acc_x_comb[52]:0->1 hier=IIR
+001121  point: comment=acc_x_comb[52]:1->0 hier=IIR
+001098  point: comment=acc_x_comb[53]:0->1 hier=IIR
+001095  point: comment=acc_x_comb[53]:1->0 hier=IIR
+001142  point: comment=acc_x_comb[54]:0->1 hier=IIR
+001140  point: comment=acc_x_comb[54]:1->0 hier=IIR
+001254  point: comment=acc_x_comb[55]:0->1 hier=IIR
+001252  point: comment=acc_x_comb[55]:1->0 hier=IIR
+001466  point: comment=acc_x_comb[56]:0->1 hier=IIR
+001464  point: comment=acc_x_comb[56]:1->0 hier=IIR
+001466  point: comment=acc_x_comb[57]:0->1 hier=IIR
+001464  point: comment=acc_x_comb[57]:1->0 hier=IIR
+001466  point: comment=acc_x_comb[58]:0->1 hier=IIR
+001464  point: comment=acc_x_comb[58]:1->0 hier=IIR
+001466  point: comment=acc_x_comb[59]:0->1 hier=IIR
+001464  point: comment=acc_x_comb[59]:1->0 hier=IIR
+001081  point: comment=acc_x_comb[5]:0->1 hier=IIR
+001080  point: comment=acc_x_comb[5]:1->0 hier=IIR
+001073  point: comment=acc_x_comb[6]:0->1 hier=IIR
+001072  point: comment=acc_x_comb[6]:1->0 hier=IIR
+001062  point: comment=acc_x_comb[7]:0->1 hier=IIR
+001059  point: comment=acc_x_comb[7]:1->0 hier=IIR
+001094  point: comment=acc_x_comb[8]:0->1 hier=IIR
+001090  point: comment=acc_x_comb[8]:1->0 hier=IIR
+001071  point: comment=acc_x_comb[9]:0->1 hier=IIR
+001068  point: comment=acc_x_comb[9]:1->0 hier=IIR
 000853    logic signed [O_ACC_WIDTH:0]    acc_y_reg ;
+000695  point: comment=acc_y_reg[0]:0->1 hier=IIR
+000691  point: comment=acc_y_reg[0]:1->0 hier=IIR
+000742  point: comment=acc_y_reg[10]:0->1 hier=IIR
+000741  point: comment=acc_y_reg[10]:1->0 hier=IIR
+000771  point: comment=acc_y_reg[11]:0->1 hier=IIR
+000767  point: comment=acc_y_reg[11]:1->0 hier=IIR
+000758  point: comment=acc_y_reg[12]:0->1 hier=IIR
+000753  point: comment=acc_y_reg[12]:1->0 hier=IIR
+000756  point: comment=acc_y_reg[13]:0->1 hier=IIR
+000753  point: comment=acc_y_reg[13]:1->0 hier=IIR
+000763  point: comment=acc_y_reg[14]:0->1 hier=IIR
+000761  point: comment=acc_y_reg[14]:1->0 hier=IIR
+000736  point: comment=acc_y_reg[15]:0->1 hier=IIR
+000733  point: comment=acc_y_reg[15]:1->0 hier=IIR
+000755  point: comment=acc_y_reg[16]:0->1 hier=IIR
+000751  point: comment=acc_y_reg[16]:1->0 hier=IIR
+000785  point: comment=acc_y_reg[17]:0->1 hier=IIR
+000784  point: comment=acc_y_reg[17]:1->0 hier=IIR
+000771  point: comment=acc_y_reg[18]:0->1 hier=IIR
+000769  point: comment=acc_y_reg[18]:1->0 hier=IIR
+000784  point: comment=acc_y_reg[19]:0->1 hier=IIR
+000780  point: comment=acc_y_reg[19]:1->0 hier=IIR
+000715  point: comment=acc_y_reg[1]:0->1 hier=IIR
+000713  point: comment=acc_y_reg[1]:1->0 hier=IIR
+000769  point: comment=acc_y_reg[20]:0->1 hier=IIR
+000767  point: comment=acc_y_reg[20]:1->0 hier=IIR
+000745  point: comment=acc_y_reg[21]:0->1 hier=IIR
+000742  point: comment=acc_y_reg[21]:1->0 hier=IIR
+000775  point: comment=acc_y_reg[22]:0->1 hier=IIR
+000773  point: comment=acc_y_reg[22]:1->0 hier=IIR
+000773  point: comment=acc_y_reg[23]:0->1 hier=IIR
+000768  point: comment=acc_y_reg[23]:1->0 hier=IIR
+000771  point: comment=acc_y_reg[24]:0->1 hier=IIR
+000767  point: comment=acc_y_reg[24]:1->0 hier=IIR
+000715  point: comment=acc_y_reg[25]:0->1 hier=IIR
+000712  point: comment=acc_y_reg[25]:1->0 hier=IIR
+000758  point: comment=acc_y_reg[26]:0->1 hier=IIR
+000754  point: comment=acc_y_reg[26]:1->0 hier=IIR
+000781  point: comment=acc_y_reg[27]:0->1 hier=IIR
+000780  point: comment=acc_y_reg[27]:1->0 hier=IIR
+000756  point: comment=acc_y_reg[28]:0->1 hier=IIR
+000753  point: comment=acc_y_reg[28]:1->0 hier=IIR
+000781  point: comment=acc_y_reg[29]:0->1 hier=IIR
+000777  point: comment=acc_y_reg[29]:1->0 hier=IIR
+000750  point: comment=acc_y_reg[2]:0->1 hier=IIR
+000750  point: comment=acc_y_reg[2]:1->0 hier=IIR
+000745  point: comment=acc_y_reg[30]:0->1 hier=IIR
+000743  point: comment=acc_y_reg[30]:1->0 hier=IIR
+000791  point: comment=acc_y_reg[31]:0->1 hier=IIR
+000787  point: comment=acc_y_reg[31]:1->0 hier=IIR
+000781  point: comment=acc_y_reg[32]:0->1 hier=IIR
+000778  point: comment=acc_y_reg[32]:1->0 hier=IIR
+000752  point: comment=acc_y_reg[33]:0->1 hier=IIR
+000748  point: comment=acc_y_reg[33]:1->0 hier=IIR
+000780  point: comment=acc_y_reg[34]:0->1 hier=IIR
+000778  point: comment=acc_y_reg[34]:1->0 hier=IIR
+000771  point: comment=acc_y_reg[35]:0->1 hier=IIR
+000769  point: comment=acc_y_reg[35]:1->0 hier=IIR
+000785  point: comment=acc_y_reg[36]:0->1 hier=IIR
+000781  point: comment=acc_y_reg[36]:1->0 hier=IIR
+000739  point: comment=acc_y_reg[37]:0->1 hier=IIR
+000737  point: comment=acc_y_reg[37]:1->0 hier=IIR
+000751  point: comment=acc_y_reg[38]:0->1 hier=IIR
+000749  point: comment=acc_y_reg[38]:1->0 hier=IIR
+000754  point: comment=acc_y_reg[39]:0->1 hier=IIR
+000751  point: comment=acc_y_reg[39]:1->0 hier=IIR
+000733  point: comment=acc_y_reg[3]:0->1 hier=IIR
+000731  point: comment=acc_y_reg[3]:1->0 hier=IIR
+000745  point: comment=acc_y_reg[40]:0->1 hier=IIR
+000743  point: comment=acc_y_reg[40]:1->0 hier=IIR
+000770  point: comment=acc_y_reg[41]:0->1 hier=IIR
+000767  point: comment=acc_y_reg[41]:1->0 hier=IIR
+000750  point: comment=acc_y_reg[42]:0->1 hier=IIR
+000749  point: comment=acc_y_reg[42]:1->0 hier=IIR
+000790  point: comment=acc_y_reg[43]:0->1 hier=IIR
+000787  point: comment=acc_y_reg[43]:1->0 hier=IIR
+000762  point: comment=acc_y_reg[44]:0->1 hier=IIR
+000759  point: comment=acc_y_reg[44]:1->0 hier=IIR
+000762  point: comment=acc_y_reg[45]:0->1 hier=IIR
+000760  point: comment=acc_y_reg[45]:1->0 hier=IIR
+000760  point: comment=acc_y_reg[46]:0->1 hier=IIR
+000758  point: comment=acc_y_reg[46]:1->0 hier=IIR
+000766  point: comment=acc_y_reg[47]:0->1 hier=IIR
+000763  point: comment=acc_y_reg[47]:1->0 hier=IIR
+000763  point: comment=acc_y_reg[48]:0->1 hier=IIR
+000761  point: comment=acc_y_reg[48]:1->0 hier=IIR
+000758  point: comment=acc_y_reg[49]:0->1 hier=IIR
+000755  point: comment=acc_y_reg[49]:1->0 hier=IIR
+000785  point: comment=acc_y_reg[4]:0->1 hier=IIR
+000781  point: comment=acc_y_reg[4]:1->0 hier=IIR
+000770  point: comment=acc_y_reg[50]:0->1 hier=IIR
+000767  point: comment=acc_y_reg[50]:1->0 hier=IIR
+000765  point: comment=acc_y_reg[51]:0->1 hier=IIR
+000761  point: comment=acc_y_reg[51]:1->0 hier=IIR
+000779  point: comment=acc_y_reg[52]:0->1 hier=IIR
+000777  point: comment=acc_y_reg[52]:1->0 hier=IIR
+000795  point: comment=acc_y_reg[53]:0->1 hier=IIR
+000791  point: comment=acc_y_reg[53]:1->0 hier=IIR
+000784  point: comment=acc_y_reg[54]:0->1 hier=IIR
+000783  point: comment=acc_y_reg[54]:1->0 hier=IIR
+000744  point: comment=acc_y_reg[55]:0->1 hier=IIR
+000743  point: comment=acc_y_reg[55]:1->0 hier=IIR
+000853  point: comment=acc_y_reg[56]:0->1 hier=IIR
+000852  point: comment=acc_y_reg[56]:1->0 hier=IIR
+000853  point: comment=acc_y_reg[57]:0->1 hier=IIR
+000852  point: comment=acc_y_reg[57]:1->0 hier=IIR
+000853  point: comment=acc_y_reg[58]:0->1 hier=IIR
+000852  point: comment=acc_y_reg[58]:1->0 hier=IIR
+000749  point: comment=acc_y_reg[5]:0->1 hier=IIR
+000745  point: comment=acc_y_reg[5]:1->0 hier=IIR
+000755  point: comment=acc_y_reg[6]:0->1 hier=IIR
+000753  point: comment=acc_y_reg[6]:1->0 hier=IIR
+000736  point: comment=acc_y_reg[7]:0->1 hier=IIR
+000731  point: comment=acc_y_reg[7]:1->0 hier=IIR
+000766  point: comment=acc_y_reg[8]:0->1 hier=IIR
+000764  point: comment=acc_y_reg[8]:1->0 hier=IIR
+000739  point: comment=acc_y_reg[9]:0->1 hier=IIR
+000735  point: comment=acc_y_reg[9]:1->0 hier=IIR
 000878    logic signed [O_ACC_WIDTH:0]    acc_y_comb;
+000710  point: comment=acc_y_comb[0]:0->1 hier=IIR
+000706  point: comment=acc_y_comb[0]:1->0 hier=IIR
+000761  point: comment=acc_y_comb[10]:0->1 hier=IIR
+000760  point: comment=acc_y_comb[10]:1->0 hier=IIR
+000794  point: comment=acc_y_comb[11]:0->1 hier=IIR
+000790  point: comment=acc_y_comb[11]:1->0 hier=IIR
+000776  point: comment=acc_y_comb[12]:0->1 hier=IIR
+000771  point: comment=acc_y_comb[12]:1->0 hier=IIR
+000777  point: comment=acc_y_comb[13]:0->1 hier=IIR
+000774  point: comment=acc_y_comb[13]:1->0 hier=IIR
+000785  point: comment=acc_y_comb[14]:0->1 hier=IIR
+000783  point: comment=acc_y_comb[14]:1->0 hier=IIR
+000763  point: comment=acc_y_comb[15]:0->1 hier=IIR
+000760  point: comment=acc_y_comb[15]:1->0 hier=IIR
+000785  point: comment=acc_y_comb[16]:0->1 hier=IIR
+000781  point: comment=acc_y_comb[16]:1->0 hier=IIR
+000809  point: comment=acc_y_comb[17]:0->1 hier=IIR
+000808  point: comment=acc_y_comb[17]:1->0 hier=IIR
+000796  point: comment=acc_y_comb[18]:0->1 hier=IIR
+000794  point: comment=acc_y_comb[18]:1->0 hier=IIR
+000805  point: comment=acc_y_comb[19]:0->1 hier=IIR
+000801  point: comment=acc_y_comb[19]:1->0 hier=IIR
+000732  point: comment=acc_y_comb[1]:0->1 hier=IIR
+000730  point: comment=acc_y_comb[1]:1->0 hier=IIR
+000798  point: comment=acc_y_comb[20]:0->1 hier=IIR
+000796  point: comment=acc_y_comb[20]:1->0 hier=IIR
+000767  point: comment=acc_y_comb[21]:0->1 hier=IIR
+000764  point: comment=acc_y_comb[21]:1->0 hier=IIR
+000802  point: comment=acc_y_comb[22]:0->1 hier=IIR
+000800  point: comment=acc_y_comb[22]:1->0 hier=IIR
+000795  point: comment=acc_y_comb[23]:0->1 hier=IIR
+000790  point: comment=acc_y_comb[23]:1->0 hier=IIR
+000796  point: comment=acc_y_comb[24]:0->1 hier=IIR
+000792  point: comment=acc_y_comb[24]:1->0 hier=IIR
+000735  point: comment=acc_y_comb[25]:0->1 hier=IIR
+000732  point: comment=acc_y_comb[25]:1->0 hier=IIR
+000782  point: comment=acc_y_comb[26]:0->1 hier=IIR
+000778  point: comment=acc_y_comb[26]:1->0 hier=IIR
+000802  point: comment=acc_y_comb[27]:0->1 hier=IIR
+000801  point: comment=acc_y_comb[27]:1->0 hier=IIR
+000776  point: comment=acc_y_comb[28]:0->1 hier=IIR
+000773  point: comment=acc_y_comb[28]:1->0 hier=IIR
+000809  point: comment=acc_y_comb[29]:0->1 hier=IIR
+000805  point: comment=acc_y_comb[29]:1->0 hier=IIR
+000770  point: comment=acc_y_comb[2]:0->1 hier=IIR
+000770  point: comment=acc_y_comb[2]:1->0 hier=IIR
+000770  point: comment=acc_y_comb[30]:0->1 hier=IIR
+000768  point: comment=acc_y_comb[30]:1->0 hier=IIR
+000808  point: comment=acc_y_comb[31]:0->1 hier=IIR
+000804  point: comment=acc_y_comb[31]:1->0 hier=IIR
+000801  point: comment=acc_y_comb[32]:0->1 hier=IIR
+000798  point: comment=acc_y_comb[32]:1->0 hier=IIR
+000774  point: comment=acc_y_comb[33]:0->1 hier=IIR
+000770  point: comment=acc_y_comb[33]:1->0 hier=IIR
+000804  point: comment=acc_y_comb[34]:0->1 hier=IIR
+000802  point: comment=acc_y_comb[34]:1->0 hier=IIR
+000792  point: comment=acc_y_comb[35]:0->1 hier=IIR
+000790  point: comment=acc_y_comb[35]:1->0 hier=IIR
+000805  point: comment=acc_y_comb[36]:0->1 hier=IIR
+000801  point: comment=acc_y_comb[36]:1->0 hier=IIR
+000757  point: comment=acc_y_comb[37]:0->1 hier=IIR
+000755  point: comment=acc_y_comb[37]:1->0 hier=IIR
+000771  point: comment=acc_y_comb[38]:0->1 hier=IIR
+000769  point: comment=acc_y_comb[38]:1->0 hier=IIR
+000778  point: comment=acc_y_comb[39]:0->1 hier=IIR
+000775  point: comment=acc_y_comb[39]:1->0 hier=IIR
+000749  point: comment=acc_y_comb[3]:0->1 hier=IIR
+000747  point: comment=acc_y_comb[3]:1->0 hier=IIR
+000770  point: comment=acc_y_comb[40]:0->1 hier=IIR
+000768  point: comment=acc_y_comb[40]:1->0 hier=IIR
+000793  point: comment=acc_y_comb[41]:0->1 hier=IIR
+000790  point: comment=acc_y_comb[41]:1->0 hier=IIR
+000777  point: comment=acc_y_comb[42]:0->1 hier=IIR
+000776  point: comment=acc_y_comb[42]:1->0 hier=IIR
+000815  point: comment=acc_y_comb[43]:0->1 hier=IIR
+000812  point: comment=acc_y_comb[43]:1->0 hier=IIR
+000788  point: comment=acc_y_comb[44]:0->1 hier=IIR
+000785  point: comment=acc_y_comb[44]:1->0 hier=IIR
+000788  point: comment=acc_y_comb[45]:0->1 hier=IIR
+000786  point: comment=acc_y_comb[45]:1->0 hier=IIR
+000782  point: comment=acc_y_comb[46]:0->1 hier=IIR
+000780  point: comment=acc_y_comb[46]:1->0 hier=IIR
+000787  point: comment=acc_y_comb[47]:0->1 hier=IIR
+000784  point: comment=acc_y_comb[47]:1->0 hier=IIR
+000786  point: comment=acc_y_comb[48]:0->1 hier=IIR
+000784  point: comment=acc_y_comb[48]:1->0 hier=IIR
+000780  point: comment=acc_y_comb[49]:0->1 hier=IIR
+000777  point: comment=acc_y_comb[49]:1->0 hier=IIR
+000803  point: comment=acc_y_comb[4]:0->1 hier=IIR
+000799  point: comment=acc_y_comb[4]:1->0 hier=IIR
+000798  point: comment=acc_y_comb[50]:0->1 hier=IIR
+000795  point: comment=acc_y_comb[50]:1->0 hier=IIR
+000793  point: comment=acc_y_comb[51]:0->1 hier=IIR
+000789  point: comment=acc_y_comb[51]:1->0 hier=IIR
+000799  point: comment=acc_y_comb[52]:0->1 hier=IIR
+000797  point: comment=acc_y_comb[52]:1->0 hier=IIR
+000817  point: comment=acc_y_comb[53]:0->1 hier=IIR
+000813  point: comment=acc_y_comb[53]:1->0 hier=IIR
+000806  point: comment=acc_y_comb[54]:0->1 hier=IIR
+000805  point: comment=acc_y_comb[54]:1->0 hier=IIR
+000767  point: comment=acc_y_comb[55]:0->1 hier=IIR
+000766  point: comment=acc_y_comb[55]:1->0 hier=IIR
+000878  point: comment=acc_y_comb[56]:0->1 hier=IIR
+000877  point: comment=acc_y_comb[56]:1->0 hier=IIR
+000878  point: comment=acc_y_comb[57]:0->1 hier=IIR
+000877  point: comment=acc_y_comb[57]:1->0 hier=IIR
+000878  point: comment=acc_y_comb[58]:0->1 hier=IIR
+000877  point: comment=acc_y_comb[58]:1->0 hier=IIR
+000770  point: comment=acc_y_comb[5]:0->1 hier=IIR
+000766  point: comment=acc_y_comb[5]:1->0 hier=IIR
+000776  point: comment=acc_y_comb[6]:0->1 hier=IIR
+000774  point: comment=acc_y_comb[6]:1->0 hier=IIR
+000757  point: comment=acc_y_comb[7]:0->1 hier=IIR
+000752  point: comment=acc_y_comb[7]:1->0 hier=IIR
+000794  point: comment=acc_y_comb[8]:0->1 hier=IIR
+000792  point: comment=acc_y_comb[8]:1->0 hier=IIR
+000765  point: comment=acc_y_comb[9]:0->1 hier=IIR
+000761  point: comment=acc_y_comb[9]:1->0 hier=IIR
 001091    logic signed [RES_ACC_WIDTH:0]  acc_res;
+000909  point: comment=acc_res[0]:0->1 hier=IIR
+000907  point: comment=acc_res[0]:1->0 hier=IIR
+001002  point: comment=acc_res[10]:0->1 hier=IIR
+000999  point: comment=acc_res[10]:1->0 hier=IIR
+001009  point: comment=acc_res[11]:0->1 hier=IIR
+001006  point: comment=acc_res[11]:1->0 hier=IIR
+000969  point: comment=acc_res[12]:0->1 hier=IIR
+000967  point: comment=acc_res[12]:1->0 hier=IIR
+000981  point: comment=acc_res[13]:0->1 hier=IIR
+000979  point: comment=acc_res[13]:1->0 hier=IIR
+000997  point: comment=acc_res[14]:0->1 hier=IIR
+000994  point: comment=acc_res[14]:1->0 hier=IIR
+000946  point: comment=acc_res[15]:0->1 hier=IIR
+000945  point: comment=acc_res[15]:1->0 hier=IIR
+000986  point: comment=acc_res[16]:0->1 hier=IIR
+000986  point: comment=acc_res[16]:1->0 hier=IIR
+000946  point: comment=acc_res[17]:0->1 hier=IIR
+000944  point: comment=acc_res[17]:1->0 hier=IIR
+000960  point: comment=acc_res[18]:0->1 hier=IIR
+000958  point: comment=acc_res[18]:1->0 hier=IIR
+000974  point: comment=acc_res[19]:0->1 hier=IIR
+000971  point: comment=acc_res[19]:1->0 hier=IIR
+000952  point: comment=acc_res[1]:0->1 hier=IIR
+000948  point: comment=acc_res[1]:1->0 hier=IIR
+000962  point: comment=acc_res[20]:0->1 hier=IIR
+000960  point: comment=acc_res[20]:1->0 hier=IIR
+000980  point: comment=acc_res[21]:0->1 hier=IIR
+000977  point: comment=acc_res[21]:1->0 hier=IIR
+000984  point: comment=acc_res[22]:0->1 hier=IIR
+000982  point: comment=acc_res[22]:1->0 hier=IIR
+000978  point: comment=acc_res[23]:0->1 hier=IIR
+000977  point: comment=acc_res[23]:1->0 hier=IIR
+000986  point: comment=acc_res[24]:0->1 hier=IIR
+000983  point: comment=acc_res[24]:1->0 hier=IIR
+000972  point: comment=acc_res[25]:0->1 hier=IIR
+000969  point: comment=acc_res[25]:1->0 hier=IIR
+000972  point: comment=acc_res[26]:0->1 hier=IIR
+000969  point: comment=acc_res[26]:1->0 hier=IIR
+000995  point: comment=acc_res[27]:0->1 hier=IIR
+000991  point: comment=acc_res[27]:1->0 hier=IIR
+000969  point: comment=acc_res[28]:0->1 hier=IIR
+000967  point: comment=acc_res[28]:1->0 hier=IIR
+000973  point: comment=acc_res[29]:0->1 hier=IIR
+000968  point: comment=acc_res[29]:1->0 hier=IIR
+000947  point: comment=acc_res[2]:0->1 hier=IIR
+000946  point: comment=acc_res[2]:1->0 hier=IIR
+000969  point: comment=acc_res[30]:0->1 hier=IIR
+000964  point: comment=acc_res[30]:1->0 hier=IIR
+001032  point: comment=acc_res[31]:0->1 hier=IIR
+001029  point: comment=acc_res[31]:1->0 hier=IIR
+001017  point: comment=acc_res[32]:0->1 hier=IIR
+001014  point: comment=acc_res[32]:1->0 hier=IIR
+001036  point: comment=acc_res[33]:0->1 hier=IIR
+001033  point: comment=acc_res[33]:1->0 hier=IIR
+001026  point: comment=acc_res[34]:0->1 hier=IIR
+001023  point: comment=acc_res[34]:1->0 hier=IIR
+001015  point: comment=acc_res[35]:0->1 hier=IIR
+001010  point: comment=acc_res[35]:1->0 hier=IIR
+000985  point: comment=acc_res[36]:0->1 hier=IIR
+000984  point: comment=acc_res[36]:1->0 hier=IIR
+001044  point: comment=acc_res[37]:0->1 hier=IIR
+001041  point: comment=acc_res[37]:1->0 hier=IIR
+001038  point: comment=acc_res[38]:0->1 hier=IIR
+001035  point: comment=acc_res[38]:1->0 hier=IIR
+001031  point: comment=acc_res[39]:0->1 hier=IIR
+001025  point: comment=acc_res[39]:1->0 hier=IIR
+000958  point: comment=acc_res[3]:0->1 hier=IIR
+000955  point: comment=acc_res[3]:1->0 hier=IIR
+001023  point: comment=acc_res[40]:0->1 hier=IIR
+001020  point: comment=acc_res[40]:1->0 hier=IIR
+001032  point: comment=acc_res[41]:0->1 hier=IIR
+001031  point: comment=acc_res[41]:1->0 hier=IIR
+001038  point: comment=acc_res[42]:0->1 hier=IIR
+001034  point: comment=acc_res[42]:1->0 hier=IIR
+001087  point: comment=acc_res[43]:0->1 hier=IIR
+001085  point: comment=acc_res[43]:1->0 hier=IIR
+001043  point: comment=acc_res[44]:0->1 hier=IIR
+001040  point: comment=acc_res[44]:1->0 hier=IIR
+001037  point: comment=acc_res[45]:0->1 hier=IIR
+001035  point: comment=acc_res[45]:1->0 hier=IIR
+001047  point: comment=acc_res[46]:0->1 hier=IIR
+001043  point: comment=acc_res[46]:1->0 hier=IIR
+001025  point: comment=acc_res[47]:0->1 hier=IIR
+001021  point: comment=acc_res[47]:1->0 hier=IIR
+001023  point: comment=acc_res[48]:0->1 hier=IIR
+001019  point: comment=acc_res[48]:1->0 hier=IIR
+001034  point: comment=acc_res[49]:0->1 hier=IIR
+001031  point: comment=acc_res[49]:1->0 hier=IIR
+000993  point: comment=acc_res[4]:0->1 hier=IIR
+000993  point: comment=acc_res[4]:1->0 hier=IIR
+001021  point: comment=acc_res[50]:0->1 hier=IIR
+001016  point: comment=acc_res[50]:1->0 hier=IIR
+001029  point: comment=acc_res[51]:0->1 hier=IIR
+001025  point: comment=acc_res[51]:1->0 hier=IIR
+001033  point: comment=acc_res[52]:0->1 hier=IIR
+001031  point: comment=acc_res[52]:1->0 hier=IIR
+001072  point: comment=acc_res[53]:0->1 hier=IIR
+001067  point: comment=acc_res[53]:1->0 hier=IIR
+001091  point: comment=acc_res[54]:0->1 hier=IIR
+001088  point: comment=acc_res[54]:1->0 hier=IIR
+001051  point: comment=acc_res[55]:0->1 hier=IIR
+001047  point: comment=acc_res[55]:1->0 hier=IIR
+001049  point: comment=acc_res[56]:0->1 hier=IIR
+001045  point: comment=acc_res[56]:1->0 hier=IIR
+001049  point: comment=acc_res[57]:0->1 hier=IIR
+001045  point: comment=acc_res[57]:1->0 hier=IIR
+001049  point: comment=acc_res[58]:0->1 hier=IIR
+001045  point: comment=acc_res[58]:1->0 hier=IIR
+001049  point: comment=acc_res[59]:0->1 hier=IIR
+001045  point: comment=acc_res[59]:1->0 hier=IIR
+000960  point: comment=acc_res[5]:0->1 hier=IIR
+000958  point: comment=acc_res[5]:1->0 hier=IIR
+001049  point: comment=acc_res[60]:0->1 hier=IIR
+001045  point: comment=acc_res[60]:1->0 hier=IIR
+001049  point: comment=acc_res[61]:0->1 hier=IIR
+001045  point: comment=acc_res[61]:1->0 hier=IIR
+000958  point: comment=acc_res[6]:0->1 hier=IIR
+000956  point: comment=acc_res[6]:1->0 hier=IIR
+000974  point: comment=acc_res[7]:0->1 hier=IIR
+000971  point: comment=acc_res[7]:1->0 hier=IIR
+000973  point: comment=acc_res[8]:0->1 hier=IIR
+000971  point: comment=acc_res[8]:1->0 hier=IIR
+000968  point: comment=acc_res[9]:0->1 hier=IIR
+000967  point: comment=acc_res[9]:1->0 hier=IIR
 001091    logic signed [RES_ACC_WIDTH:0]  acc_res_rounded;
+000909  point: comment=acc_res_rounded[0]:0->1 hier=IIR
+000907  point: comment=acc_res_rounded[0]:1->0 hier=IIR
+001002  point: comment=acc_res_rounded[10]:0->1 hier=IIR
+000999  point: comment=acc_res_rounded[10]:1->0 hier=IIR
+001009  point: comment=acc_res_rounded[11]:0->1 hier=IIR
+001006  point: comment=acc_res_rounded[11]:1->0 hier=IIR
+000969  point: comment=acc_res_rounded[12]:0->1 hier=IIR
+000967  point: comment=acc_res_rounded[12]:1->0 hier=IIR
+000981  point: comment=acc_res_rounded[13]:0->1 hier=IIR
+000979  point: comment=acc_res_rounded[13]:1->0 hier=IIR
+000997  point: comment=acc_res_rounded[14]:0->1 hier=IIR
+000994  point: comment=acc_res_rounded[14]:1->0 hier=IIR
+000946  point: comment=acc_res_rounded[15]:0->1 hier=IIR
+000945  point: comment=acc_res_rounded[15]:1->0 hier=IIR
+000986  point: comment=acc_res_rounded[16]:0->1 hier=IIR
+000986  point: comment=acc_res_rounded[16]:1->0 hier=IIR
+000946  point: comment=acc_res_rounded[17]:0->1 hier=IIR
+000944  point: comment=acc_res_rounded[17]:1->0 hier=IIR
+000960  point: comment=acc_res_rounded[18]:0->1 hier=IIR
+000958  point: comment=acc_res_rounded[18]:1->0 hier=IIR
+000974  point: comment=acc_res_rounded[19]:0->1 hier=IIR
+000971  point: comment=acc_res_rounded[19]:1->0 hier=IIR
+000952  point: comment=acc_res_rounded[1]:0->1 hier=IIR
+000948  point: comment=acc_res_rounded[1]:1->0 hier=IIR
+000962  point: comment=acc_res_rounded[20]:0->1 hier=IIR
+000960  point: comment=acc_res_rounded[20]:1->0 hier=IIR
+000980  point: comment=acc_res_rounded[21]:0->1 hier=IIR
+000977  point: comment=acc_res_rounded[21]:1->0 hier=IIR
+000984  point: comment=acc_res_rounded[22]:0->1 hier=IIR
+000982  point: comment=acc_res_rounded[22]:1->0 hier=IIR
+000978  point: comment=acc_res_rounded[23]:0->1 hier=IIR
+000977  point: comment=acc_res_rounded[23]:1->0 hier=IIR
+000986  point: comment=acc_res_rounded[24]:0->1 hier=IIR
+000983  point: comment=acc_res_rounded[24]:1->0 hier=IIR
+000972  point: comment=acc_res_rounded[25]:0->1 hier=IIR
+000969  point: comment=acc_res_rounded[25]:1->0 hier=IIR
+000972  point: comment=acc_res_rounded[26]:0->1 hier=IIR
+000969  point: comment=acc_res_rounded[26]:1->0 hier=IIR
+000995  point: comment=acc_res_rounded[27]:0->1 hier=IIR
+000991  point: comment=acc_res_rounded[27]:1->0 hier=IIR
+000969  point: comment=acc_res_rounded[28]:0->1 hier=IIR
+000967  point: comment=acc_res_rounded[28]:1->0 hier=IIR
+000973  point: comment=acc_res_rounded[29]:0->1 hier=IIR
+000968  point: comment=acc_res_rounded[29]:1->0 hier=IIR
+000947  point: comment=acc_res_rounded[2]:0->1 hier=IIR
+000946  point: comment=acc_res_rounded[2]:1->0 hier=IIR
+000971  point: comment=acc_res_rounded[30]:0->1 hier=IIR
+000969  point: comment=acc_res_rounded[30]:1->0 hier=IIR
+001022  point: comment=acc_res_rounded[31]:0->1 hier=IIR
+001018  point: comment=acc_res_rounded[31]:1->0 hier=IIR
+001035  point: comment=acc_res_rounded[32]:0->1 hier=IIR
+001030  point: comment=acc_res_rounded[32]:1->0 hier=IIR
+001040  point: comment=acc_res_rounded[33]:0->1 hier=IIR
+001037  point: comment=acc_res_rounded[33]:1->0 hier=IIR
+001025  point: comment=acc_res_rounded[34]:0->1 hier=IIR
+001022  point: comment=acc_res_rounded[34]:1->0 hier=IIR
+001014  point: comment=acc_res_rounded[35]:0->1 hier=IIR
+001009  point: comment=acc_res_rounded[35]:1->0 hier=IIR
+000986  point: comment=acc_res_rounded[36]:0->1 hier=IIR
+000985  point: comment=acc_res_rounded[36]:1->0 hier=IIR
+001042  point: comment=acc_res_rounded[37]:0->1 hier=IIR
+001039  point: comment=acc_res_rounded[37]:1->0 hier=IIR
+001039  point: comment=acc_res_rounded[38]:0->1 hier=IIR
+001036  point: comment=acc_res_rounded[38]:1->0 hier=IIR
+001031  point: comment=acc_res_rounded[39]:0->1 hier=IIR
+001025  point: comment=acc_res_rounded[39]:1->0 hier=IIR
+000958  point: comment=acc_res_rounded[3]:0->1 hier=IIR
+000955  point: comment=acc_res_rounded[3]:1->0 hier=IIR
+001025  point: comment=acc_res_rounded[40]:0->1 hier=IIR
+001022  point: comment=acc_res_rounded[40]:1->0 hier=IIR
+001033  point: comment=acc_res_rounded[41]:0->1 hier=IIR
+001032  point: comment=acc_res_rounded[41]:1->0 hier=IIR
+001038  point: comment=acc_res_rounded[42]:0->1 hier=IIR
+001034  point: comment=acc_res_rounded[42]:1->0 hier=IIR
+001087  point: comment=acc_res_rounded[43]:0->1 hier=IIR
+001085  point: comment=acc_res_rounded[43]:1->0 hier=IIR
+001043  point: comment=acc_res_rounded[44]:0->1 hier=IIR
+001040  point: comment=acc_res_rounded[44]:1->0 hier=IIR
+001037  point: comment=acc_res_rounded[45]:0->1 hier=IIR
+001035  point: comment=acc_res_rounded[45]:1->0 hier=IIR
+001047  point: comment=acc_res_rounded[46]:0->1 hier=IIR
+001043  point: comment=acc_res_rounded[46]:1->0 hier=IIR
+001025  point: comment=acc_res_rounded[47]:0->1 hier=IIR
+001021  point: comment=acc_res_rounded[47]:1->0 hier=IIR
+001023  point: comment=acc_res_rounded[48]:0->1 hier=IIR
+001019  point: comment=acc_res_rounded[48]:1->0 hier=IIR
+001034  point: comment=acc_res_rounded[49]:0->1 hier=IIR
+001031  point: comment=acc_res_rounded[49]:1->0 hier=IIR
+000993  point: comment=acc_res_rounded[4]:0->1 hier=IIR
+000993  point: comment=acc_res_rounded[4]:1->0 hier=IIR
+001021  point: comment=acc_res_rounded[50]:0->1 hier=IIR
+001016  point: comment=acc_res_rounded[50]:1->0 hier=IIR
+001029  point: comment=acc_res_rounded[51]:0->1 hier=IIR
+001025  point: comment=acc_res_rounded[51]:1->0 hier=IIR
+001033  point: comment=acc_res_rounded[52]:0->1 hier=IIR
+001031  point: comment=acc_res_rounded[52]:1->0 hier=IIR
+001072  point: comment=acc_res_rounded[53]:0->1 hier=IIR
+001067  point: comment=acc_res_rounded[53]:1->0 hier=IIR
+001091  point: comment=acc_res_rounded[54]:0->1 hier=IIR
+001088  point: comment=acc_res_rounded[54]:1->0 hier=IIR
+001051  point: comment=acc_res_rounded[55]:0->1 hier=IIR
+001047  point: comment=acc_res_rounded[55]:1->0 hier=IIR
+001049  point: comment=acc_res_rounded[56]:0->1 hier=IIR
+001045  point: comment=acc_res_rounded[56]:1->0 hier=IIR
+001049  point: comment=acc_res_rounded[57]:0->1 hier=IIR
+001045  point: comment=acc_res_rounded[57]:1->0 hier=IIR
+001049  point: comment=acc_res_rounded[58]:0->1 hier=IIR
+001045  point: comment=acc_res_rounded[58]:1->0 hier=IIR
+001049  point: comment=acc_res_rounded[59]:0->1 hier=IIR
+001045  point: comment=acc_res_rounded[59]:1->0 hier=IIR
+000960  point: comment=acc_res_rounded[5]:0->1 hier=IIR
+000958  point: comment=acc_res_rounded[5]:1->0 hier=IIR
+001049  point: comment=acc_res_rounded[60]:0->1 hier=IIR
+001045  point: comment=acc_res_rounded[60]:1->0 hier=IIR
+001049  point: comment=acc_res_rounded[61]:0->1 hier=IIR
+001045  point: comment=acc_res_rounded[61]:1->0 hier=IIR
+000958  point: comment=acc_res_rounded[6]:0->1 hier=IIR
+000956  point: comment=acc_res_rounded[6]:1->0 hier=IIR
+000974  point: comment=acc_res_rounded[7]:0->1 hier=IIR
+000971  point: comment=acc_res_rounded[7]:1->0 hier=IIR
+000973  point: comment=acc_res_rounded[8]:0->1 hier=IIR
+000971  point: comment=acc_res_rounded[8]:1->0 hier=IIR
+000968  point: comment=acc_res_rounded[9]:0->1 hier=IIR
+000967  point: comment=acc_res_rounded[9]:1->0 hier=IIR
        
 003831    logic                           tap_en;
+003831  point: comment=tap_en:0->1 hier=IIR
+003831  point: comment=tap_en:1->0 hier=IIR
 003092    logic                           output_en;   
+003092  point: comment=output_en:0->1 hier=IIR
+003092  point: comment=output_en:1->0 hier=IIR
        
 001077    logic [DATA_WIDTH-1:0]          y;   
+001017  point: comment=y[0]:0->1 hier=IIR
+001014  point: comment=y[0]:1->0 hier=IIR
+001028  point: comment=y[10]:0->1 hier=IIR
+001027  point: comment=y[10]:1->0 hier=IIR
+001038  point: comment=y[11]:0->1 hier=IIR
+001035  point: comment=y[11]:1->0 hier=IIR
+001077  point: comment=y[12]:0->1 hier=IIR
+001076  point: comment=y[12]:1->0 hier=IIR
+001029  point: comment=y[13]:0->1 hier=IIR
+001027  point: comment=y[13]:1->0 hier=IIR
+001038  point: comment=y[14]:0->1 hier=IIR
+001037  point: comment=y[14]:1->0 hier=IIR
+001039  point: comment=y[15]:0->1 hier=IIR
+001036  point: comment=y[15]:1->0 hier=IIR
+001034  point: comment=y[16]:0->1 hier=IIR
+001031  point: comment=y[16]:1->0 hier=IIR
+001020  point: comment=y[17]:0->1 hier=IIR
+001017  point: comment=y[17]:1->0 hier=IIR
+001044  point: comment=y[18]:0->1 hier=IIR
+001042  point: comment=y[18]:1->0 hier=IIR
+001028  point: comment=y[19]:0->1 hier=IIR
+001024  point: comment=y[19]:1->0 hier=IIR
+001029  point: comment=y[1]:0->1 hier=IIR
+001025  point: comment=y[1]:1->0 hier=IIR
+001020  point: comment=y[20]:0->1 hier=IIR
+001017  point: comment=y[20]:1->0 hier=IIR
+001035  point: comment=y[21]:0->1 hier=IIR
+001034  point: comment=y[21]:1->0 hier=IIR
+001057  point: comment=y[22]:0->1 hier=IIR
+001053  point: comment=y[22]:1->0 hier=IIR
+001049  point: comment=y[23]:0->1 hier=IIR
+001045  point: comment=y[23]:1->0 hier=IIR
+001036  point: comment=y[2]:0->1 hier=IIR
+001034  point: comment=y[2]:1->0 hier=IIR
+001021  point: comment=y[3]:0->1 hier=IIR
+001019  point: comment=y[3]:1->0 hier=IIR
+001015  point: comment=y[4]:0->1 hier=IIR
+001011  point: comment=y[4]:1->0 hier=IIR
+000975  point: comment=y[5]:0->1 hier=IIR
+000974  point: comment=y[5]:1->0 hier=IIR
+001037  point: comment=y[6]:0->1 hier=IIR
+001035  point: comment=y[6]:1->0 hier=IIR
+001030  point: comment=y[7]:0->1 hier=IIR
+001028  point: comment=y[7]:1->0 hier=IIR
+001034  point: comment=y[8]:0->1 hier=IIR
+001029  point: comment=y[8]:1->0 hier=IIR
+001027  point: comment=y[9]:0->1 hier=IIR
+001024  point: comment=y[9]:1->0 hier=IIR
 000915    logic [DATA_WIDTH-1:0]          y_tap;   
+000885  point: comment=y_tap[0]:0->1 hier=IIR
+000881  point: comment=y_tap[0]:1->0 hier=IIR
+000896  point: comment=y_tap[10]:0->1 hier=IIR
+000893  point: comment=y_tap[10]:1->0 hier=IIR
+000886  point: comment=y_tap[11]:0->1 hier=IIR
+000883  point: comment=y_tap[11]:1->0 hier=IIR
+000915  point: comment=y_tap[12]:0->1 hier=IIR
+000913  point: comment=y_tap[12]:1->0 hier=IIR
+000880  point: comment=y_tap[13]:0->1 hier=IIR
+000877  point: comment=y_tap[13]:1->0 hier=IIR
+000888  point: comment=y_tap[14]:0->1 hier=IIR
+000886  point: comment=y_tap[14]:1->0 hier=IIR
+000898  point: comment=y_tap[15]:0->1 hier=IIR
+000895  point: comment=y_tap[15]:1->0 hier=IIR
+000882  point: comment=y_tap[16]:0->1 hier=IIR
+000877  point: comment=y_tap[16]:1->0 hier=IIR
+000862  point: comment=y_tap[17]:0->1 hier=IIR
+000860  point: comment=y_tap[17]:1->0 hier=IIR
+000899  point: comment=y_tap[18]:0->1 hier=IIR
+000896  point: comment=y_tap[18]:1->0 hier=IIR
+000890  point: comment=y_tap[19]:0->1 hier=IIR
+000887  point: comment=y_tap[19]:1->0 hier=IIR
+000882  point: comment=y_tap[1]:0->1 hier=IIR
+000880  point: comment=y_tap[1]:1->0 hier=IIR
+000871  point: comment=y_tap[20]:0->1 hier=IIR
+000867  point: comment=y_tap[20]:1->0 hier=IIR
+000882  point: comment=y_tap[21]:0->1 hier=IIR
+000881  point: comment=y_tap[21]:1->0 hier=IIR
+000902  point: comment=y_tap[22]:0->1 hier=IIR
+000898  point: comment=y_tap[22]:1->0 hier=IIR
+000909  point: comment=y_tap[23]:0->1 hier=IIR
+000904  point: comment=y_tap[23]:1->0 hier=IIR
+000895  point: comment=y_tap[2]:0->1 hier=IIR
+000894  point: comment=y_tap[2]:1->0 hier=IIR
+000867  point: comment=y_tap[3]:0->1 hier=IIR
+000865  point: comment=y_tap[3]:1->0 hier=IIR
+000881  point: comment=y_tap[4]:0->1 hier=IIR
+000878  point: comment=y_tap[4]:1->0 hier=IIR
+000844  point: comment=y_tap[5]:0->1 hier=IIR
+000841  point: comment=y_tap[5]:1->0 hier=IIR
+000882  point: comment=y_tap[6]:0->1 hier=IIR
+000881  point: comment=y_tap[6]:1->0 hier=IIR
+000887  point: comment=y_tap[7]:0->1 hier=IIR
+000886  point: comment=y_tap[7]:1->0 hier=IIR
+000872  point: comment=y_tap[8]:0->1 hier=IIR
+000867  point: comment=y_tap[8]:1->0 hier=IIR
+000905  point: comment=y_tap[9]:0->1 hier=IIR
+000903  point: comment=y_tap[9]:1->0 hier=IIR
        
           typedef enum bit [1:0] {IDLE, PROCESS, STORE} state_t;
 003582    state_t  state;
+003582  point: comment=state[0]:0->1 hier=IIR
+003576  point: comment=state[0]:1->0 hier=IIR
+003092  point: comment=state[1]:0->1 hier=IIR
+003092  point: comment=state[1]:1->0 hier=IIR
 003831    state_t  next_state;
+003831  point: comment=next_state[0]:0->1 hier=IIR
+003828  point: comment=next_state[0]:1->0 hier=IIR
+003211  point: comment=next_state[1]:0->1 hier=IIR
+003208  point: comment=next_state[1]:1->0 hier=IIR
 004210    logic process_done;   
+004210  point: comment=process_done:0->1 hier=IIR
+004205  point: comment=process_done:1->0 hier=IIR
        
           // Data path
           genvar i;
           
           generate
        
 010746       for (i=0; i<INPUT_TAPS; i++) begin :  input_taps
+007914  point: comment=elsif hier=IIR
+010746  point: comment=if hier=IIR
+003582  point: comment=if hier=IIR
+007164  point: comment=else hier=IIR
 086358          always_ff @ (posedge clk_i or negedge rst_i) begin
+086358  point: comment=block hier=IIR
 078444             if (~rst_i) begin             
+007914  point: comment=elsif hier=IIR
+007914  point: comment=(rst_i==0) => 1 hier=IIR
+078444  point: comment=(rst_i==1) => 0 hier=IIR
 007914                input_tap[i] <= '0;
+007914  point: comment=elsif hier=IIR
 007914                coeff_x[i] <= '0;
+007914  point: comment=elsif hier=IIR
                    end
 067698             else if (tap_en) begin
+010746  point: comment=if hier=IIR
+067698  point: comment=else hier=IIR
 010746                coeff_x[i] <= coeff_x_i[i];
+010746  point: comment=if hier=IIR
 007164                if (i == '0)
+003582  point: comment=if hier=IIR
+007164  point: comment=else hier=IIR
 003582                  input_tap [i] <= x_i;
+003582  point: comment=if hier=IIR
                       else
 007164                  input_tap [i] <= input_tap[i-1];
+007164  point: comment=else hier=IIR
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
 166243    always_comb begin
+166243  point: comment=block hier=IIR
 166243       acc_x_comb = '0;   
+166243  point: comment=block hier=IIR
 498729       for (int i=0; i<INPUT_TAPS; i++) begin
+166243  point: comment=block hier=IIR
+498729  point: comment=block hier=IIR
 498729          acc_x_comb += multi_prod_x[i];
+498729  point: comment=block hier=IIR
              end
           end
           /* verilator lint_on WIDTHEXPAND */
        
           generate
        
 007164       for (i=0; i<OUTPUT_TAPS; i++) begin :  output_taps
+005276  point: comment=elsif hier=IIR
+007164  point: comment=if hier=IIR
+003582  point: comment=if hier=IIR
+003582  point: comment=else hier=IIR
 057572          always_ff @ (posedge clk_i or negedge rst_i) begin
+057572  point: comment=block hier=IIR
 052296             if (~rst_i) begin             
+005276  point: comment=elsif hier=IIR
+005276  point: comment=(rst_i==0) => 1 hier=IIR
+052296  point: comment=(rst_i==1) => 0 hier=IIR
 005276                output_tap[i] <= '0;
+005276  point: comment=elsif hier=IIR
 005276                coeff_y[i] <= '0;
+005276  point: comment=elsif hier=IIR
                    end
 045132             else if (tap_en) begin
+007164  point: comment=if hier=IIR
+045132  point: comment=else hier=IIR
 007164                coeff_y[i] <= coeff_y_i[i];            
+007164  point: comment=if hier=IIR
 003582                if (i == '0)
+003582  point: comment=if hier=IIR
+003582  point: comment=else hier=IIR
 003582                  output_tap [i] <= y_tap;
+003582  point: comment=if hier=IIR
                       else
 003582                  output_tap [i] <= output_tap[i-1];
+003582  point: comment=else hier=IIR
                    end
                 end
        
                 multiplier_wrapper
                   #(.USE_IP(0),
                     .A_WIDTH(DATA_WIDTH),
                     .B_WIDTH(COEFF_WIDTH))
                 o_muiltplier_inst (
                                    .a(output_tap[i]),
                                    .b(coeff_y[i]),
                                    .clk(clk_i),
                                    .y(multi_prod_y[i]));
              end :  output_taps
           endgenerate
        
 166243    always_comb begin
+166243  point: comment=block hier=IIR
 166243       acc_y_comb = '0;   
+166243  point: comment=block hier=IIR
 332486       for (int i=0; i<OUTPUT_TAPS; i++) begin
+166243  point: comment=block hier=IIR
+332486  point: comment=block hier=IIR
 332486          acc_y_comb += multi_prod_y[i];
+332486  point: comment=block hier=IIR
              end
           end
        
           // This part is adding one pipeline stage therefore PROCESS_DELAY += 1
 028786    always_ff @(posedge clk_i or negedge rst_i) begin
+028786  point: comment=block hier=IIR
 026148       if (~rst_i) begin
+002638  point: comment=(rst_i==0) => 1 hier=IIR
+026148  point: comment=(rst_i==1) => 0 hier=IIR
+002638  point: comment=if hier=IIR
+026148  point: comment=else hier=IIR
 002638          acc_x_reg <= '0;
+002638  point: comment=if hier=IIR
 002638          acc_y_reg <= '0;
+002638  point: comment=if hier=IIR
 002638          y_tap <= '0;      
+002638  point: comment=if hier=IIR
              end
 026148       else begin
+026148  point: comment=else hier=IIR
 014182          if(state == PROCESS) begin
+014182  point: comment=if hier=IIR
+011966  point: comment=else hier=IIR
 014182             acc_x_reg <= acc_x_comb;
+014182  point: comment=if hier=IIR
 014182             acc_y_reg <= acc_y_comb;
+014182  point: comment=if hier=IIR
                 end
 023177          if (output_en)
+002971  point: comment=if hier=IIR
+023177  point: comment=else hier=IIR
 002971            y_tap <= y;         
+002971  point: comment=if hier=IIR
              end
           end  
           assign y_o = y_tap ;
           
           // Rounding
           // Turning off the verilator lint cause acc_res size is also considering the summation with rounding
           /* verilator lint_off WIDTHEXPAND */
           assign acc_res = acc_x_reg - acc_y_reg;
           /* verilator lint_on WIDTHEXPAND */
           assign acc_res_rounded = acc_res + ROUNDING_ERROR;  // Also summation for negative numbers since later on slicing gonna round downwards
        
           // Check for saturation
 166243    always_comb begin
+166243  point: comment=block hier=IIR
              // Checking to see if the sign bits are uniform or not
 160168       if (&acc_res_rounded[RES_ACC_WIDTH:(FRAC_WIDTH+DATA_WIDTH-1)] != |acc_res_rounded[RES_ACC_WIDTH:(FRAC_WIDTH+DATA_WIDTH-1)]) begin
+104194  point: comment=(acc_res_rounded[61:54][0]==0) => 0 hier=IIR
+058852  point: comment=(acc_res_rounded[61:54][0]==1 && acc_res_rounded[61:54][1]==1 && acc_res_rounded[61:54][2]==1 && acc_res_rounded[61:54][3]==1 && acc_res_rounded[61:54][4]==1 && acc_res_rounded[61:54][5]==1 && acc_res_rounded[61:54][6]==1 && acc_res_rounded[61:54][7]==1) => 1 hier=IIR
+104513  point: comment=(acc_res_rounded[61:54][1]==0) => 0 hier=IIR
+104471  point: comment=(acc_res_rounded[61:54][2]==0) => 0 hier=IIR
+104471  point: comment=(acc_res_rounded[61:54][3]==0) => 0 hier=IIR
+104471  point: comment=(acc_res_rounded[61:54][4]==0) => 0 hier=IIR
+104471  point: comment=(acc_res_rounded[61:54][5]==0) => 0 hier=IIR
+104471  point: comment=(acc_res_rounded[61:54][6]==0) => 0 hier=IIR
+104471  point: comment=(acc_res_rounded[61:54][7]==0) => 0 hier=IIR
+006075  point: comment=if hier=IIR
+101316  point: comment=(acc_res_rounded[61:54][0]==0 && acc_res_rounded[61:54][1]==0 && acc_res_rounded[61:54][2]==0 && acc_res_rounded[61:54][3]==0 && acc_res_rounded[61:54][4]==0 && acc_res_rounded[61:54][5]==0 && acc_res_rounded[61:54][6]==0 && acc_res_rounded[61:54][7]==0) => 0 hier=IIR
+062049  point: comment=(acc_res_rounded[61:54][0]==1) => 1 hier=IIR
+061730  point: comment=(acc_res_rounded[61:54][1]==1) => 1 hier=IIR
+061772  point: comment=(acc_res_rounded[61:54][2]==1) => 1 hier=IIR
+061772  point: comment=(acc_res_rounded[61:54][3]==1) => 1 hier=IIR
+061772  point: comment=(acc_res_rounded[61:54][4]==1) => 1 hier=IIR
+061772  point: comment=(acc_res_rounded[61:54][5]==1) => 1 hier=IIR
+061772  point: comment=(acc_res_rounded[61:54][6]==1) => 1 hier=IIR
+061772  point: comment=(acc_res_rounded[61:54][7]==1) => 1 hier=IIR
+160168  point: comment=else hier=IIR
 003155          if(acc_res_rounded[RES_ACC_WIDTH])
+002920  point: comment=if hier=IIR
+003155  point: comment=else hier=IIR
 002920            y  = {1'b1, {(DATA_WIDTH-1){1'b0}}};
+002920  point: comment=if hier=IIR
                 else
 003155            y  = {1'b0, {(DATA_WIDTH-1){1'b1}}};
+003155  point: comment=else hier=IIR
 160168       end else begin
+160168  point: comment=else hier=IIR
 160168          y = acc_res_rounded[FRAC_WIDTH+DATA_WIDTH-1:FRAC_WIDTH];
+160168  point: comment=else hier=IIR
              end
           end
        
           //Control part
 028786    always_ff @(posedge clk_i or negedge rst_i) begin : FSM
+028786  point: comment=block hier=IIR
 026148       if (~rst_i) begin
+002638  point: comment=(rst_i==0) => 1 hier=IIR
+026148  point: comment=(rst_i==1) => 0 hier=IIR
+002638  point: comment=if hier=IIR
+026148  point: comment=else hier=IIR
 002638          state <= IDLE;
+002638  point: comment=if hier=IIR
              end
 026148       else begin
+026148  point: comment=else hier=IIR
 026148          state <= next_state;         
+026148  point: comment=else hier=IIR
              end
           end  : FSM
        
 166243    always_comb begin
+166243  point: comment=block hier=IIR
              // Default assignments so not get latches
 166243       tap_en = '0;
+166243  point: comment=block hier=IIR
 166243       output_en = '0;      
+166243  point: comment=block hier=IIR
        
 166243       case(state)
+166243  point: comment=block hier=IIR
        
 062032         IDLE: begin
+062032  point: comment=case hier=IIR
 119609            if (valid_i == '1 && ready_and_o == '1) begin
+020272  point: comment=if hier=IIR
+041760  point: comment=else hier=IIR
+119609  point: comment=((ready_and_o == 1'h1)==0) => 0 hier=IIR
+041651  point: comment=((valid_i == 1'h1)==0) => 0 hier=IIR
+020272  point: comment=((valid_i == 1'h1)==1 && (ready_and_o == 1'h1)==1) => 1 hier=IIR
 020272               next_state = PROCESS; // A mealy state for maximum speed hanshake between valid/ready
+020272  point: comment=if hier=IIR
 020272               tap_en = '1;
+020272  point: comment=if hier=IIR
                   end
                   else
 041760              next_state = IDLE;             
+041760  point: comment=else hier=IIR
                end
                
 087256         PROCESS: begin
+087256  point: comment=case hier=IIR
 139640            if (process_done == 1'b1 && valid_o == 1'b0) // If there's an output traffic on the output it will stall the IP here
+017716  point: comment=if hier=IIR
+069540  point: comment=else hier=IIR
+139640  point: comment=((process_done == 1'h1)==0) => 0 hier=IIR
+018757  point: comment=((process_done == 1'h1)==1 && (valid_o == 1'h0)==1) => 1 hier=IIR
+053381  point: comment=((valid_o == 1'h0)==0) => 0 hier=IIR
 017716              next_state = STORE;
+017716  point: comment=if hier=IIR
                   else
 069540              next_state = PROCESS;             
+069540  point: comment=else hier=IIR
                end
        
 016955         STORE: begin
+016955  point: comment=case hier=IIR
 016955            output_en = '1;
+016955  point: comment=case hier=IIR
 016955            next_state = IDLE; 
+016955  point: comment=case hier=IIR
                   end
                // Turning coverage off cause this part is unreachable in simulation but necessary
                /* verilator coverage_off */
                default:
                  next_state = IDLE;
                /* verilator coverage_on */
              endcase
           end // always_comb
        
 028786    always_ff @(posedge clk_i or negedge rst_i) begin : VALID_O_READY_O
+028786  point: comment=block hier=IIR
 026148       if (~rst_i) begin
+002638  point: comment=(rst_i==0) => 1 hier=IIR
+026148  point: comment=(rst_i==1) => 0 hier=IIR
+002638  point: comment=if hier=IIR
+026148  point: comment=else hier=IIR
 002638          valid_o <= 1'b0;
+002638  point: comment=if hier=IIR
 002638          ready_and_o <= 1'b0;         
+002638  point: comment=if hier=IIR
              end
 026148       else begin
+026148  point: comment=else hier=IIR
 017373          if (valid_o & ready_and_i)
+002672  point: comment=elsif hier=IIR
+017373  point: comment=(ready_and_i==0) => 0 hier=IIR
+017368  point: comment=(valid_o==0) => 0 hier=IIR
+002672  point: comment=(valid_o==1 && ready_and_i==1) => 1 hier=IIR
 002672            valid_o <= 1'b0;
+002672  point: comment=elsif hier=IIR
 020505          else if ((state == STORE))
+002971  point: comment=if hier=IIR
+020505  point: comment=else hier=IIR
 002971            valid_o <= 1'b1;
+002971  point: comment=if hier=IIR
        
 017764          if (next_state == (IDLE) || ((next_state != PROCESS) && (state == (IDLE)))) begin 
+008384  point: comment=if hier=IIR
+017764  point: comment=else hier=IIR
+005413  point: comment=((next_state != PROCESS)==1 && (state == IDLE)==1) => 1 hier=IIR
+014672  point: comment=((next_state == IDLE)==0 && (next_state != PROCESS)==0) => 0 hier=IIR
+014182  point: comment=((next_state == IDLE)==0 && (state == IDLE)==0) => 0 hier=IIR
+008384  point: comment=((next_state == IDLE)==1) => 1 hier=IIR
 008384             ready_and_o <= '1;
+008384  point: comment=if hier=IIR
 017764          end else begin
+017764  point: comment=else hier=IIR
 017764             ready_and_o <= '0;    
+017764  point: comment=else hier=IIR
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
 007079          counter_t counter;
+007079  point: comment=genblk3.counter[0]:0->1 hier=IIR
+007075  point: comment=genblk3.counter[0]:1->0 hier=IIR
+004991  point: comment=genblk3.counter[1]:0->1 hier=IIR
+004990  point: comment=genblk3.counter[1]:1->0 hier=IIR
+000973  point: comment=genblk3.counter[2]:0->1 hier=IIR
+000973  point: comment=genblk3.counter[2]:1->0 hier=IIR
                 
 028267          always_ff @(posedge clk_i or negedge rst_i) begin : counter_reg
+028267  point: comment=block hier=IIR
 025705             if (~rst_i) begin
+002562  point: comment=elsif hier=IIR
+002562  point: comment=(rst_i==0) => 1 hier=IIR
+025705  point: comment=(rst_i==1) => 0 hier=IIR
 002562                counter = '0;         
+002562  point: comment=elsif hier=IIR
                    end
 013932             else if (state ==  PROCESS) begin
+013932  point: comment=if hier=IIR
+011773  point: comment=else hier=IIR
 013932                counter += 1'b1;         
+013932  point: comment=if hier=IIR
                    end else
 011773               counter = '0;      
+011773  point: comment=else hier=IIR
                 end  : counter_reg
        
 163210          always_comb begin
+163210  point: comment=block hier=IIR
 139640             if (counter == counter_t'(PROCESS_DELAY-2)) begin
+023570  point: comment=if hier=IIR
+139640  point: comment=else hier=IIR
 023570                process_done = '1;         
+023570  point: comment=if hier=IIR
                    end 
 139640             else begin
+139640  point: comment=else hier=IIR
 139640                process_done = '0;
+139640  point: comment=else hier=IIR
                    end
                 end
              end // else: !if(PROCESS_DELAY <= 2)
           endgenerate
           
        endmodule
        
