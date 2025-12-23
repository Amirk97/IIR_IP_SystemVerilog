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
 001083     input logic [DATA_WIDTH-1:0]         x_i,
+001042  point: comment=x_i[0]:0->1 hier=IIR
+001040  point: comment=x_i[0]:1->0 hier=IIR
+001048  point: comment=x_i[10]:0->1 hier=IIR
+001044  point: comment=x_i[10]:1->0 hier=IIR
+001054  point: comment=x_i[11]:0->1 hier=IIR
+001050  point: comment=x_i[11]:1->0 hier=IIR
+001083  point: comment=x_i[12]:0->1 hier=IIR
+001078  point: comment=x_i[12]:1->0 hier=IIR
+001024  point: comment=x_i[13]:0->1 hier=IIR
+001020  point: comment=x_i[13]:1->0 hier=IIR
+001072  point: comment=x_i[14]:0->1 hier=IIR
+001069  point: comment=x_i[14]:1->0 hier=IIR
+001027  point: comment=x_i[15]:0->1 hier=IIR
+001025  point: comment=x_i[15]:1->0 hier=IIR
+001026  point: comment=x_i[16]:0->1 hier=IIR
+001025  point: comment=x_i[16]:1->0 hier=IIR
+001068  point: comment=x_i[17]:0->1 hier=IIR
+001063  point: comment=x_i[17]:1->0 hier=IIR
+001040  point: comment=x_i[18]:0->1 hier=IIR
+001036  point: comment=x_i[18]:1->0 hier=IIR
+001036  point: comment=x_i[19]:0->1 hier=IIR
+001032  point: comment=x_i[19]:1->0 hier=IIR
+001057  point: comment=x_i[1]:0->1 hier=IIR
+001051  point: comment=x_i[1]:1->0 hier=IIR
+001044  point: comment=x_i[20]:0->1 hier=IIR
+001043  point: comment=x_i[20]:1->0 hier=IIR
+001054  point: comment=x_i[21]:0->1 hier=IIR
+001052  point: comment=x_i[21]:1->0 hier=IIR
+001056  point: comment=x_i[22]:0->1 hier=IIR
+001051  point: comment=x_i[22]:1->0 hier=IIR
+001077  point: comment=x_i[23]:0->1 hier=IIR
+001074  point: comment=x_i[23]:1->0 hier=IIR
+001068  point: comment=x_i[2]:0->1 hier=IIR
+001065  point: comment=x_i[2]:1->0 hier=IIR
+001053  point: comment=x_i[3]:0->1 hier=IIR
+001050  point: comment=x_i[3]:1->0 hier=IIR
+001064  point: comment=x_i[4]:0->1 hier=IIR
+001060  point: comment=x_i[4]:1->0 hier=IIR
+001066  point: comment=x_i[5]:0->1 hier=IIR
+001064  point: comment=x_i[5]:1->0 hier=IIR
+001032  point: comment=x_i[6]:0->1 hier=IIR
+001029  point: comment=x_i[6]:1->0 hier=IIR
+001056  point: comment=x_i[7]:0->1 hier=IIR
+001053  point: comment=x_i[7]:1->0 hier=IIR
+001039  point: comment=x_i[8]:0->1 hier=IIR
+001038  point: comment=x_i[8]:1->0 hier=IIR
+001060  point: comment=x_i[9]:0->1 hier=IIR
+001057  point: comment=x_i[9]:1->0 hier=IIR
 001027     output logic [DATA_WIDTH-1:0]        y_o,
+000988  point: comment=y_o[0]:0->1 hier=IIR
+000987  point: comment=y_o[0]:1->0 hier=IIR
+000987  point: comment=y_o[10]:0->1 hier=IIR
+000983  point: comment=y_o[10]:1->0 hier=IIR
+001003  point: comment=y_o[11]:0->1 hier=IIR
+001000  point: comment=y_o[11]:1->0 hier=IIR
+000997  point: comment=y_o[12]:0->1 hier=IIR
+000993  point: comment=y_o[12]:1->0 hier=IIR
+000952  point: comment=y_o[13]:0->1 hier=IIR
+000950  point: comment=y_o[13]:1->0 hier=IIR
+000959  point: comment=y_o[14]:0->1 hier=IIR
+000959  point: comment=y_o[14]:1->0 hier=IIR
+001005  point: comment=y_o[15]:0->1 hier=IIR
+001003  point: comment=y_o[15]:1->0 hier=IIR
+000979  point: comment=y_o[16]:0->1 hier=IIR
+000978  point: comment=y_o[16]:1->0 hier=IIR
+001011  point: comment=y_o[17]:0->1 hier=IIR
+001007  point: comment=y_o[17]:1->0 hier=IIR
+000978  point: comment=y_o[18]:0->1 hier=IIR
+000976  point: comment=y_o[18]:1->0 hier=IIR
+000990  point: comment=y_o[19]:0->1 hier=IIR
+000987  point: comment=y_o[19]:1->0 hier=IIR
+001014  point: comment=y_o[1]:0->1 hier=IIR
+001011  point: comment=y_o[1]:1->0 hier=IIR
+000984  point: comment=y_o[20]:0->1 hier=IIR
+000981  point: comment=y_o[20]:1->0 hier=IIR
+000989  point: comment=y_o[21]:0->1 hier=IIR
+000989  point: comment=y_o[21]:1->0 hier=IIR
+000978  point: comment=y_o[22]:0->1 hier=IIR
+000975  point: comment=y_o[22]:1->0 hier=IIR
+000994  point: comment=y_o[23]:0->1 hier=IIR
+000992  point: comment=y_o[23]:1->0 hier=IIR
+001027  point: comment=y_o[2]:0->1 hier=IIR
+001024  point: comment=y_o[2]:1->0 hier=IIR
+001018  point: comment=y_o[3]:0->1 hier=IIR
+001016  point: comment=y_o[3]:1->0 hier=IIR
+000992  point: comment=y_o[4]:0->1 hier=IIR
+000988  point: comment=y_o[4]:1->0 hier=IIR
+000992  point: comment=y_o[5]:0->1 hier=IIR
+000989  point: comment=y_o[5]:1->0 hier=IIR
+000988  point: comment=y_o[6]:0->1 hier=IIR
+000986  point: comment=y_o[6]:1->0 hier=IIR
+000993  point: comment=y_o[7]:0->1 hier=IIR
+000991  point: comment=y_o[7]:1->0 hier=IIR
+000979  point: comment=y_o[8]:0->1 hier=IIR
+000978  point: comment=y_o[8]:1->0 hier=IIR
+000986  point: comment=y_o[9]:0->1 hier=IIR
+000981  point: comment=y_o[9]:1->0 hier=IIR
            /* verilator coverage_off */
            // By purpose, coeffs are limited to finite sensible values
            input logic signed [COEFF_WIDTH-1:0] coeff_x_i [0:INPUT_TAPS-1], 
            input logic signed [COEFF_WIDTH-1:0] coeff_y_i [0:OUTPUT_TAPS-1], 
            /* verilator coverage_on */
 000909     input logic                          valid_i,
+000909  point: comment=valid_i:0->1 hier=IIR
+000903  point: comment=valid_i:1->0 hier=IIR
 004227     output logic                         ready_and_o,
+004227  point: comment=ready_and_o:0->1 hier=IIR
+004226  point: comment=ready_and_o:1->0 hier=IIR
        
 003453     output logic                         valid_o,
+003453  point: comment=valid_o:0->1 hier=IIR
+003452  point: comment=valid_o:1->0 hier=IIR
 003984     input logic                          ready_and_i,
+003984  point: comment=ready_and_i:0->1 hier=IIR
+003980  point: comment=ready_and_i:1->0 hier=IIR
        
 028851     input logic                          clk_i,
+028851  point: comment=clk_i:0->1 hier=IIR
+028851  point: comment=clk_i:1->0 hier=IIR
 000767     input logic                          reset_i);
+000767  point: comment=reset_i:0->1 hier=IIR
+000767  point: comment=reset_i:1->0 hier=IIR
           
 001138    logic signed [DATA_WIDTH-1:0] input_tap [0:INPUT_TAPS-1];
+001110  point: comment=input_tap[0][0]:0->1 hier=IIR
+001108  point: comment=input_tap[0][0]:1->0 hier=IIR
+001124  point: comment=input_tap[0][10]:0->1 hier=IIR
+001120  point: comment=input_tap[0][10]:1->0 hier=IIR
+001098  point: comment=input_tap[0][11]:0->1 hier=IIR
+001094  point: comment=input_tap[0][11]:1->0 hier=IIR
+001130  point: comment=input_tap[0][12]:0->1 hier=IIR
+001125  point: comment=input_tap[0][12]:1->0 hier=IIR
+001103  point: comment=input_tap[0][13]:0->1 hier=IIR
+001099  point: comment=input_tap[0][13]:1->0 hier=IIR
+001118  point: comment=input_tap[0][14]:0->1 hier=IIR
+001115  point: comment=input_tap[0][14]:1->0 hier=IIR
+001067  point: comment=input_tap[0][15]:0->1 hier=IIR
+001065  point: comment=input_tap[0][15]:1->0 hier=IIR
+001056  point: comment=input_tap[0][16]:0->1 hier=IIR
+001055  point: comment=input_tap[0][16]:1->0 hier=IIR
+001119  point: comment=input_tap[0][17]:0->1 hier=IIR
+001114  point: comment=input_tap[0][17]:1->0 hier=IIR
+001107  point: comment=input_tap[0][18]:0->1 hier=IIR
+001103  point: comment=input_tap[0][18]:1->0 hier=IIR
+001114  point: comment=input_tap[0][19]:0->1 hier=IIR
+001110  point: comment=input_tap[0][19]:1->0 hier=IIR
+001119  point: comment=input_tap[0][1]:0->1 hier=IIR
+001113  point: comment=input_tap[0][1]:1->0 hier=IIR
+001097  point: comment=input_tap[0][20]:0->1 hier=IIR
+001096  point: comment=input_tap[0][20]:1->0 hier=IIR
+001117  point: comment=input_tap[0][21]:0->1 hier=IIR
+001115  point: comment=input_tap[0][21]:1->0 hier=IIR
+001100  point: comment=input_tap[0][22]:0->1 hier=IIR
+001095  point: comment=input_tap[0][22]:1->0 hier=IIR
+001138  point: comment=input_tap[0][23]:0->1 hier=IIR
+001135  point: comment=input_tap[0][23]:1->0 hier=IIR
+001128  point: comment=input_tap[0][2]:0->1 hier=IIR
+001125  point: comment=input_tap[0][2]:1->0 hier=IIR
+001109  point: comment=input_tap[0][3]:0->1 hier=IIR
+001106  point: comment=input_tap[0][3]:1->0 hier=IIR
+001113  point: comment=input_tap[0][4]:0->1 hier=IIR
+001109  point: comment=input_tap[0][4]:1->0 hier=IIR
+001109  point: comment=input_tap[0][5]:0->1 hier=IIR
+001107  point: comment=input_tap[0][5]:1->0 hier=IIR
+001079  point: comment=input_tap[0][6]:0->1 hier=IIR
+001076  point: comment=input_tap[0][6]:1->0 hier=IIR
+001110  point: comment=input_tap[0][7]:0->1 hier=IIR
+001107  point: comment=input_tap[0][7]:1->0 hier=IIR
+001088  point: comment=input_tap[0][8]:0->1 hier=IIR
+001087  point: comment=input_tap[0][8]:1->0 hier=IIR
+001097  point: comment=input_tap[0][9]:0->1 hier=IIR
+001094  point: comment=input_tap[0][9]:1->0 hier=IIR
+000900  point: comment=input_tap[1][0]:0->1 hier=IIR
+000899  point: comment=input_tap[1][0]:1->0 hier=IIR
+000926  point: comment=input_tap[1][10]:0->1 hier=IIR
+000924  point: comment=input_tap[1][10]:1->0 hier=IIR
+000901  point: comment=input_tap[1][11]:0->1 hier=IIR
+000898  point: comment=input_tap[1][11]:1->0 hier=IIR
+000938  point: comment=input_tap[1][12]:0->1 hier=IIR
+000934  point: comment=input_tap[1][12]:1->0 hier=IIR
+000890  point: comment=input_tap[1][13]:0->1 hier=IIR
+000887  point: comment=input_tap[1][13]:1->0 hier=IIR
+000930  point: comment=input_tap[1][14]:0->1 hier=IIR
+000929  point: comment=input_tap[1][14]:1->0 hier=IIR
+000889  point: comment=input_tap[1][15]:0->1 hier=IIR
+000888  point: comment=input_tap[1][15]:1->0 hier=IIR
+000880  point: comment=input_tap[1][16]:0->1 hier=IIR
+000880  point: comment=input_tap[1][16]:1->0 hier=IIR
+000928  point: comment=input_tap[1][17]:0->1 hier=IIR
+000925  point: comment=input_tap[1][17]:1->0 hier=IIR
+000906  point: comment=input_tap[1][18]:0->1 hier=IIR
+000903  point: comment=input_tap[1][18]:1->0 hier=IIR
+000903  point: comment=input_tap[1][19]:0->1 hier=IIR
+000899  point: comment=input_tap[1][19]:1->0 hier=IIR
+000925  point: comment=input_tap[1][1]:0->1 hier=IIR
+000921  point: comment=input_tap[1][1]:1->0 hier=IIR
+000919  point: comment=input_tap[1][20]:0->1 hier=IIR
+000918  point: comment=input_tap[1][20]:1->0 hier=IIR
+000911  point: comment=input_tap[1][21]:0->1 hier=IIR
+000909  point: comment=input_tap[1][21]:1->0 hier=IIR
+000899  point: comment=input_tap[1][22]:0->1 hier=IIR
+000895  point: comment=input_tap[1][22]:1->0 hier=IIR
+000944  point: comment=input_tap[1][23]:0->1 hier=IIR
+000941  point: comment=input_tap[1][23]:1->0 hier=IIR
+000924  point: comment=input_tap[1][2]:0->1 hier=IIR
+000922  point: comment=input_tap[1][2]:1->0 hier=IIR
+000911  point: comment=input_tap[1][3]:0->1 hier=IIR
+000909  point: comment=input_tap[1][3]:1->0 hier=IIR
+000924  point: comment=input_tap[1][4]:0->1 hier=IIR
+000921  point: comment=input_tap[1][4]:1->0 hier=IIR
+000901  point: comment=input_tap[1][5]:0->1 hier=IIR
+000900  point: comment=input_tap[1][5]:1->0 hier=IIR
+000877  point: comment=input_tap[1][6]:0->1 hier=IIR
+000874  point: comment=input_tap[1][6]:1->0 hier=IIR
+000925  point: comment=input_tap[1][7]:0->1 hier=IIR
+000923  point: comment=input_tap[1][7]:1->0 hier=IIR
+000909  point: comment=input_tap[1][8]:0->1 hier=IIR
+000908  point: comment=input_tap[1][8]:1->0 hier=IIR
+000933  point: comment=input_tap[1][9]:0->1 hier=IIR
+000932  point: comment=input_tap[1][9]:1->0 hier=IIR
+000757  point: comment=input_tap[2][0]:0->1 hier=IIR
+000755  point: comment=input_tap[2][0]:1->0 hier=IIR
+000781  point: comment=input_tap[2][10]:0->1 hier=IIR
+000778  point: comment=input_tap[2][10]:1->0 hier=IIR
+000750  point: comment=input_tap[2][11]:0->1 hier=IIR
+000748  point: comment=input_tap[2][11]:1->0 hier=IIR
+000801  point: comment=input_tap[2][12]:0->1 hier=IIR
+000799  point: comment=input_tap[2][12]:1->0 hier=IIR
+000754  point: comment=input_tap[2][13]:0->1 hier=IIR
+000752  point: comment=input_tap[2][13]:1->0 hier=IIR
+000787  point: comment=input_tap[2][14]:0->1 hier=IIR
+000785  point: comment=input_tap[2][14]:1->0 hier=IIR
+000750  point: comment=input_tap[2][15]:0->1 hier=IIR
+000749  point: comment=input_tap[2][15]:1->0 hier=IIR
+000738  point: comment=input_tap[2][16]:0->1 hier=IIR
+000737  point: comment=input_tap[2][16]:1->0 hier=IIR
+000767  point: comment=input_tap[2][17]:0->1 hier=IIR
+000764  point: comment=input_tap[2][17]:1->0 hier=IIR
+000771  point: comment=input_tap[2][18]:0->1 hier=IIR
+000768  point: comment=input_tap[2][18]:1->0 hier=IIR
+000753  point: comment=input_tap[2][19]:0->1 hier=IIR
+000751  point: comment=input_tap[2][19]:1->0 hier=IIR
+000768  point: comment=input_tap[2][1]:0->1 hier=IIR
+000766  point: comment=input_tap[2][1]:1->0 hier=IIR
+000775  point: comment=input_tap[2][20]:0->1 hier=IIR
+000773  point: comment=input_tap[2][20]:1->0 hier=IIR
+000767  point: comment=input_tap[2][21]:0->1 hier=IIR
+000765  point: comment=input_tap[2][21]:1->0 hier=IIR
+000753  point: comment=input_tap[2][22]:0->1 hier=IIR
+000750  point: comment=input_tap[2][22]:1->0 hier=IIR
+000791  point: comment=input_tap[2][23]:0->1 hier=IIR
+000787  point: comment=input_tap[2][23]:1->0 hier=IIR
+000777  point: comment=input_tap[2][2]:0->1 hier=IIR
+000775  point: comment=input_tap[2][2]:1->0 hier=IIR
+000772  point: comment=input_tap[2][3]:0->1 hier=IIR
+000769  point: comment=input_tap[2][3]:1->0 hier=IIR
+000774  point: comment=input_tap[2][4]:0->1 hier=IIR
+000771  point: comment=input_tap[2][4]:1->0 hier=IIR
+000774  point: comment=input_tap[2][5]:0->1 hier=IIR
+000772  point: comment=input_tap[2][5]:1->0 hier=IIR
+000748  point: comment=input_tap[2][6]:0->1 hier=IIR
+000746  point: comment=input_tap[2][6]:1->0 hier=IIR
+000769  point: comment=input_tap[2][7]:0->1 hier=IIR
+000769  point: comment=input_tap[2][7]:1->0 hier=IIR
+000761  point: comment=input_tap[2][8]:0->1 hier=IIR
+000759  point: comment=input_tap[2][8]:1->0 hier=IIR
+000784  point: comment=input_tap[2][9]:0->1 hier=IIR
+000782  point: comment=input_tap[2][9]:1->0 hier=IIR
 000939    logic signed [DATA_WIDTH-1:0] output_tap [0:OUTPUT_TAPS-1];
+000907  point: comment=output_tap[0][0]:0->1 hier=IIR
+000906  point: comment=output_tap[0][0]:1->0 hier=IIR
+000909  point: comment=output_tap[0][10]:0->1 hier=IIR
+000906  point: comment=output_tap[0][10]:1->0 hier=IIR
+000923  point: comment=output_tap[0][11]:0->1 hier=IIR
+000921  point: comment=output_tap[0][11]:1->0 hier=IIR
+000906  point: comment=output_tap[0][12]:0->1 hier=IIR
+000903  point: comment=output_tap[0][12]:1->0 hier=IIR
+000879  point: comment=output_tap[0][13]:0->1 hier=IIR
+000878  point: comment=output_tap[0][13]:1->0 hier=IIR
+000888  point: comment=output_tap[0][14]:0->1 hier=IIR
+000888  point: comment=output_tap[0][14]:1->0 hier=IIR
+000923  point: comment=output_tap[0][15]:0->1 hier=IIR
+000922  point: comment=output_tap[0][15]:1->0 hier=IIR
+000894  point: comment=output_tap[0][16]:0->1 hier=IIR
+000893  point: comment=output_tap[0][16]:1->0 hier=IIR
+000922  point: comment=output_tap[0][17]:0->1 hier=IIR
+000919  point: comment=output_tap[0][17]:1->0 hier=IIR
+000881  point: comment=output_tap[0][18]:0->1 hier=IIR
+000879  point: comment=output_tap[0][18]:1->0 hier=IIR
+000903  point: comment=output_tap[0][19]:0->1 hier=IIR
+000900  point: comment=output_tap[0][19]:1->0 hier=IIR
+000926  point: comment=output_tap[0][1]:0->1 hier=IIR
+000924  point: comment=output_tap[0][1]:1->0 hier=IIR
+000909  point: comment=output_tap[0][20]:0->1 hier=IIR
+000906  point: comment=output_tap[0][20]:1->0 hier=IIR
+000904  point: comment=output_tap[0][21]:0->1 hier=IIR
+000904  point: comment=output_tap[0][21]:1->0 hier=IIR
+000892  point: comment=output_tap[0][22]:0->1 hier=IIR
+000889  point: comment=output_tap[0][22]:1->0 hier=IIR
+000914  point: comment=output_tap[0][23]:0->1 hier=IIR
+000912  point: comment=output_tap[0][23]:1->0 hier=IIR
+000939  point: comment=output_tap[0][2]:0->1 hier=IIR
+000936  point: comment=output_tap[0][2]:1->0 hier=IIR
+000933  point: comment=output_tap[0][3]:0->1 hier=IIR
+000931  point: comment=output_tap[0][3]:1->0 hier=IIR
+000899  point: comment=output_tap[0][4]:0->1 hier=IIR
+000896  point: comment=output_tap[0][4]:1->0 hier=IIR
+000899  point: comment=output_tap[0][5]:0->1 hier=IIR
+000897  point: comment=output_tap[0][5]:1->0 hier=IIR
+000917  point: comment=output_tap[0][6]:0->1 hier=IIR
+000915  point: comment=output_tap[0][6]:1->0 hier=IIR
+000913  point: comment=output_tap[0][7]:0->1 hier=IIR
+000911  point: comment=output_tap[0][7]:1->0 hier=IIR
+000897  point: comment=output_tap[0][8]:0->1 hier=IIR
+000897  point: comment=output_tap[0][8]:1->0 hier=IIR
+000906  point: comment=output_tap[0][9]:0->1 hier=IIR
+000902  point: comment=output_tap[0][9]:1->0 hier=IIR
+000763  point: comment=output_tap[1][0]:0->1 hier=IIR
+000761  point: comment=output_tap[1][0]:1->0 hier=IIR
+000761  point: comment=output_tap[1][10]:0->1 hier=IIR
+000759  point: comment=output_tap[1][10]:1->0 hier=IIR
+000780  point: comment=output_tap[1][11]:0->1 hier=IIR
+000778  point: comment=output_tap[1][11]:1->0 hier=IIR
+000760  point: comment=output_tap[1][12]:0->1 hier=IIR
+000757  point: comment=output_tap[1][12]:1->0 hier=IIR
+000732  point: comment=output_tap[1][13]:0->1 hier=IIR
+000730  point: comment=output_tap[1][13]:1->0 hier=IIR
+000753  point: comment=output_tap[1][14]:0->1 hier=IIR
+000752  point: comment=output_tap[1][14]:1->0 hier=IIR
+000787  point: comment=output_tap[1][15]:0->1 hier=IIR
+000786  point: comment=output_tap[1][15]:1->0 hier=IIR
+000760  point: comment=output_tap[1][16]:0->1 hier=IIR
+000760  point: comment=output_tap[1][16]:1->0 hier=IIR
+000759  point: comment=output_tap[1][17]:0->1 hier=IIR
+000758  point: comment=output_tap[1][17]:1->0 hier=IIR
+000748  point: comment=output_tap[1][18]:0->1 hier=IIR
+000745  point: comment=output_tap[1][18]:1->0 hier=IIR
+000761  point: comment=output_tap[1][19]:0->1 hier=IIR
+000760  point: comment=output_tap[1][19]:1->0 hier=IIR
+000775  point: comment=output_tap[1][1]:0->1 hier=IIR
+000773  point: comment=output_tap[1][1]:1->0 hier=IIR
+000769  point: comment=output_tap[1][20]:0->1 hier=IIR
+000767  point: comment=output_tap[1][20]:1->0 hier=IIR
+000763  point: comment=output_tap[1][21]:0->1 hier=IIR
+000762  point: comment=output_tap[1][21]:1->0 hier=IIR
+000745  point: comment=output_tap[1][22]:0->1 hier=IIR
+000743  point: comment=output_tap[1][22]:1->0 hier=IIR
+000763  point: comment=output_tap[1][23]:0->1 hier=IIR
+000760  point: comment=output_tap[1][23]:1->0 hier=IIR
+000779  point: comment=output_tap[1][2]:0->1 hier=IIR
+000777  point: comment=output_tap[1][2]:1->0 hier=IIR
+000774  point: comment=output_tap[1][3]:0->1 hier=IIR
+000772  point: comment=output_tap[1][3]:1->0 hier=IIR
+000748  point: comment=output_tap[1][4]:0->1 hier=IIR
+000745  point: comment=output_tap[1][4]:1->0 hier=IIR
+000752  point: comment=output_tap[1][5]:0->1 hier=IIR
+000749  point: comment=output_tap[1][5]:1->0 hier=IIR
+000767  point: comment=output_tap[1][6]:0->1 hier=IIR
+000765  point: comment=output_tap[1][6]:1->0 hier=IIR
+000768  point: comment=output_tap[1][7]:0->1 hier=IIR
+000766  point: comment=output_tap[1][7]:1->0 hier=IIR
+000762  point: comment=output_tap[1][8]:0->1 hier=IIR
+000761  point: comment=output_tap[1][8]:1->0 hier=IIR
+000749  point: comment=output_tap[1][9]:0->1 hier=IIR
+000746  point: comment=output_tap[1][9]:1->0 hier=IIR
        
           /* verilator coverage_off */
           // By purpose, coeffs are limited to finite sensible values
           logic signed [COEFF_WIDTH-1:0] coeff_x [0:INPUT_TAPS-1];      
           logic signed [COEFF_WIDTH-1:0] coeff_y [0:OUTPUT_TAPS-1];
           /* verilator coverage_on */
        
 001141    logic signed [MULTIPLY_WIDTH:0] multi_prod_x [0:INPUT_TAPS-1];
+000777  point: comment=multi_prod_x[0][0]:0->1 hier=IIR
+000775  point: comment=multi_prod_x[0][0]:1->0 hier=IIR
+001053  point: comment=multi_prod_x[0][10]:0->1 hier=IIR
+001052  point: comment=multi_prod_x[0][10]:1->0 hier=IIR
+001077  point: comment=multi_prod_x[0][11]:0->1 hier=IIR
+001072  point: comment=multi_prod_x[0][11]:1->0 hier=IIR
+001036  point: comment=multi_prod_x[0][12]:0->1 hier=IIR
+001031  point: comment=multi_prod_x[0][12]:1->0 hier=IIR
+001066  point: comment=multi_prod_x[0][13]:0->1 hier=IIR
+001065  point: comment=multi_prod_x[0][13]:1->0 hier=IIR
+001072  point: comment=multi_prod_x[0][14]:0->1 hier=IIR
+001070  point: comment=multi_prod_x[0][14]:1->0 hier=IIR
+001051  point: comment=multi_prod_x[0][15]:0->1 hier=IIR
+001049  point: comment=multi_prod_x[0][15]:1->0 hier=IIR
+001073  point: comment=multi_prod_x[0][16]:0->1 hier=IIR
+001069  point: comment=multi_prod_x[0][16]:1->0 hier=IIR
+001027  point: comment=multi_prod_x[0][17]:0->1 hier=IIR
+001024  point: comment=multi_prod_x[0][17]:1->0 hier=IIR
+001046  point: comment=multi_prod_x[0][18]:0->1 hier=IIR
+001046  point: comment=multi_prod_x[0][18]:1->0 hier=IIR
+001051  point: comment=multi_prod_x[0][19]:0->1 hier=IIR
+001048  point: comment=multi_prod_x[0][19]:1->0 hier=IIR
+000894  point: comment=multi_prod_x[0][1]:0->1 hier=IIR
+000892  point: comment=multi_prod_x[0][1]:1->0 hier=IIR
+001054  point: comment=multi_prod_x[0][20]:0->1 hier=IIR
+001053  point: comment=multi_prod_x[0][20]:1->0 hier=IIR
+001017  point: comment=multi_prod_x[0][21]:0->1 hier=IIR
+001013  point: comment=multi_prod_x[0][21]:1->0 hier=IIR
+001010  point: comment=multi_prod_x[0][22]:0->1 hier=IIR
+001009  point: comment=multi_prod_x[0][22]:1->0 hier=IIR
+001042  point: comment=multi_prod_x[0][23]:0->1 hier=IIR
+001041  point: comment=multi_prod_x[0][23]:1->0 hier=IIR
+001052  point: comment=multi_prod_x[0][24]:0->1 hier=IIR
+001049  point: comment=multi_prod_x[0][24]:1->0 hier=IIR
+001061  point: comment=multi_prod_x[0][25]:0->1 hier=IIR
+001056  point: comment=multi_prod_x[0][25]:1->0 hier=IIR
+001072  point: comment=multi_prod_x[0][26]:0->1 hier=IIR
+001067  point: comment=multi_prod_x[0][26]:1->0 hier=IIR
+001049  point: comment=multi_prod_x[0][27]:0->1 hier=IIR
+001046  point: comment=multi_prod_x[0][27]:1->0 hier=IIR
+001037  point: comment=multi_prod_x[0][28]:0->1 hier=IIR
+001037  point: comment=multi_prod_x[0][28]:1->0 hier=IIR
+001054  point: comment=multi_prod_x[0][29]:0->1 hier=IIR
+001052  point: comment=multi_prod_x[0][29]:1->0 hier=IIR
+000990  point: comment=multi_prod_x[0][2]:0->1 hier=IIR
+000987  point: comment=multi_prod_x[0][2]:1->0 hier=IIR
+001032  point: comment=multi_prod_x[0][30]:0->1 hier=IIR
+001030  point: comment=multi_prod_x[0][30]:1->0 hier=IIR
+001103  point: comment=multi_prod_x[0][31]:0->1 hier=IIR
+001100  point: comment=multi_prod_x[0][31]:1->0 hier=IIR
+001093  point: comment=multi_prod_x[0][32]:0->1 hier=IIR
+001086  point: comment=multi_prod_x[0][32]:1->0 hier=IIR
+001074  point: comment=multi_prod_x[0][33]:0->1 hier=IIR
+001072  point: comment=multi_prod_x[0][33]:1->0 hier=IIR
+001141  point: comment=multi_prod_x[0][34]:0->1 hier=IIR
+001137  point: comment=multi_prod_x[0][34]:1->0 hier=IIR
+001099  point: comment=multi_prod_x[0][35]:0->1 hier=IIR
+001095  point: comment=multi_prod_x[0][35]:1->0 hier=IIR
+001086  point: comment=multi_prod_x[0][36]:0->1 hier=IIR
+001083  point: comment=multi_prod_x[0][36]:1->0 hier=IIR
+001108  point: comment=multi_prod_x[0][37]:0->1 hier=IIR
+001105  point: comment=multi_prod_x[0][37]:1->0 hier=IIR
+001105  point: comment=multi_prod_x[0][38]:0->1 hier=IIR
+001104  point: comment=multi_prod_x[0][38]:1->0 hier=IIR
+001093  point: comment=multi_prod_x[0][39]:0->1 hier=IIR
+001090  point: comment=multi_prod_x[0][39]:1->0 hier=IIR
+001030  point: comment=multi_prod_x[0][3]:0->1 hier=IIR
+001028  point: comment=multi_prod_x[0][3]:1->0 hier=IIR
+001097  point: comment=multi_prod_x[0][40]:0->1 hier=IIR
+001092  point: comment=multi_prod_x[0][40]:1->0 hier=IIR
+001081  point: comment=multi_prod_x[0][41]:0->1 hier=IIR
+001074  point: comment=multi_prod_x[0][41]:1->0 hier=IIR
+001103  point: comment=multi_prod_x[0][42]:0->1 hier=IIR
+001098  point: comment=multi_prod_x[0][42]:1->0 hier=IIR
+001127  point: comment=multi_prod_x[0][43]:0->1 hier=IIR
+001122  point: comment=multi_prod_x[0][43]:1->0 hier=IIR
+001075  point: comment=multi_prod_x[0][44]:0->1 hier=IIR
+001072  point: comment=multi_prod_x[0][44]:1->0 hier=IIR
+001084  point: comment=multi_prod_x[0][45]:0->1 hier=IIR
+001082  point: comment=multi_prod_x[0][45]:1->0 hier=IIR
+001106  point: comment=multi_prod_x[0][46]:0->1 hier=IIR
+001103  point: comment=multi_prod_x[0][46]:1->0 hier=IIR
+001092  point: comment=multi_prod_x[0][47]:0->1 hier=IIR
+001088  point: comment=multi_prod_x[0][47]:1->0 hier=IIR
+001088  point: comment=multi_prod_x[0][48]:0->1 hier=IIR
+001081  point: comment=multi_prod_x[0][48]:1->0 hier=IIR
+001117  point: comment=multi_prod_x[0][49]:0->1 hier=IIR
+001113  point: comment=multi_prod_x[0][49]:1->0 hier=IIR
+001034  point: comment=multi_prod_x[0][4]:0->1 hier=IIR
+001032  point: comment=multi_prod_x[0][4]:1->0 hier=IIR
+001117  point: comment=multi_prod_x[0][50]:0->1 hier=IIR
+001112  point: comment=multi_prod_x[0][50]:1->0 hier=IIR
+001096  point: comment=multi_prod_x[0][51]:0->1 hier=IIR
+001094  point: comment=multi_prod_x[0][51]:1->0 hier=IIR
+001114  point: comment=multi_prod_x[0][52]:0->1 hier=IIR
+001111  point: comment=multi_prod_x[0][52]:1->0 hier=IIR
+001095  point: comment=multi_prod_x[0][53]:0->1 hier=IIR
+001089  point: comment=multi_prod_x[0][53]:1->0 hier=IIR
+001137  point: comment=multi_prod_x[0][54]:0->1 hier=IIR
+001135  point: comment=multi_prod_x[0][54]:1->0 hier=IIR
+001138  point: comment=multi_prod_x[0][55]:0->1 hier=IIR
+001135  point: comment=multi_prod_x[0][55]:1->0 hier=IIR
+001138  point: comment=multi_prod_x[0][56]:0->1 hier=IIR
+001135  point: comment=multi_prod_x[0][56]:1->0 hier=IIR
+001138  point: comment=multi_prod_x[0][57]:0->1 hier=IIR
+001135  point: comment=multi_prod_x[0][57]:1->0 hier=IIR
+001049  point: comment=multi_prod_x[0][5]:0->1 hier=IIR
+001049  point: comment=multi_prod_x[0][5]:1->0 hier=IIR
+001060  point: comment=multi_prod_x[0][6]:0->1 hier=IIR
+001056  point: comment=multi_prod_x[0][6]:1->0 hier=IIR
+001051  point: comment=multi_prod_x[0][7]:0->1 hier=IIR
+001050  point: comment=multi_prod_x[0][7]:1->0 hier=IIR
+001027  point: comment=multi_prod_x[0][8]:0->1 hier=IIR
+001026  point: comment=multi_prod_x[0][8]:1->0 hier=IIR
+001044  point: comment=multi_prod_x[0][9]:0->1 hier=IIR
+001043  point: comment=multi_prod_x[0][9]:1->0 hier=IIR
+000379  point: comment=multi_prod_x[1][0]:0->1 hier=IIR
+000378  point: comment=multi_prod_x[1][0]:1->0 hier=IIR
+000899  point: comment=multi_prod_x[1][10]:0->1 hier=IIR
+000898  point: comment=multi_prod_x[1][10]:1->0 hier=IIR
+000890  point: comment=multi_prod_x[1][11]:0->1 hier=IIR
+000889  point: comment=multi_prod_x[1][11]:1->0 hier=IIR
+000928  point: comment=multi_prod_x[1][12]:0->1 hier=IIR
+000927  point: comment=multi_prod_x[1][12]:1->0 hier=IIR
+000872  point: comment=multi_prod_x[1][13]:0->1 hier=IIR
+000872  point: comment=multi_prod_x[1][13]:1->0 hier=IIR
+000931  point: comment=multi_prod_x[1][14]:0->1 hier=IIR
+000929  point: comment=multi_prod_x[1][14]:1->0 hier=IIR
+000916  point: comment=multi_prod_x[1][15]:0->1 hier=IIR
+000914  point: comment=multi_prod_x[1][15]:1->0 hier=IIR
+000870  point: comment=multi_prod_x[1][16]:0->1 hier=IIR
+000869  point: comment=multi_prod_x[1][16]:1->0 hier=IIR
+000924  point: comment=multi_prod_x[1][17]:0->1 hier=IIR
+000922  point: comment=multi_prod_x[1][17]:1->0 hier=IIR
+000917  point: comment=multi_prod_x[1][18]:0->1 hier=IIR
+000916  point: comment=multi_prod_x[1][18]:1->0 hier=IIR
+000924  point: comment=multi_prod_x[1][19]:0->1 hier=IIR
+000922  point: comment=multi_prod_x[1][19]:1->0 hier=IIR
+000610  point: comment=multi_prod_x[1][1]:0->1 hier=IIR
+000607  point: comment=multi_prod_x[1][1]:1->0 hier=IIR
+000945  point: comment=multi_prod_x[1][20]:0->1 hier=IIR
+000942  point: comment=multi_prod_x[1][20]:1->0 hier=IIR
+000884  point: comment=multi_prod_x[1][21]:0->1 hier=IIR
+000883  point: comment=multi_prod_x[1][21]:1->0 hier=IIR
+000914  point: comment=multi_prod_x[1][22]:0->1 hier=IIR
+000913  point: comment=multi_prod_x[1][22]:1->0 hier=IIR
+000898  point: comment=multi_prod_x[1][23]:0->1 hier=IIR
+000898  point: comment=multi_prod_x[1][23]:1->0 hier=IIR
+000886  point: comment=multi_prod_x[1][24]:0->1 hier=IIR
+000885  point: comment=multi_prod_x[1][24]:1->0 hier=IIR
+000895  point: comment=multi_prod_x[1][25]:0->1 hier=IIR
+000894  point: comment=multi_prod_x[1][25]:1->0 hier=IIR
+000943  point: comment=multi_prod_x[1][26]:0->1 hier=IIR
+000938  point: comment=multi_prod_x[1][26]:1->0 hier=IIR
+000904  point: comment=multi_prod_x[1][27]:0->1 hier=IIR
+000901  point: comment=multi_prod_x[1][27]:1->0 hier=IIR
+000895  point: comment=multi_prod_x[1][28]:0->1 hier=IIR
+000894  point: comment=multi_prod_x[1][28]:1->0 hier=IIR
+000890  point: comment=multi_prod_x[1][29]:0->1 hier=IIR
+000888  point: comment=multi_prod_x[1][29]:1->0 hier=IIR
+000759  point: comment=multi_prod_x[1][2]:0->1 hier=IIR
+000757  point: comment=multi_prod_x[1][2]:1->0 hier=IIR
+000897  point: comment=multi_prod_x[1][30]:0->1 hier=IIR
+000897  point: comment=multi_prod_x[1][30]:1->0 hier=IIR
+000894  point: comment=multi_prod_x[1][31]:0->1 hier=IIR
+000894  point: comment=multi_prod_x[1][31]:1->0 hier=IIR
+000917  point: comment=multi_prod_x[1][32]:0->1 hier=IIR
+000913  point: comment=multi_prod_x[1][32]:1->0 hier=IIR
+000911  point: comment=multi_prod_x[1][33]:0->1 hier=IIR
+000907  point: comment=multi_prod_x[1][33]:1->0 hier=IIR
+000952  point: comment=multi_prod_x[1][34]:0->1 hier=IIR
+000949  point: comment=multi_prod_x[1][34]:1->0 hier=IIR
+000903  point: comment=multi_prod_x[1][35]:0->1 hier=IIR
+000901  point: comment=multi_prod_x[1][35]:1->0 hier=IIR
+000913  point: comment=multi_prod_x[1][36]:0->1 hier=IIR
+000911  point: comment=multi_prod_x[1][36]:1->0 hier=IIR
+000919  point: comment=multi_prod_x[1][37]:0->1 hier=IIR
+000916  point: comment=multi_prod_x[1][37]:1->0 hier=IIR
+000881  point: comment=multi_prod_x[1][38]:0->1 hier=IIR
+000880  point: comment=multi_prod_x[1][38]:1->0 hier=IIR
+000913  point: comment=multi_prod_x[1][39]:0->1 hier=IIR
+000911  point: comment=multi_prod_x[1][39]:1->0 hier=IIR
+000814  point: comment=multi_prod_x[1][3]:0->1 hier=IIR
+000811  point: comment=multi_prod_x[1][3]:1->0 hier=IIR
+000904  point: comment=multi_prod_x[1][40]:0->1 hier=IIR
+000900  point: comment=multi_prod_x[1][40]:1->0 hier=IIR
+000928  point: comment=multi_prod_x[1][41]:0->1 hier=IIR
+000927  point: comment=multi_prod_x[1][41]:1->0 hier=IIR
+000933  point: comment=multi_prod_x[1][42]:0->1 hier=IIR
+000928  point: comment=multi_prod_x[1][42]:1->0 hier=IIR
+000908  point: comment=multi_prod_x[1][43]:0->1 hier=IIR
+000904  point: comment=multi_prod_x[1][43]:1->0 hier=IIR
+000923  point: comment=multi_prod_x[1][44]:0->1 hier=IIR
+000921  point: comment=multi_prod_x[1][44]:1->0 hier=IIR
+000904  point: comment=multi_prod_x[1][45]:0->1 hier=IIR
+000901  point: comment=multi_prod_x[1][45]:1->0 hier=IIR
+000914  point: comment=multi_prod_x[1][46]:0->1 hier=IIR
+000910  point: comment=multi_prod_x[1][46]:1->0 hier=IIR
+000927  point: comment=multi_prod_x[1][47]:0->1 hier=IIR
+000925  point: comment=multi_prod_x[1][47]:1->0 hier=IIR
+000902  point: comment=multi_prod_x[1][48]:0->1 hier=IIR
+000900  point: comment=multi_prod_x[1][48]:1->0 hier=IIR
+000933  point: comment=multi_prod_x[1][49]:0->1 hier=IIR
+000931  point: comment=multi_prod_x[1][49]:1->0 hier=IIR
+000825  point: comment=multi_prod_x[1][4]:0->1 hier=IIR
+000823  point: comment=multi_prod_x[1][4]:1->0 hier=IIR
+000924  point: comment=multi_prod_x[1][50]:0->1 hier=IIR
+000921  point: comment=multi_prod_x[1][50]:1->0 hier=IIR
+000896  point: comment=multi_prod_x[1][51]:0->1 hier=IIR
+000893  point: comment=multi_prod_x[1][51]:1->0 hier=IIR
+000874  point: comment=multi_prod_x[1][52]:0->1 hier=IIR
+000871  point: comment=multi_prod_x[1][52]:1->0 hier=IIR
+000932  point: comment=multi_prod_x[1][53]:0->1 hier=IIR
+000929  point: comment=multi_prod_x[1][53]:1->0 hier=IIR
+000917  point: comment=multi_prod_x[1][54]:0->1 hier=IIR
+000916  point: comment=multi_prod_x[1][54]:1->0 hier=IIR
+000929  point: comment=multi_prod_x[1][55]:0->1 hier=IIR
+000927  point: comment=multi_prod_x[1][55]:1->0 hier=IIR
+000929  point: comment=multi_prod_x[1][56]:0->1 hier=IIR
+000927  point: comment=multi_prod_x[1][56]:1->0 hier=IIR
+000929  point: comment=multi_prod_x[1][57]:0->1 hier=IIR
+000927  point: comment=multi_prod_x[1][57]:1->0 hier=IIR
+000847  point: comment=multi_prod_x[1][5]:0->1 hier=IIR
+000844  point: comment=multi_prod_x[1][5]:1->0 hier=IIR
+000864  point: comment=multi_prod_x[1][6]:0->1 hier=IIR
+000860  point: comment=multi_prod_x[1][6]:1->0 hier=IIR
+000908  point: comment=multi_prod_x[1][7]:0->1 hier=IIR
+000906  point: comment=multi_prod_x[1][7]:1->0 hier=IIR
+000889  point: comment=multi_prod_x[1][8]:0->1 hier=IIR
+000887  point: comment=multi_prod_x[1][8]:1->0 hier=IIR
+000911  point: comment=multi_prod_x[1][9]:0->1 hier=IIR
+000908  point: comment=multi_prod_x[1][9]:1->0 hier=IIR
+000225  point: comment=multi_prod_x[2][0]:0->1 hier=IIR
+000223  point: comment=multi_prod_x[2][0]:1->0 hier=IIR
+000788  point: comment=multi_prod_x[2][10]:0->1 hier=IIR
+000786  point: comment=multi_prod_x[2][10]:1->0 hier=IIR
+000757  point: comment=multi_prod_x[2][11]:0->1 hier=IIR
+000756  point: comment=multi_prod_x[2][11]:1->0 hier=IIR
+000749  point: comment=multi_prod_x[2][12]:0->1 hier=IIR
+000746  point: comment=multi_prod_x[2][12]:1->0 hier=IIR
+000755  point: comment=multi_prod_x[2][13]:0->1 hier=IIR
+000752  point: comment=multi_prod_x[2][13]:1->0 hier=IIR
+000771  point: comment=multi_prod_x[2][14]:0->1 hier=IIR
+000769  point: comment=multi_prod_x[2][14]:1->0 hier=IIR
+000765  point: comment=multi_prod_x[2][15]:0->1 hier=IIR
+000762  point: comment=multi_prod_x[2][15]:1->0 hier=IIR
+000762  point: comment=multi_prod_x[2][16]:0->1 hier=IIR
+000760  point: comment=multi_prod_x[2][16]:1->0 hier=IIR
+000753  point: comment=multi_prod_x[2][17]:0->1 hier=IIR
+000751  point: comment=multi_prod_x[2][17]:1->0 hier=IIR
+000753  point: comment=multi_prod_x[2][18]:0->1 hier=IIR
+000751  point: comment=multi_prod_x[2][18]:1->0 hier=IIR
+000765  point: comment=multi_prod_x[2][19]:0->1 hier=IIR
+000763  point: comment=multi_prod_x[2][19]:1->0 hier=IIR
+000525  point: comment=multi_prod_x[2][1]:0->1 hier=IIR
+000524  point: comment=multi_prod_x[2][1]:1->0 hier=IIR
+000791  point: comment=multi_prod_x[2][20]:0->1 hier=IIR
+000788  point: comment=multi_prod_x[2][20]:1->0 hier=IIR
+000754  point: comment=multi_prod_x[2][21]:0->1 hier=IIR
+000752  point: comment=multi_prod_x[2][21]:1->0 hier=IIR
+000757  point: comment=multi_prod_x[2][22]:0->1 hier=IIR
+000755  point: comment=multi_prod_x[2][22]:1->0 hier=IIR
+000752  point: comment=multi_prod_x[2][23]:0->1 hier=IIR
+000749  point: comment=multi_prod_x[2][23]:1->0 hier=IIR
+000755  point: comment=multi_prod_x[2][24]:0->1 hier=IIR
+000755  point: comment=multi_prod_x[2][24]:1->0 hier=IIR
+000759  point: comment=multi_prod_x[2][25]:0->1 hier=IIR
+000758  point: comment=multi_prod_x[2][25]:1->0 hier=IIR
+000764  point: comment=multi_prod_x[2][26]:0->1 hier=IIR
+000761  point: comment=multi_prod_x[2][26]:1->0 hier=IIR
+000738  point: comment=multi_prod_x[2][27]:0->1 hier=IIR
+000735  point: comment=multi_prod_x[2][27]:1->0 hier=IIR
+000806  point: comment=multi_prod_x[2][28]:0->1 hier=IIR
+000802  point: comment=multi_prod_x[2][28]:1->0 hier=IIR
+000774  point: comment=multi_prod_x[2][29]:0->1 hier=IIR
+000771  point: comment=multi_prod_x[2][29]:1->0 hier=IIR
+000684  point: comment=multi_prod_x[2][2]:0->1 hier=IIR
+000681  point: comment=multi_prod_x[2][2]:1->0 hier=IIR
+000739  point: comment=multi_prod_x[2][30]:0->1 hier=IIR
+000735  point: comment=multi_prod_x[2][30]:1->0 hier=IIR
+000775  point: comment=multi_prod_x[2][31]:0->1 hier=IIR
+000771  point: comment=multi_prod_x[2][31]:1->0 hier=IIR
+000770  point: comment=multi_prod_x[2][32]:0->1 hier=IIR
+000767  point: comment=multi_prod_x[2][32]:1->0 hier=IIR
+000795  point: comment=multi_prod_x[2][33]:0->1 hier=IIR
+000792  point: comment=multi_prod_x[2][33]:1->0 hier=IIR
+000776  point: comment=multi_prod_x[2][34]:0->1 hier=IIR
+000775  point: comment=multi_prod_x[2][34]:1->0 hier=IIR
+000768  point: comment=multi_prod_x[2][35]:0->1 hier=IIR
+000765  point: comment=multi_prod_x[2][35]:1->0 hier=IIR
+000795  point: comment=multi_prod_x[2][36]:0->1 hier=IIR
+000792  point: comment=multi_prod_x[2][36]:1->0 hier=IIR
+000776  point: comment=multi_prod_x[2][37]:0->1 hier=IIR
+000775  point: comment=multi_prod_x[2][37]:1->0 hier=IIR
+000781  point: comment=multi_prod_x[2][38]:0->1 hier=IIR
+000777  point: comment=multi_prod_x[2][38]:1->0 hier=IIR
+000756  point: comment=multi_prod_x[2][39]:0->1 hier=IIR
+000754  point: comment=multi_prod_x[2][39]:1->0 hier=IIR
+000755  point: comment=multi_prod_x[2][3]:0->1 hier=IIR
+000753  point: comment=multi_prod_x[2][3]:1->0 hier=IIR
+000790  point: comment=multi_prod_x[2][40]:0->1 hier=IIR
+000787  point: comment=multi_prod_x[2][40]:1->0 hier=IIR
+000754  point: comment=multi_prod_x[2][41]:0->1 hier=IIR
+000752  point: comment=multi_prod_x[2][41]:1->0 hier=IIR
+000763  point: comment=multi_prod_x[2][42]:0->1 hier=IIR
+000760  point: comment=multi_prod_x[2][42]:1->0 hier=IIR
+000776  point: comment=multi_prod_x[2][43]:0->1 hier=IIR
+000774  point: comment=multi_prod_x[2][43]:1->0 hier=IIR
+000758  point: comment=multi_prod_x[2][44]:0->1 hier=IIR
+000756  point: comment=multi_prod_x[2][44]:1->0 hier=IIR
+000734  point: comment=multi_prod_x[2][45]:0->1 hier=IIR
+000731  point: comment=multi_prod_x[2][45]:1->0 hier=IIR
+000776  point: comment=multi_prod_x[2][46]:0->1 hier=IIR
+000773  point: comment=multi_prod_x[2][46]:1->0 hier=IIR
+000781  point: comment=multi_prod_x[2][47]:0->1 hier=IIR
+000778  point: comment=multi_prod_x[2][47]:1->0 hier=IIR
+000765  point: comment=multi_prod_x[2][48]:0->1 hier=IIR
+000763  point: comment=multi_prod_x[2][48]:1->0 hier=IIR
+000782  point: comment=multi_prod_x[2][49]:0->1 hier=IIR
+000778  point: comment=multi_prod_x[2][49]:1->0 hier=IIR
+000746  point: comment=multi_prod_x[2][4]:0->1 hier=IIR
+000742  point: comment=multi_prod_x[2][4]:1->0 hier=IIR
+000795  point: comment=multi_prod_x[2][50]:0->1 hier=IIR
+000793  point: comment=multi_prod_x[2][50]:1->0 hier=IIR
+000762  point: comment=multi_prod_x[2][51]:0->1 hier=IIR
+000759  point: comment=multi_prod_x[2][51]:1->0 hier=IIR
+000769  point: comment=multi_prod_x[2][52]:0->1 hier=IIR
+000767  point: comment=multi_prod_x[2][52]:1->0 hier=IIR
+000761  point: comment=multi_prod_x[2][53]:0->1 hier=IIR
+000758  point: comment=multi_prod_x[2][53]:1->0 hier=IIR
+000791  point: comment=multi_prod_x[2][54]:0->1 hier=IIR
+000787  point: comment=multi_prod_x[2][54]:1->0 hier=IIR
+000791  point: comment=multi_prod_x[2][55]:0->1 hier=IIR
+000787  point: comment=multi_prod_x[2][55]:1->0 hier=IIR
+000791  point: comment=multi_prod_x[2][56]:0->1 hier=IIR
+000787  point: comment=multi_prod_x[2][56]:1->0 hier=IIR
+000791  point: comment=multi_prod_x[2][57]:0->1 hier=IIR
+000787  point: comment=multi_prod_x[2][57]:1->0 hier=IIR
+000766  point: comment=multi_prod_x[2][5]:0->1 hier=IIR
+000765  point: comment=multi_prod_x[2][5]:1->0 hier=IIR
+000781  point: comment=multi_prod_x[2][6]:0->1 hier=IIR
+000779  point: comment=multi_prod_x[2][6]:1->0 hier=IIR
+000783  point: comment=multi_prod_x[2][7]:0->1 hier=IIR
+000781  point: comment=multi_prod_x[2][7]:1->0 hier=IIR
+000782  point: comment=multi_prod_x[2][8]:0->1 hier=IIR
+000781  point: comment=multi_prod_x[2][8]:1->0 hier=IIR
+000771  point: comment=multi_prod_x[2][9]:0->1 hier=IIR
+000769  point: comment=multi_prod_x[2][9]:1->0 hier=IIR
 000941    logic signed [MULTIPLY_WIDTH:0] multi_prod_y [0:OUTPUT_TAPS-1];
+000699  point: comment=multi_prod_y[0][0]:0->1 hier=IIR
+000698  point: comment=multi_prod_y[0][0]:1->0 hier=IIR
+000919  point: comment=multi_prod_y[0][10]:0->1 hier=IIR
+000916  point: comment=multi_prod_y[0][10]:1->0 hier=IIR
+000908  point: comment=multi_prod_y[0][11]:0->1 hier=IIR
+000905  point: comment=multi_prod_y[0][11]:1->0 hier=IIR
+000899  point: comment=multi_prod_y[0][12]:0->1 hier=IIR
+000899  point: comment=multi_prod_y[0][12]:1->0 hier=IIR
+000890  point: comment=multi_prod_y[0][13]:0->1 hier=IIR
+000888  point: comment=multi_prod_y[0][13]:1->0 hier=IIR
+000902  point: comment=multi_prod_y[0][14]:0->1 hier=IIR
+000902  point: comment=multi_prod_y[0][14]:1->0 hier=IIR
+000891  point: comment=multi_prod_y[0][15]:0->1 hier=IIR
+000889  point: comment=multi_prod_y[0][15]:1->0 hier=IIR
+000925  point: comment=multi_prod_y[0][16]:0->1 hier=IIR
+000923  point: comment=multi_prod_y[0][16]:1->0 hier=IIR
+000900  point: comment=multi_prod_y[0][17]:0->1 hier=IIR
+000897  point: comment=multi_prod_y[0][17]:1->0 hier=IIR
+000915  point: comment=multi_prod_y[0][18]:0->1 hier=IIR
+000912  point: comment=multi_prod_y[0][18]:1->0 hier=IIR
+000910  point: comment=multi_prod_y[0][19]:0->1 hier=IIR
+000910  point: comment=multi_prod_y[0][19]:1->0 hier=IIR
+000710  point: comment=multi_prod_y[0][1]:0->1 hier=IIR
+000709  point: comment=multi_prod_y[0][1]:1->0 hier=IIR
+000894  point: comment=multi_prod_y[0][20]:0->1 hier=IIR
+000891  point: comment=multi_prod_y[0][20]:1->0 hier=IIR
+000890  point: comment=multi_prod_y[0][21]:0->1 hier=IIR
+000887  point: comment=multi_prod_y[0][21]:1->0 hier=IIR
+000917  point: comment=multi_prod_y[0][22]:0->1 hier=IIR
+000915  point: comment=multi_prod_y[0][22]:1->0 hier=IIR
+000909  point: comment=multi_prod_y[0][23]:0->1 hier=IIR
+000907  point: comment=multi_prod_y[0][23]:1->0 hier=IIR
+000918  point: comment=multi_prod_y[0][24]:0->1 hier=IIR
+000917  point: comment=multi_prod_y[0][24]:1->0 hier=IIR
+000910  point: comment=multi_prod_y[0][25]:0->1 hier=IIR
+000908  point: comment=multi_prod_y[0][25]:1->0 hier=IIR
+000933  point: comment=multi_prod_y[0][26]:0->1 hier=IIR
+000928  point: comment=multi_prod_y[0][26]:1->0 hier=IIR
+000935  point: comment=multi_prod_y[0][27]:0->1 hier=IIR
+000932  point: comment=multi_prod_y[0][27]:1->0 hier=IIR
+000941  point: comment=multi_prod_y[0][28]:0->1 hier=IIR
+000939  point: comment=multi_prod_y[0][28]:1->0 hier=IIR
+000923  point: comment=multi_prod_y[0][29]:0->1 hier=IIR
+000922  point: comment=multi_prod_y[0][29]:1->0 hier=IIR
+000878  point: comment=multi_prod_y[0][2]:0->1 hier=IIR
+000876  point: comment=multi_prod_y[0][2]:1->0 hier=IIR
+000934  point: comment=multi_prod_y[0][30]:0->1 hier=IIR
+000932  point: comment=multi_prod_y[0][30]:1->0 hier=IIR
+000915  point: comment=multi_prod_y[0][31]:0->1 hier=IIR
+000915  point: comment=multi_prod_y[0][31]:1->0 hier=IIR
+000898  point: comment=multi_prod_y[0][32]:0->1 hier=IIR
+000895  point: comment=multi_prod_y[0][32]:1->0 hier=IIR
+000895  point: comment=multi_prod_y[0][33]:0->1 hier=IIR
+000891  point: comment=multi_prod_y[0][33]:1->0 hier=IIR
+000893  point: comment=multi_prod_y[0][34]:0->1 hier=IIR
+000890  point: comment=multi_prod_y[0][34]:1->0 hier=IIR
+000909  point: comment=multi_prod_y[0][35]:0->1 hier=IIR
+000907  point: comment=multi_prod_y[0][35]:1->0 hier=IIR
+000897  point: comment=multi_prod_y[0][36]:0->1 hier=IIR
+000895  point: comment=multi_prod_y[0][36]:1->0 hier=IIR
+000931  point: comment=multi_prod_y[0][37]:0->1 hier=IIR
+000929  point: comment=multi_prod_y[0][37]:1->0 hier=IIR
+000928  point: comment=multi_prod_y[0][38]:0->1 hier=IIR
+000926  point: comment=multi_prod_y[0][38]:1->0 hier=IIR
+000923  point: comment=multi_prod_y[0][39]:0->1 hier=IIR
+000922  point: comment=multi_prod_y[0][39]:1->0 hier=IIR
+000927  point: comment=multi_prod_y[0][3]:0->1 hier=IIR
+000925  point: comment=multi_prod_y[0][3]:1->0 hier=IIR
+000902  point: comment=multi_prod_y[0][40]:0->1 hier=IIR
+000900  point: comment=multi_prod_y[0][40]:1->0 hier=IIR
+000913  point: comment=multi_prod_y[0][41]:0->1 hier=IIR
+000912  point: comment=multi_prod_y[0][41]:1->0 hier=IIR
+000921  point: comment=multi_prod_y[0][42]:0->1 hier=IIR
+000917  point: comment=multi_prod_y[0][42]:1->0 hier=IIR
+000902  point: comment=multi_prod_y[0][43]:0->1 hier=IIR
+000899  point: comment=multi_prod_y[0][43]:1->0 hier=IIR
+000900  point: comment=multi_prod_y[0][44]:0->1 hier=IIR
+000899  point: comment=multi_prod_y[0][44]:1->0 hier=IIR
+000906  point: comment=multi_prod_y[0][45]:0->1 hier=IIR
+000905  point: comment=multi_prod_y[0][45]:1->0 hier=IIR
+000909  point: comment=multi_prod_y[0][46]:0->1 hier=IIR
+000907  point: comment=multi_prod_y[0][46]:1->0 hier=IIR
+000906  point: comment=multi_prod_y[0][47]:0->1 hier=IIR
+000904  point: comment=multi_prod_y[0][47]:1->0 hier=IIR
+000923  point: comment=multi_prod_y[0][48]:0->1 hier=IIR
+000921  point: comment=multi_prod_y[0][48]:1->0 hier=IIR
+000927  point: comment=multi_prod_y[0][49]:0->1 hier=IIR
+000924  point: comment=multi_prod_y[0][49]:1->0 hier=IIR
+000893  point: comment=multi_prod_y[0][4]:0->1 hier=IIR
+000890  point: comment=multi_prod_y[0][4]:1->0 hier=IIR
+000907  point: comment=multi_prod_y[0][50]:0->1 hier=IIR
+000905  point: comment=multi_prod_y[0][50]:1->0 hier=IIR
+000899  point: comment=multi_prod_y[0][51]:0->1 hier=IIR
+000896  point: comment=multi_prod_y[0][51]:1->0 hier=IIR
+000889  point: comment=multi_prod_y[0][52]:0->1 hier=IIR
+000887  point: comment=multi_prod_y[0][52]:1->0 hier=IIR
+000914  point: comment=multi_prod_y[0][53]:0->1 hier=IIR
+000909  point: comment=multi_prod_y[0][53]:1->0 hier=IIR
+000911  point: comment=multi_prod_y[0][54]:0->1 hier=IIR
+000909  point: comment=multi_prod_y[0][54]:1->0 hier=IIR
+000901  point: comment=multi_prod_y[0][55]:0->1 hier=IIR
+000898  point: comment=multi_prod_y[0][55]:1->0 hier=IIR
+000901  point: comment=multi_prod_y[0][56]:0->1 hier=IIR
+000898  point: comment=multi_prod_y[0][56]:1->0 hier=IIR
+000901  point: comment=multi_prod_y[0][57]:0->1 hier=IIR
+000898  point: comment=multi_prod_y[0][57]:1->0 hier=IIR
+000923  point: comment=multi_prod_y[0][5]:0->1 hier=IIR
+000920  point: comment=multi_prod_y[0][5]:1->0 hier=IIR
+000922  point: comment=multi_prod_y[0][6]:0->1 hier=IIR
+000921  point: comment=multi_prod_y[0][6]:1->0 hier=IIR
+000907  point: comment=multi_prod_y[0][7]:0->1 hier=IIR
+000906  point: comment=multi_prod_y[0][7]:1->0 hier=IIR
+000898  point: comment=multi_prod_y[0][8]:0->1 hier=IIR
+000895  point: comment=multi_prod_y[0][8]:1->0 hier=IIR
+000884  point: comment=multi_prod_y[0][9]:0->1 hier=IIR
+000881  point: comment=multi_prod_y[0][9]:1->0 hier=IIR
+000320  point: comment=multi_prod_y[1][0]:0->1 hier=IIR
+000319  point: comment=multi_prod_y[1][0]:1->0 hier=IIR
+000741  point: comment=multi_prod_y[1][10]:0->1 hier=IIR
+000741  point: comment=multi_prod_y[1][10]:1->0 hier=IIR
+000747  point: comment=multi_prod_y[1][11]:0->1 hier=IIR
+000747  point: comment=multi_prod_y[1][11]:1->0 hier=IIR
+000745  point: comment=multi_prod_y[1][12]:0->1 hier=IIR
+000742  point: comment=multi_prod_y[1][12]:1->0 hier=IIR
+000741  point: comment=multi_prod_y[1][13]:0->1 hier=IIR
+000740  point: comment=multi_prod_y[1][13]:1->0 hier=IIR
+000748  point: comment=multi_prod_y[1][14]:0->1 hier=IIR
+000747  point: comment=multi_prod_y[1][14]:1->0 hier=IIR
+000771  point: comment=multi_prod_y[1][15]:0->1 hier=IIR
+000769  point: comment=multi_prod_y[1][15]:1->0 hier=IIR
+000742  point: comment=multi_prod_y[1][16]:0->1 hier=IIR
+000740  point: comment=multi_prod_y[1][16]:1->0 hier=IIR
+000765  point: comment=multi_prod_y[1][17]:0->1 hier=IIR
+000765  point: comment=multi_prod_y[1][17]:1->0 hier=IIR
+000757  point: comment=multi_prod_y[1][18]:0->1 hier=IIR
+000754  point: comment=multi_prod_y[1][18]:1->0 hier=IIR
+000773  point: comment=multi_prod_y[1][19]:0->1 hier=IIR
+000769  point: comment=multi_prod_y[1][19]:1->0 hier=IIR
+000757  point: comment=multi_prod_y[1][1]:0->1 hier=IIR
+000755  point: comment=multi_prod_y[1][1]:1->0 hier=IIR
+000796  point: comment=multi_prod_y[1][20]:0->1 hier=IIR
+000794  point: comment=multi_prod_y[1][20]:1->0 hier=IIR
+000750  point: comment=multi_prod_y[1][21]:0->1 hier=IIR
+000748  point: comment=multi_prod_y[1][21]:1->0 hier=IIR
+000746  point: comment=multi_prod_y[1][22]:0->1 hier=IIR
+000744  point: comment=multi_prod_y[1][22]:1->0 hier=IIR
+000777  point: comment=multi_prod_y[1][23]:0->1 hier=IIR
+000774  point: comment=multi_prod_y[1][23]:1->0 hier=IIR
+000769  point: comment=multi_prod_y[1][24]:0->1 hier=IIR
+000767  point: comment=multi_prod_y[1][24]:1->0 hier=IIR
+000764  point: comment=multi_prod_y[1][25]:0->1 hier=IIR
+000760  point: comment=multi_prod_y[1][25]:1->0 hier=IIR
+000743  point: comment=multi_prod_y[1][26]:0->1 hier=IIR
+000742  point: comment=multi_prod_y[1][26]:1->0 hier=IIR
+000777  point: comment=multi_prod_y[1][27]:0->1 hier=IIR
+000773  point: comment=multi_prod_y[1][27]:1->0 hier=IIR
+000757  point: comment=multi_prod_y[1][28]:0->1 hier=IIR
+000757  point: comment=multi_prod_y[1][28]:1->0 hier=IIR
+000774  point: comment=multi_prod_y[1][29]:0->1 hier=IIR
+000772  point: comment=multi_prod_y[1][29]:1->0 hier=IIR
+000757  point: comment=multi_prod_y[1][2]:0->1 hier=IIR
+000754  point: comment=multi_prod_y[1][2]:1->0 hier=IIR
+000778  point: comment=multi_prod_y[1][30]:0->1 hier=IIR
+000776  point: comment=multi_prod_y[1][30]:1->0 hier=IIR
+000777  point: comment=multi_prod_y[1][31]:0->1 hier=IIR
+000776  point: comment=multi_prod_y[1][31]:1->0 hier=IIR
+000787  point: comment=multi_prod_y[1][32]:0->1 hier=IIR
+000783  point: comment=multi_prod_y[1][32]:1->0 hier=IIR
+000722  point: comment=multi_prod_y[1][33]:0->1 hier=IIR
+000720  point: comment=multi_prod_y[1][33]:1->0 hier=IIR
+000772  point: comment=multi_prod_y[1][34]:0->1 hier=IIR
+000769  point: comment=multi_prod_y[1][34]:1->0 hier=IIR
+000753  point: comment=multi_prod_y[1][35]:0->1 hier=IIR
+000751  point: comment=multi_prod_y[1][35]:1->0 hier=IIR
+000772  point: comment=multi_prod_y[1][36]:0->1 hier=IIR
+000770  point: comment=multi_prod_y[1][36]:1->0 hier=IIR
+000762  point: comment=multi_prod_y[1][37]:0->1 hier=IIR
+000760  point: comment=multi_prod_y[1][37]:1->0 hier=IIR
+000748  point: comment=multi_prod_y[1][38]:0->1 hier=IIR
+000745  point: comment=multi_prod_y[1][38]:1->0 hier=IIR
+000760  point: comment=multi_prod_y[1][39]:0->1 hier=IIR
+000758  point: comment=multi_prod_y[1][39]:1->0 hier=IIR
+000753  point: comment=multi_prod_y[1][3]:0->1 hier=IIR
+000751  point: comment=multi_prod_y[1][3]:1->0 hier=IIR
+000779  point: comment=multi_prod_y[1][40]:0->1 hier=IIR
+000776  point: comment=multi_prod_y[1][40]:1->0 hier=IIR
+000780  point: comment=multi_prod_y[1][41]:0->1 hier=IIR
+000776  point: comment=multi_prod_y[1][41]:1->0 hier=IIR
+000795  point: comment=multi_prod_y[1][42]:0->1 hier=IIR
+000795  point: comment=multi_prod_y[1][42]:1->0 hier=IIR
+000772  point: comment=multi_prod_y[1][43]:0->1 hier=IIR
+000769  point: comment=multi_prod_y[1][43]:1->0 hier=IIR
+000787  point: comment=multi_prod_y[1][44]:0->1 hier=IIR
+000784  point: comment=multi_prod_y[1][44]:1->0 hier=IIR
+000752  point: comment=multi_prod_y[1][45]:0->1 hier=IIR
+000749  point: comment=multi_prod_y[1][45]:1->0 hier=IIR
+000767  point: comment=multi_prod_y[1][46]:0->1 hier=IIR
+000764  point: comment=multi_prod_y[1][46]:1->0 hier=IIR
+000794  point: comment=multi_prod_y[1][47]:0->1 hier=IIR
+000793  point: comment=multi_prod_y[1][47]:1->0 hier=IIR
+000766  point: comment=multi_prod_y[1][48]:0->1 hier=IIR
+000763  point: comment=multi_prod_y[1][48]:1->0 hier=IIR
+000776  point: comment=multi_prod_y[1][49]:0->1 hier=IIR
+000772  point: comment=multi_prod_y[1][49]:1->0 hier=IIR
+000752  point: comment=multi_prod_y[1][4]:0->1 hier=IIR
+000749  point: comment=multi_prod_y[1][4]:1->0 hier=IIR
+000780  point: comment=multi_prod_y[1][50]:0->1 hier=IIR
+000776  point: comment=multi_prod_y[1][50]:1->0 hier=IIR
+000761  point: comment=multi_prod_y[1][51]:0->1 hier=IIR
+000760  point: comment=multi_prod_y[1][51]:1->0 hier=IIR
+000764  point: comment=multi_prod_y[1][52]:0->1 hier=IIR
+000763  point: comment=multi_prod_y[1][52]:1->0 hier=IIR
+000756  point: comment=multi_prod_y[1][53]:0->1 hier=IIR
+000754  point: comment=multi_prod_y[1][53]:1->0 hier=IIR
+000763  point: comment=multi_prod_y[1][54]:0->1 hier=IIR
+000760  point: comment=multi_prod_y[1][54]:1->0 hier=IIR
+000763  point: comment=multi_prod_y[1][55]:0->1 hier=IIR
+000760  point: comment=multi_prod_y[1][55]:1->0 hier=IIR
+000763  point: comment=multi_prod_y[1][56]:0->1 hier=IIR
+000760  point: comment=multi_prod_y[1][56]:1->0 hier=IIR
+000763  point: comment=multi_prod_y[1][57]:0->1 hier=IIR
+000760  point: comment=multi_prod_y[1][57]:1->0 hier=IIR
+000767  point: comment=multi_prod_y[1][5]:0->1 hier=IIR
+000766  point: comment=multi_prod_y[1][5]:1->0 hier=IIR
+000778  point: comment=multi_prod_y[1][6]:0->1 hier=IIR
+000776  point: comment=multi_prod_y[1][6]:1->0 hier=IIR
+000777  point: comment=multi_prod_y[1][7]:0->1 hier=IIR
+000775  point: comment=multi_prod_y[1][7]:1->0 hier=IIR
+000737  point: comment=multi_prod_y[1][8]:0->1 hier=IIR
+000737  point: comment=multi_prod_y[1][8]:1->0 hier=IIR
+000779  point: comment=multi_prod_y[1][9]:0->1 hier=IIR
+000776  point: comment=multi_prod_y[1][9]:1->0 hier=IIR
        
 001459    logic signed [I_ACC_WIDTH:0]    acc_x_reg ;
+000990  point: comment=acc_x_reg[0]:0->1 hier=IIR
+000987  point: comment=acc_x_reg[0]:1->0 hier=IIR
+001074  point: comment=acc_x_reg[10]:0->1 hier=IIR
+001072  point: comment=acc_x_reg[10]:1->0 hier=IIR
+001078  point: comment=acc_x_reg[11]:0->1 hier=IIR
+001074  point: comment=acc_x_reg[11]:1->0 hier=IIR
+001065  point: comment=acc_x_reg[12]:0->1 hier=IIR
+001063  point: comment=acc_x_reg[12]:1->0 hier=IIR
+001076  point: comment=acc_x_reg[13]:0->1 hier=IIR
+001072  point: comment=acc_x_reg[13]:1->0 hier=IIR
+001078  point: comment=acc_x_reg[14]:0->1 hier=IIR
+001075  point: comment=acc_x_reg[14]:1->0 hier=IIR
+001058  point: comment=acc_x_reg[15]:0->1 hier=IIR
+001055  point: comment=acc_x_reg[15]:1->0 hier=IIR
+001064  point: comment=acc_x_reg[16]:0->1 hier=IIR
+001061  point: comment=acc_x_reg[16]:1->0 hier=IIR
+001071  point: comment=acc_x_reg[17]:0->1 hier=IIR
+001067  point: comment=acc_x_reg[17]:1->0 hier=IIR
+001076  point: comment=acc_x_reg[18]:0->1 hier=IIR
+001074  point: comment=acc_x_reg[18]:1->0 hier=IIR
+001073  point: comment=acc_x_reg[19]:0->1 hier=IIR
+001070  point: comment=acc_x_reg[19]:1->0 hier=IIR
+001031  point: comment=acc_x_reg[1]:0->1 hier=IIR
+001029  point: comment=acc_x_reg[1]:1->0 hier=IIR
+001071  point: comment=acc_x_reg[20]:0->1 hier=IIR
+001069  point: comment=acc_x_reg[20]:1->0 hier=IIR
+001073  point: comment=acc_x_reg[21]:0->1 hier=IIR
+001071  point: comment=acc_x_reg[21]:1->0 hier=IIR
+001096  point: comment=acc_x_reg[22]:0->1 hier=IIR
+001094  point: comment=acc_x_reg[22]:1->0 hier=IIR
+001074  point: comment=acc_x_reg[23]:0->1 hier=IIR
+001069  point: comment=acc_x_reg[23]:1->0 hier=IIR
+001091  point: comment=acc_x_reg[24]:0->1 hier=IIR
+001089  point: comment=acc_x_reg[24]:1->0 hier=IIR
+001063  point: comment=acc_x_reg[25]:0->1 hier=IIR
+001058  point: comment=acc_x_reg[25]:1->0 hier=IIR
+001072  point: comment=acc_x_reg[26]:0->1 hier=IIR
+001067  point: comment=acc_x_reg[26]:1->0 hier=IIR
+001068  point: comment=acc_x_reg[27]:0->1 hier=IIR
+001064  point: comment=acc_x_reg[27]:1->0 hier=IIR
+001071  point: comment=acc_x_reg[28]:0->1 hier=IIR
+001070  point: comment=acc_x_reg[28]:1->0 hier=IIR
+001072  point: comment=acc_x_reg[29]:0->1 hier=IIR
+001069  point: comment=acc_x_reg[29]:1->0 hier=IIR
+001023  point: comment=acc_x_reg[2]:0->1 hier=IIR
+001020  point: comment=acc_x_reg[2]:1->0 hier=IIR
+001081  point: comment=acc_x_reg[30]:0->1 hier=IIR
+001081  point: comment=acc_x_reg[30]:1->0 hier=IIR
+001047  point: comment=acc_x_reg[31]:0->1 hier=IIR
+001044  point: comment=acc_x_reg[31]:1->0 hier=IIR
+001081  point: comment=acc_x_reg[32]:0->1 hier=IIR
+001076  point: comment=acc_x_reg[32]:1->0 hier=IIR
+001057  point: comment=acc_x_reg[33]:0->1 hier=IIR
+001055  point: comment=acc_x_reg[33]:1->0 hier=IIR
+001123  point: comment=acc_x_reg[34]:0->1 hier=IIR
+001121  point: comment=acc_x_reg[34]:1->0 hier=IIR
+001040  point: comment=acc_x_reg[35]:0->1 hier=IIR
+001035  point: comment=acc_x_reg[35]:1->0 hier=IIR
+001076  point: comment=acc_x_reg[36]:0->1 hier=IIR
+001073  point: comment=acc_x_reg[36]:1->0 hier=IIR
+001056  point: comment=acc_x_reg[37]:0->1 hier=IIR
+001054  point: comment=acc_x_reg[37]:1->0 hier=IIR
+001080  point: comment=acc_x_reg[38]:0->1 hier=IIR
+001079  point: comment=acc_x_reg[38]:1->0 hier=IIR
+001065  point: comment=acc_x_reg[39]:0->1 hier=IIR
+001063  point: comment=acc_x_reg[39]:1->0 hier=IIR
+001077  point: comment=acc_x_reg[3]:0->1 hier=IIR
+001077  point: comment=acc_x_reg[3]:1->0 hier=IIR
+001068  point: comment=acc_x_reg[40]:0->1 hier=IIR
+001066  point: comment=acc_x_reg[40]:1->0 hier=IIR
+001085  point: comment=acc_x_reg[41]:0->1 hier=IIR
+001081  point: comment=acc_x_reg[41]:1->0 hier=IIR
+001104  point: comment=acc_x_reg[42]:0->1 hier=IIR
+001102  point: comment=acc_x_reg[42]:1->0 hier=IIR
+001088  point: comment=acc_x_reg[43]:0->1 hier=IIR
+001085  point: comment=acc_x_reg[43]:1->0 hier=IIR
+001086  point: comment=acc_x_reg[44]:0->1 hier=IIR
+001081  point: comment=acc_x_reg[44]:1->0 hier=IIR
+001090  point: comment=acc_x_reg[45]:0->1 hier=IIR
+001087  point: comment=acc_x_reg[45]:1->0 hier=IIR
+001067  point: comment=acc_x_reg[46]:0->1 hier=IIR
+001064  point: comment=acc_x_reg[46]:1->0 hier=IIR
+001069  point: comment=acc_x_reg[47]:0->1 hier=IIR
+001067  point: comment=acc_x_reg[47]:1->0 hier=IIR
+001042  point: comment=acc_x_reg[48]:0->1 hier=IIR
+001038  point: comment=acc_x_reg[48]:1->0 hier=IIR
+001073  point: comment=acc_x_reg[49]:0->1 hier=IIR
+001070  point: comment=acc_x_reg[49]:1->0 hier=IIR
+001078  point: comment=acc_x_reg[4]:0->1 hier=IIR
+001074  point: comment=acc_x_reg[4]:1->0 hier=IIR
+001069  point: comment=acc_x_reg[50]:0->1 hier=IIR
+001065  point: comment=acc_x_reg[50]:1->0 hier=IIR
+001079  point: comment=acc_x_reg[51]:0->1 hier=IIR
+001077  point: comment=acc_x_reg[51]:1->0 hier=IIR
+001053  point: comment=acc_x_reg[52]:0->1 hier=IIR
+001049  point: comment=acc_x_reg[52]:1->0 hier=IIR
+001081  point: comment=acc_x_reg[53]:0->1 hier=IIR
+001077  point: comment=acc_x_reg[53]:1->0 hier=IIR
+001063  point: comment=acc_x_reg[54]:0->1 hier=IIR
+001060  point: comment=acc_x_reg[54]:1->0 hier=IIR
+001253  point: comment=acc_x_reg[55]:0->1 hier=IIR
+001249  point: comment=acc_x_reg[55]:1->0 hier=IIR
+001459  point: comment=acc_x_reg[56]:0->1 hier=IIR
+001455  point: comment=acc_x_reg[56]:1->0 hier=IIR
+001459  point: comment=acc_x_reg[57]:0->1 hier=IIR
+001455  point: comment=acc_x_reg[57]:1->0 hier=IIR
+001459  point: comment=acc_x_reg[58]:0->1 hier=IIR
+001455  point: comment=acc_x_reg[58]:1->0 hier=IIR
+001459  point: comment=acc_x_reg[59]:0->1 hier=IIR
+001455  point: comment=acc_x_reg[59]:1->0 hier=IIR
+001094  point: comment=acc_x_reg[5]:0->1 hier=IIR
+001092  point: comment=acc_x_reg[5]:1->0 hier=IIR
+001092  point: comment=acc_x_reg[6]:0->1 hier=IIR
+001088  point: comment=acc_x_reg[6]:1->0 hier=IIR
+001074  point: comment=acc_x_reg[7]:0->1 hier=IIR
+001073  point: comment=acc_x_reg[7]:1->0 hier=IIR
+001038  point: comment=acc_x_reg[8]:0->1 hier=IIR
+001035  point: comment=acc_x_reg[8]:1->0 hier=IIR
+001075  point: comment=acc_x_reg[9]:0->1 hier=IIR
+001073  point: comment=acc_x_reg[9]:1->0 hier=IIR
 001509    logic signed [I_ACC_WIDTH:0]    acc_x_comb ;
+001016  point: comment=acc_x_comb[0]:0->1 hier=IIR
+001013  point: comment=acc_x_comb[0]:1->0 hier=IIR
+001111  point: comment=acc_x_comb[10]:0->1 hier=IIR
+001108  point: comment=acc_x_comb[10]:1->0 hier=IIR
+001110  point: comment=acc_x_comb[11]:0->1 hier=IIR
+001105  point: comment=acc_x_comb[11]:1->0 hier=IIR
+001100  point: comment=acc_x_comb[12]:0->1 hier=IIR
+001097  point: comment=acc_x_comb[12]:1->0 hier=IIR
+001103  point: comment=acc_x_comb[13]:0->1 hier=IIR
+001099  point: comment=acc_x_comb[13]:1->0 hier=IIR
+001108  point: comment=acc_x_comb[14]:0->1 hier=IIR
+001104  point: comment=acc_x_comb[14]:1->0 hier=IIR
+001087  point: comment=acc_x_comb[15]:0->1 hier=IIR
+001084  point: comment=acc_x_comb[15]:1->0 hier=IIR
+001089  point: comment=acc_x_comb[16]:0->1 hier=IIR
+001085  point: comment=acc_x_comb[16]:1->0 hier=IIR
+001098  point: comment=acc_x_comb[17]:0->1 hier=IIR
+001094  point: comment=acc_x_comb[17]:1->0 hier=IIR
+001107  point: comment=acc_x_comb[18]:0->1 hier=IIR
+001105  point: comment=acc_x_comb[18]:1->0 hier=IIR
+001102  point: comment=acc_x_comb[19]:0->1 hier=IIR
+001099  point: comment=acc_x_comb[19]:1->0 hier=IIR
+001060  point: comment=acc_x_comb[1]:0->1 hier=IIR
+001057  point: comment=acc_x_comb[1]:1->0 hier=IIR
+001095  point: comment=acc_x_comb[20]:0->1 hier=IIR
+001093  point: comment=acc_x_comb[20]:1->0 hier=IIR
+001102  point: comment=acc_x_comb[21]:0->1 hier=IIR
+001099  point: comment=acc_x_comb[21]:1->0 hier=IIR
+001121  point: comment=acc_x_comb[22]:0->1 hier=IIR
+001119  point: comment=acc_x_comb[22]:1->0 hier=IIR
+001098  point: comment=acc_x_comb[23]:0->1 hier=IIR
+001093  point: comment=acc_x_comb[23]:1->0 hier=IIR
+001118  point: comment=acc_x_comb[24]:0->1 hier=IIR
+001115  point: comment=acc_x_comb[24]:1->0 hier=IIR
+001094  point: comment=acc_x_comb[25]:0->1 hier=IIR
+001088  point: comment=acc_x_comb[25]:1->0 hier=IIR
+001096  point: comment=acc_x_comb[26]:0->1 hier=IIR
+001090  point: comment=acc_x_comb[26]:1->0 hier=IIR
+001101  point: comment=acc_x_comb[27]:0->1 hier=IIR
+001096  point: comment=acc_x_comb[27]:1->0 hier=IIR
+001099  point: comment=acc_x_comb[28]:0->1 hier=IIR
+001098  point: comment=acc_x_comb[28]:1->0 hier=IIR
+001102  point: comment=acc_x_comb[29]:0->1 hier=IIR
+001099  point: comment=acc_x_comb[29]:1->0 hier=IIR
+001056  point: comment=acc_x_comb[2]:0->1 hier=IIR
+001052  point: comment=acc_x_comb[2]:1->0 hier=IIR
+001105  point: comment=acc_x_comb[30]:0->1 hier=IIR
+001105  point: comment=acc_x_comb[30]:1->0 hier=IIR
+001076  point: comment=acc_x_comb[31]:0->1 hier=IIR
+001072  point: comment=acc_x_comb[31]:1->0 hier=IIR
+001111  point: comment=acc_x_comb[32]:0->1 hier=IIR
+001105  point: comment=acc_x_comb[32]:1->0 hier=IIR
+001090  point: comment=acc_x_comb[33]:0->1 hier=IIR
+001087  point: comment=acc_x_comb[33]:1->0 hier=IIR
+001149  point: comment=acc_x_comb[34]:0->1 hier=IIR
+001147  point: comment=acc_x_comb[34]:1->0 hier=IIR
+001071  point: comment=acc_x_comb[35]:0->1 hier=IIR
+001066  point: comment=acc_x_comb[35]:1->0 hier=IIR
+001102  point: comment=acc_x_comb[36]:0->1 hier=IIR
+001099  point: comment=acc_x_comb[36]:1->0 hier=IIR
+001088  point: comment=acc_x_comb[37]:0->1 hier=IIR
+001086  point: comment=acc_x_comb[37]:1->0 hier=IIR
+001104  point: comment=acc_x_comb[38]:0->1 hier=IIR
+001103  point: comment=acc_x_comb[38]:1->0 hier=IIR
+001092  point: comment=acc_x_comb[39]:0->1 hier=IIR
+001090  point: comment=acc_x_comb[39]:1->0 hier=IIR
+001107  point: comment=acc_x_comb[3]:0->1 hier=IIR
+001107  point: comment=acc_x_comb[3]:1->0 hier=IIR
+001099  point: comment=acc_x_comb[40]:0->1 hier=IIR
+001096  point: comment=acc_x_comb[40]:1->0 hier=IIR
+001111  point: comment=acc_x_comb[41]:0->1 hier=IIR
+001106  point: comment=acc_x_comb[41]:1->0 hier=IIR
+001133  point: comment=acc_x_comb[42]:0->1 hier=IIR
+001130  point: comment=acc_x_comb[42]:1->0 hier=IIR
+001117  point: comment=acc_x_comb[43]:0->1 hier=IIR
+001114  point: comment=acc_x_comb[43]:1->0 hier=IIR
+001116  point: comment=acc_x_comb[44]:0->1 hier=IIR
+001111  point: comment=acc_x_comb[44]:1->0 hier=IIR
+001129  point: comment=acc_x_comb[45]:0->1 hier=IIR
+001126  point: comment=acc_x_comb[45]:1->0 hier=IIR
+001094  point: comment=acc_x_comb[46]:0->1 hier=IIR
+001091  point: comment=acc_x_comb[46]:1->0 hier=IIR
+001102  point: comment=acc_x_comb[47]:0->1 hier=IIR
+001099  point: comment=acc_x_comb[47]:1->0 hier=IIR
+001081  point: comment=acc_x_comb[48]:0->1 hier=IIR
+001076  point: comment=acc_x_comb[48]:1->0 hier=IIR
+001100  point: comment=acc_x_comb[49]:0->1 hier=IIR
+001096  point: comment=acc_x_comb[49]:1->0 hier=IIR
+001110  point: comment=acc_x_comb[4]:0->1 hier=IIR
+001105  point: comment=acc_x_comb[4]:1->0 hier=IIR
+001104  point: comment=acc_x_comb[50]:0->1 hier=IIR
+001100  point: comment=acc_x_comb[50]:1->0 hier=IIR
+001100  point: comment=acc_x_comb[51]:0->1 hier=IIR
+001098  point: comment=acc_x_comb[51]:1->0 hier=IIR
+001088  point: comment=acc_x_comb[52]:0->1 hier=IIR
+001084  point: comment=acc_x_comb[52]:1->0 hier=IIR
+001105  point: comment=acc_x_comb[53]:0->1 hier=IIR
+001100  point: comment=acc_x_comb[53]:1->0 hier=IIR
+001096  point: comment=acc_x_comb[54]:0->1 hier=IIR
+001093  point: comment=acc_x_comb[54]:1->0 hier=IIR
+001297  point: comment=acc_x_comb[55]:0->1 hier=IIR
+001293  point: comment=acc_x_comb[55]:1->0 hier=IIR
+001509  point: comment=acc_x_comb[56]:0->1 hier=IIR
+001505  point: comment=acc_x_comb[56]:1->0 hier=IIR
+001509  point: comment=acc_x_comb[57]:0->1 hier=IIR
+001505  point: comment=acc_x_comb[57]:1->0 hier=IIR
+001509  point: comment=acc_x_comb[58]:0->1 hier=IIR
+001505  point: comment=acc_x_comb[58]:1->0 hier=IIR
+001509  point: comment=acc_x_comb[59]:0->1 hier=IIR
+001505  point: comment=acc_x_comb[59]:1->0 hier=IIR
+001127  point: comment=acc_x_comb[5]:0->1 hier=IIR
+001125  point: comment=acc_x_comb[5]:1->0 hier=IIR
+001122  point: comment=acc_x_comb[6]:0->1 hier=IIR
+001117  point: comment=acc_x_comb[6]:1->0 hier=IIR
+001105  point: comment=acc_x_comb[7]:0->1 hier=IIR
+001104  point: comment=acc_x_comb[7]:1->0 hier=IIR
+001071  point: comment=acc_x_comb[8]:0->1 hier=IIR
+001067  point: comment=acc_x_comb[8]:1->0 hier=IIR
+001103  point: comment=acc_x_comb[9]:0->1 hier=IIR
+001101  point: comment=acc_x_comb[9]:1->0 hier=IIR
 001037    logic signed [O_ACC_WIDTH:0]    acc_y_reg ;
+000803  point: comment=acc_y_reg[0]:0->1 hier=IIR
+000801  point: comment=acc_y_reg[0]:1->0 hier=IIR
+000886  point: comment=acc_y_reg[10]:0->1 hier=IIR
+000886  point: comment=acc_y_reg[10]:1->0 hier=IIR
+000909  point: comment=acc_y_reg[11]:0->1 hier=IIR
+000907  point: comment=acc_y_reg[11]:1->0 hier=IIR
+000906  point: comment=acc_y_reg[12]:0->1 hier=IIR
+000905  point: comment=acc_y_reg[12]:1->0 hier=IIR
+000892  point: comment=acc_y_reg[13]:0->1 hier=IIR
+000889  point: comment=acc_y_reg[13]:1->0 hier=IIR
+000894  point: comment=acc_y_reg[14]:0->1 hier=IIR
+000892  point: comment=acc_y_reg[14]:1->0 hier=IIR
+000880  point: comment=acc_y_reg[15]:0->1 hier=IIR
+000878  point: comment=acc_y_reg[15]:1->0 hier=IIR
+000913  point: comment=acc_y_reg[16]:0->1 hier=IIR
+000910  point: comment=acc_y_reg[16]:1->0 hier=IIR
+000939  point: comment=acc_y_reg[17]:0->1 hier=IIR
+000937  point: comment=acc_y_reg[17]:1->0 hier=IIR
+000928  point: comment=acc_y_reg[18]:0->1 hier=IIR
+000925  point: comment=acc_y_reg[18]:1->0 hier=IIR
+000889  point: comment=acc_y_reg[19]:0->1 hier=IIR
+000887  point: comment=acc_y_reg[19]:1->0 hier=IIR
+000872  point: comment=acc_y_reg[1]:0->1 hier=IIR
+000869  point: comment=acc_y_reg[1]:1->0 hier=IIR
+000884  point: comment=acc_y_reg[20]:0->1 hier=IIR
+000881  point: comment=acc_y_reg[20]:1->0 hier=IIR
+000907  point: comment=acc_y_reg[21]:0->1 hier=IIR
+000906  point: comment=acc_y_reg[21]:1->0 hier=IIR
+000898  point: comment=acc_y_reg[22]:0->1 hier=IIR
+000895  point: comment=acc_y_reg[22]:1->0 hier=IIR
+000903  point: comment=acc_y_reg[23]:0->1 hier=IIR
+000900  point: comment=acc_y_reg[23]:1->0 hier=IIR
+000896  point: comment=acc_y_reg[24]:0->1 hier=IIR
+000893  point: comment=acc_y_reg[24]:1->0 hier=IIR
+000911  point: comment=acc_y_reg[25]:0->1 hier=IIR
+000908  point: comment=acc_y_reg[25]:1->0 hier=IIR
+000931  point: comment=acc_y_reg[26]:0->1 hier=IIR
+000927  point: comment=acc_y_reg[26]:1->0 hier=IIR
+000888  point: comment=acc_y_reg[27]:0->1 hier=IIR
+000883  point: comment=acc_y_reg[27]:1->0 hier=IIR
+000899  point: comment=acc_y_reg[28]:0->1 hier=IIR
+000895  point: comment=acc_y_reg[28]:1->0 hier=IIR
+000894  point: comment=acc_y_reg[29]:0->1 hier=IIR
+000891  point: comment=acc_y_reg[29]:1->0 hier=IIR
+000874  point: comment=acc_y_reg[2]:0->1 hier=IIR
+000871  point: comment=acc_y_reg[2]:1->0 hier=IIR
+000879  point: comment=acc_y_reg[30]:0->1 hier=IIR
+000877  point: comment=acc_y_reg[30]:1->0 hier=IIR
+000904  point: comment=acc_y_reg[31]:0->1 hier=IIR
+000902  point: comment=acc_y_reg[31]:1->0 hier=IIR
+000902  point: comment=acc_y_reg[32]:0->1 hier=IIR
+000899  point: comment=acc_y_reg[32]:1->0 hier=IIR
+000916  point: comment=acc_y_reg[33]:0->1 hier=IIR
+000912  point: comment=acc_y_reg[33]:1->0 hier=IIR
+000885  point: comment=acc_y_reg[34]:0->1 hier=IIR
+000883  point: comment=acc_y_reg[34]:1->0 hier=IIR
+000905  point: comment=acc_y_reg[35]:0->1 hier=IIR
+000902  point: comment=acc_y_reg[35]:1->0 hier=IIR
+000890  point: comment=acc_y_reg[36]:0->1 hier=IIR
+000888  point: comment=acc_y_reg[36]:1->0 hier=IIR
+000908  point: comment=acc_y_reg[37]:0->1 hier=IIR
+000904  point: comment=acc_y_reg[37]:1->0 hier=IIR
+000891  point: comment=acc_y_reg[38]:0->1 hier=IIR
+000889  point: comment=acc_y_reg[38]:1->0 hier=IIR
+000900  point: comment=acc_y_reg[39]:0->1 hier=IIR
+000897  point: comment=acc_y_reg[39]:1->0 hier=IIR
+000908  point: comment=acc_y_reg[3]:0->1 hier=IIR
+000907  point: comment=acc_y_reg[3]:1->0 hier=IIR
+000920  point: comment=acc_y_reg[40]:0->1 hier=IIR
+000918  point: comment=acc_y_reg[40]:1->0 hier=IIR
+000901  point: comment=acc_y_reg[41]:0->1 hier=IIR
+000898  point: comment=acc_y_reg[41]:1->0 hier=IIR
+000898  point: comment=acc_y_reg[42]:0->1 hier=IIR
+000896  point: comment=acc_y_reg[42]:1->0 hier=IIR
+000892  point: comment=acc_y_reg[43]:0->1 hier=IIR
+000890  point: comment=acc_y_reg[43]:1->0 hier=IIR
+000866  point: comment=acc_y_reg[44]:0->1 hier=IIR
+000861  point: comment=acc_y_reg[44]:1->0 hier=IIR
+000906  point: comment=acc_y_reg[45]:0->1 hier=IIR
+000903  point: comment=acc_y_reg[45]:1->0 hier=IIR
+000881  point: comment=acc_y_reg[46]:0->1 hier=IIR
+000879  point: comment=acc_y_reg[46]:1->0 hier=IIR
+000897  point: comment=acc_y_reg[47]:0->1 hier=IIR
+000894  point: comment=acc_y_reg[47]:1->0 hier=IIR
+000891  point: comment=acc_y_reg[48]:0->1 hier=IIR
+000889  point: comment=acc_y_reg[48]:1->0 hier=IIR
+000871  point: comment=acc_y_reg[49]:0->1 hier=IIR
+000870  point: comment=acc_y_reg[49]:1->0 hier=IIR
+000928  point: comment=acc_y_reg[4]:0->1 hier=IIR
+000926  point: comment=acc_y_reg[4]:1->0 hier=IIR
+000921  point: comment=acc_y_reg[50]:0->1 hier=IIR
+000919  point: comment=acc_y_reg[50]:1->0 hier=IIR
+000876  point: comment=acc_y_reg[51]:0->1 hier=IIR
+000872  point: comment=acc_y_reg[51]:1->0 hier=IIR
+000870  point: comment=acc_y_reg[52]:0->1 hier=IIR
+000867  point: comment=acc_y_reg[52]:1->0 hier=IIR
+000914  point: comment=acc_y_reg[53]:0->1 hier=IIR
+000912  point: comment=acc_y_reg[53]:1->0 hier=IIR
+000887  point: comment=acc_y_reg[54]:0->1 hier=IIR
+000885  point: comment=acc_y_reg[54]:1->0 hier=IIR
+000912  point: comment=acc_y_reg[55]:0->1 hier=IIR
+000909  point: comment=acc_y_reg[55]:1->0 hier=IIR
+001037  point: comment=acc_y_reg[56]:0->1 hier=IIR
+001034  point: comment=acc_y_reg[56]:1->0 hier=IIR
+001037  point: comment=acc_y_reg[57]:0->1 hier=IIR
+001034  point: comment=acc_y_reg[57]:1->0 hier=IIR
+001037  point: comment=acc_y_reg[58]:0->1 hier=IIR
+001034  point: comment=acc_y_reg[58]:1->0 hier=IIR
+000885  point: comment=acc_y_reg[5]:0->1 hier=IIR
+000884  point: comment=acc_y_reg[5]:1->0 hier=IIR
+000898  point: comment=acc_y_reg[6]:0->1 hier=IIR
+000896  point: comment=acc_y_reg[6]:1->0 hier=IIR
+000893  point: comment=acc_y_reg[7]:0->1 hier=IIR
+000892  point: comment=acc_y_reg[7]:1->0 hier=IIR
+000887  point: comment=acc_y_reg[8]:0->1 hier=IIR
+000884  point: comment=acc_y_reg[8]:1->0 hier=IIR
+000864  point: comment=acc_y_reg[9]:0->1 hier=IIR
+000863  point: comment=acc_y_reg[9]:1->0 hier=IIR
 001066    logic signed [O_ACC_WIDTH:0]    acc_y_comb;
+000819  point: comment=acc_y_comb[0]:0->1 hier=IIR
+000817  point: comment=acc_y_comb[0]:1->0 hier=IIR
+000904  point: comment=acc_y_comb[10]:0->1 hier=IIR
+000904  point: comment=acc_y_comb[10]:1->0 hier=IIR
+000930  point: comment=acc_y_comb[11]:0->1 hier=IIR
+000928  point: comment=acc_y_comb[11]:1->0 hier=IIR
+000925  point: comment=acc_y_comb[12]:0->1 hier=IIR
+000924  point: comment=acc_y_comb[12]:1->0 hier=IIR
+000909  point: comment=acc_y_comb[13]:0->1 hier=IIR
+000906  point: comment=acc_y_comb[13]:1->0 hier=IIR
+000911  point: comment=acc_y_comb[14]:0->1 hier=IIR
+000909  point: comment=acc_y_comb[14]:1->0 hier=IIR
+000895  point: comment=acc_y_comb[15]:0->1 hier=IIR
+000893  point: comment=acc_y_comb[15]:1->0 hier=IIR
+000932  point: comment=acc_y_comb[16]:0->1 hier=IIR
+000929  point: comment=acc_y_comb[16]:1->0 hier=IIR
+000955  point: comment=acc_y_comb[17]:0->1 hier=IIR
+000953  point: comment=acc_y_comb[17]:1->0 hier=IIR
+000947  point: comment=acc_y_comb[18]:0->1 hier=IIR
+000944  point: comment=acc_y_comb[18]:1->0 hier=IIR
+000908  point: comment=acc_y_comb[19]:0->1 hier=IIR
+000906  point: comment=acc_y_comb[19]:1->0 hier=IIR
+000890  point: comment=acc_y_comb[1]:0->1 hier=IIR
+000887  point: comment=acc_y_comb[1]:1->0 hier=IIR
+000899  point: comment=acc_y_comb[20]:0->1 hier=IIR
+000896  point: comment=acc_y_comb[20]:1->0 hier=IIR
+000934  point: comment=acc_y_comb[21]:0->1 hier=IIR
+000933  point: comment=acc_y_comb[21]:1->0 hier=IIR
+000917  point: comment=acc_y_comb[22]:0->1 hier=IIR
+000914  point: comment=acc_y_comb[22]:1->0 hier=IIR
+000919  point: comment=acc_y_comb[23]:0->1 hier=IIR
+000916  point: comment=acc_y_comb[23]:1->0 hier=IIR
+000919  point: comment=acc_y_comb[24]:0->1 hier=IIR
+000916  point: comment=acc_y_comb[24]:1->0 hier=IIR
+000927  point: comment=acc_y_comb[25]:0->1 hier=IIR
+000924  point: comment=acc_y_comb[25]:1->0 hier=IIR
+000953  point: comment=acc_y_comb[26]:0->1 hier=IIR
+000949  point: comment=acc_y_comb[26]:1->0 hier=IIR
+000907  point: comment=acc_y_comb[27]:0->1 hier=IIR
+000902  point: comment=acc_y_comb[27]:1->0 hier=IIR
+000914  point: comment=acc_y_comb[28]:0->1 hier=IIR
+000910  point: comment=acc_y_comb[28]:1->0 hier=IIR
+000909  point: comment=acc_y_comb[29]:0->1 hier=IIR
+000906  point: comment=acc_y_comb[29]:1->0 hier=IIR
+000894  point: comment=acc_y_comb[2]:0->1 hier=IIR
+000891  point: comment=acc_y_comb[2]:1->0 hier=IIR
+000899  point: comment=acc_y_comb[30]:0->1 hier=IIR
+000897  point: comment=acc_y_comb[30]:1->0 hier=IIR
+000925  point: comment=acc_y_comb[31]:0->1 hier=IIR
+000923  point: comment=acc_y_comb[31]:1->0 hier=IIR
+000929  point: comment=acc_y_comb[32]:0->1 hier=IIR
+000926  point: comment=acc_y_comb[32]:1->0 hier=IIR
+000937  point: comment=acc_y_comb[33]:0->1 hier=IIR
+000933  point: comment=acc_y_comb[33]:1->0 hier=IIR
+000907  point: comment=acc_y_comb[34]:0->1 hier=IIR
+000905  point: comment=acc_y_comb[34]:1->0 hier=IIR
+000920  point: comment=acc_y_comb[35]:0->1 hier=IIR
+000917  point: comment=acc_y_comb[35]:1->0 hier=IIR
+000915  point: comment=acc_y_comb[36]:0->1 hier=IIR
+000913  point: comment=acc_y_comb[36]:1->0 hier=IIR
+000926  point: comment=acc_y_comb[37]:0->1 hier=IIR
+000922  point: comment=acc_y_comb[37]:1->0 hier=IIR
+000911  point: comment=acc_y_comb[38]:0->1 hier=IIR
+000909  point: comment=acc_y_comb[38]:1->0 hier=IIR
+000915  point: comment=acc_y_comb[39]:0->1 hier=IIR
+000912  point: comment=acc_y_comb[39]:1->0 hier=IIR
+000929  point: comment=acc_y_comb[3]:0->1 hier=IIR
+000928  point: comment=acc_y_comb[3]:1->0 hier=IIR
+000939  point: comment=acc_y_comb[40]:0->1 hier=IIR
+000937  point: comment=acc_y_comb[40]:1->0 hier=IIR
+000917  point: comment=acc_y_comb[41]:0->1 hier=IIR
+000914  point: comment=acc_y_comb[41]:1->0 hier=IIR
+000921  point: comment=acc_y_comb[42]:0->1 hier=IIR
+000919  point: comment=acc_y_comb[42]:1->0 hier=IIR
+000909  point: comment=acc_y_comb[43]:0->1 hier=IIR
+000907  point: comment=acc_y_comb[43]:1->0 hier=IIR
+000888  point: comment=acc_y_comb[44]:0->1 hier=IIR
+000883  point: comment=acc_y_comb[44]:1->0 hier=IIR
+000920  point: comment=acc_y_comb[45]:0->1 hier=IIR
+000917  point: comment=acc_y_comb[45]:1->0 hier=IIR
+000889  point: comment=acc_y_comb[46]:0->1 hier=IIR
+000887  point: comment=acc_y_comb[46]:1->0 hier=IIR
+000911  point: comment=acc_y_comb[47]:0->1 hier=IIR
+000908  point: comment=acc_y_comb[47]:1->0 hier=IIR
+000907  point: comment=acc_y_comb[48]:0->1 hier=IIR
+000905  point: comment=acc_y_comb[48]:1->0 hier=IIR
+000892  point: comment=acc_y_comb[49]:0->1 hier=IIR
+000891  point: comment=acc_y_comb[49]:1->0 hier=IIR
+000948  point: comment=acc_y_comb[4]:0->1 hier=IIR
+000946  point: comment=acc_y_comb[4]:1->0 hier=IIR
+000942  point: comment=acc_y_comb[50]:0->1 hier=IIR
+000940  point: comment=acc_y_comb[50]:1->0 hier=IIR
+000893  point: comment=acc_y_comb[51]:0->1 hier=IIR
+000889  point: comment=acc_y_comb[51]:1->0 hier=IIR
+000891  point: comment=acc_y_comb[52]:0->1 hier=IIR
+000888  point: comment=acc_y_comb[52]:1->0 hier=IIR
+000932  point: comment=acc_y_comb[53]:0->1 hier=IIR
+000930  point: comment=acc_y_comb[53]:1->0 hier=IIR
+000899  point: comment=acc_y_comb[54]:0->1 hier=IIR
+000897  point: comment=acc_y_comb[54]:1->0 hier=IIR
+000935  point: comment=acc_y_comb[55]:0->1 hier=IIR
+000932  point: comment=acc_y_comb[55]:1->0 hier=IIR
+001066  point: comment=acc_y_comb[56]:0->1 hier=IIR
+001063  point: comment=acc_y_comb[56]:1->0 hier=IIR
+001066  point: comment=acc_y_comb[57]:0->1 hier=IIR
+001063  point: comment=acc_y_comb[57]:1->0 hier=IIR
+001066  point: comment=acc_y_comb[58]:0->1 hier=IIR
+001063  point: comment=acc_y_comb[58]:1->0 hier=IIR
+000908  point: comment=acc_y_comb[5]:0->1 hier=IIR
+000907  point: comment=acc_y_comb[5]:1->0 hier=IIR
+000921  point: comment=acc_y_comb[6]:0->1 hier=IIR
+000919  point: comment=acc_y_comb[6]:1->0 hier=IIR
+000912  point: comment=acc_y_comb[7]:0->1 hier=IIR
+000911  point: comment=acc_y_comb[7]:1->0 hier=IIR
+000899  point: comment=acc_y_comb[8]:0->1 hier=IIR
+000896  point: comment=acc_y_comb[8]:1->0 hier=IIR
+000886  point: comment=acc_y_comb[9]:0->1 hier=IIR
+000885  point: comment=acc_y_comb[9]:1->0 hier=IIR
 001116    logic signed [RES_ACC_WIDTH:0]  acc_res;
+000960  point: comment=acc_res[0]:0->1 hier=IIR
+000957  point: comment=acc_res[0]:1->0 hier=IIR
+001019  point: comment=acc_res[10]:0->1 hier=IIR
+001018  point: comment=acc_res[10]:1->0 hier=IIR
+001003  point: comment=acc_res[11]:0->1 hier=IIR
+001001  point: comment=acc_res[11]:1->0 hier=IIR
+001005  point: comment=acc_res[12]:0->1 hier=IIR
+001002  point: comment=acc_res[12]:1->0 hier=IIR
+001028  point: comment=acc_res[13]:0->1 hier=IIR
+001026  point: comment=acc_res[13]:1->0 hier=IIR
+001032  point: comment=acc_res[14]:0->1 hier=IIR
+001030  point: comment=acc_res[14]:1->0 hier=IIR
+000995  point: comment=acc_res[15]:0->1 hier=IIR
+000993  point: comment=acc_res[15]:1->0 hier=IIR
+000984  point: comment=acc_res[16]:0->1 hier=IIR
+000983  point: comment=acc_res[16]:1->0 hier=IIR
+001008  point: comment=acc_res[17]:0->1 hier=IIR
+001007  point: comment=acc_res[17]:1->0 hier=IIR
+001055  point: comment=acc_res[18]:0->1 hier=IIR
+001054  point: comment=acc_res[18]:1->0 hier=IIR
+001035  point: comment=acc_res[19]:0->1 hier=IIR
+001031  point: comment=acc_res[19]:1->0 hier=IIR
+000999  point: comment=acc_res[1]:0->1 hier=IIR
+000997  point: comment=acc_res[1]:1->0 hier=IIR
+001039  point: comment=acc_res[20]:0->1 hier=IIR
+001038  point: comment=acc_res[20]:1->0 hier=IIR
+001032  point: comment=acc_res[21]:0->1 hier=IIR
+001031  point: comment=acc_res[21]:1->0 hier=IIR
+001034  point: comment=acc_res[22]:0->1 hier=IIR
+001032  point: comment=acc_res[22]:1->0 hier=IIR
+001039  point: comment=acc_res[23]:0->1 hier=IIR
+001037  point: comment=acc_res[23]:1->0 hier=IIR
+001031  point: comment=acc_res[24]:0->1 hier=IIR
+001027  point: comment=acc_res[24]:1->0 hier=IIR
+001042  point: comment=acc_res[25]:0->1 hier=IIR
+001039  point: comment=acc_res[25]:1->0 hier=IIR
+001035  point: comment=acc_res[26]:0->1 hier=IIR
+001032  point: comment=acc_res[26]:1->0 hier=IIR
+001008  point: comment=acc_res[27]:0->1 hier=IIR
+001005  point: comment=acc_res[27]:1->0 hier=IIR
+001026  point: comment=acc_res[28]:0->1 hier=IIR
+001024  point: comment=acc_res[28]:1->0 hier=IIR
+001037  point: comment=acc_res[29]:0->1 hier=IIR
+001033  point: comment=acc_res[29]:1->0 hier=IIR
+001051  point: comment=acc_res[2]:0->1 hier=IIR
+001047  point: comment=acc_res[2]:1->0 hier=IIR
+001029  point: comment=acc_res[30]:0->1 hier=IIR
+001027  point: comment=acc_res[30]:1->0 hier=IIR
+001088  point: comment=acc_res[31]:0->1 hier=IIR
+001087  point: comment=acc_res[31]:1->0 hier=IIR
+001065  point: comment=acc_res[32]:0->1 hier=IIR
+001061  point: comment=acc_res[32]:1->0 hier=IIR
+001087  point: comment=acc_res[33]:0->1 hier=IIR
+001083  point: comment=acc_res[33]:1->0 hier=IIR
+001116  point: comment=acc_res[34]:0->1 hier=IIR
+001114  point: comment=acc_res[34]:1->0 hier=IIR
+001082  point: comment=acc_res[35]:0->1 hier=IIR
+001077  point: comment=acc_res[35]:1->0 hier=IIR
+001080  point: comment=acc_res[36]:0->1 hier=IIR
+001076  point: comment=acc_res[36]:1->0 hier=IIR
+001064  point: comment=acc_res[37]:0->1 hier=IIR
+001063  point: comment=acc_res[37]:1->0 hier=IIR
+001090  point: comment=acc_res[38]:0->1 hier=IIR
+001086  point: comment=acc_res[38]:1->0 hier=IIR
+001051  point: comment=acc_res[39]:0->1 hier=IIR
+001048  point: comment=acc_res[39]:1->0 hier=IIR
+001052  point: comment=acc_res[3]:0->1 hier=IIR
+001050  point: comment=acc_res[3]:1->0 hier=IIR
+001061  point: comment=acc_res[40]:0->1 hier=IIR
+001057  point: comment=acc_res[40]:1->0 hier=IIR
+001073  point: comment=acc_res[41]:0->1 hier=IIR
+001068  point: comment=acc_res[41]:1->0 hier=IIR
+001092  point: comment=acc_res[42]:0->1 hier=IIR
+001088  point: comment=acc_res[42]:1->0 hier=IIR
+001089  point: comment=acc_res[43]:0->1 hier=IIR
+001084  point: comment=acc_res[43]:1->0 hier=IIR
+001042  point: comment=acc_res[44]:0->1 hier=IIR
+001038  point: comment=acc_res[44]:1->0 hier=IIR
+001045  point: comment=acc_res[45]:0->1 hier=IIR
+001043  point: comment=acc_res[45]:1->0 hier=IIR
+001084  point: comment=acc_res[46]:0->1 hier=IIR
+001080  point: comment=acc_res[46]:1->0 hier=IIR
+001067  point: comment=acc_res[47]:0->1 hier=IIR
+001065  point: comment=acc_res[47]:1->0 hier=IIR
+001081  point: comment=acc_res[48]:0->1 hier=IIR
+001076  point: comment=acc_res[48]:1->0 hier=IIR
+001066  point: comment=acc_res[49]:0->1 hier=IIR
+001063  point: comment=acc_res[49]:1->0 hier=IIR
+001029  point: comment=acc_res[4]:0->1 hier=IIR
+001028  point: comment=acc_res[4]:1->0 hier=IIR
+001056  point: comment=acc_res[50]:0->1 hier=IIR
+001052  point: comment=acc_res[50]:1->0 hier=IIR
+001063  point: comment=acc_res[51]:0->1 hier=IIR
+001059  point: comment=acc_res[51]:1->0 hier=IIR
+001079  point: comment=acc_res[52]:0->1 hier=IIR
+001078  point: comment=acc_res[52]:1->0 hier=IIR
+001074  point: comment=acc_res[53]:0->1 hier=IIR
+001070  point: comment=acc_res[53]:1->0 hier=IIR
+001114  point: comment=acc_res[54]:0->1 hier=IIR
+001113  point: comment=acc_res[54]:1->0 hier=IIR
+001078  point: comment=acc_res[55]:0->1 hier=IIR
+001076  point: comment=acc_res[55]:1->0 hier=IIR
+001077  point: comment=acc_res[56]:0->1 hier=IIR
+001075  point: comment=acc_res[56]:1->0 hier=IIR
+001077  point: comment=acc_res[57]:0->1 hier=IIR
+001075  point: comment=acc_res[57]:1->0 hier=IIR
+001077  point: comment=acc_res[58]:0->1 hier=IIR
+001075  point: comment=acc_res[58]:1->0 hier=IIR
+001077  point: comment=acc_res[59]:0->1 hier=IIR
+001075  point: comment=acc_res[59]:1->0 hier=IIR
+001025  point: comment=acc_res[5]:0->1 hier=IIR
+001023  point: comment=acc_res[5]:1->0 hier=IIR
+001077  point: comment=acc_res[60]:0->1 hier=IIR
+001075  point: comment=acc_res[60]:1->0 hier=IIR
+001077  point: comment=acc_res[61]:0->1 hier=IIR
+001075  point: comment=acc_res[61]:1->0 hier=IIR
+001015  point: comment=acc_res[6]:0->1 hier=IIR
+001012  point: comment=acc_res[6]:1->0 hier=IIR
+001015  point: comment=acc_res[7]:0->1 hier=IIR
+001014  point: comment=acc_res[7]:1->0 hier=IIR
+000977  point: comment=acc_res[8]:0->1 hier=IIR
+000976  point: comment=acc_res[8]:1->0 hier=IIR
+001028  point: comment=acc_res[9]:0->1 hier=IIR
+001026  point: comment=acc_res[9]:1->0 hier=IIR
 001114    logic signed [RES_ACC_WIDTH:0]  acc_res_rounded;
+000960  point: comment=acc_res_rounded[0]:0->1 hier=IIR
+000957  point: comment=acc_res_rounded[0]:1->0 hier=IIR
+001019  point: comment=acc_res_rounded[10]:0->1 hier=IIR
+001018  point: comment=acc_res_rounded[10]:1->0 hier=IIR
+001003  point: comment=acc_res_rounded[11]:0->1 hier=IIR
+001001  point: comment=acc_res_rounded[11]:1->0 hier=IIR
+001005  point: comment=acc_res_rounded[12]:0->1 hier=IIR
+001002  point: comment=acc_res_rounded[12]:1->0 hier=IIR
+001028  point: comment=acc_res_rounded[13]:0->1 hier=IIR
+001026  point: comment=acc_res_rounded[13]:1->0 hier=IIR
+001032  point: comment=acc_res_rounded[14]:0->1 hier=IIR
+001030  point: comment=acc_res_rounded[14]:1->0 hier=IIR
+000995  point: comment=acc_res_rounded[15]:0->1 hier=IIR
+000993  point: comment=acc_res_rounded[15]:1->0 hier=IIR
+000984  point: comment=acc_res_rounded[16]:0->1 hier=IIR
+000983  point: comment=acc_res_rounded[16]:1->0 hier=IIR
+001008  point: comment=acc_res_rounded[17]:0->1 hier=IIR
+001007  point: comment=acc_res_rounded[17]:1->0 hier=IIR
+001055  point: comment=acc_res_rounded[18]:0->1 hier=IIR
+001054  point: comment=acc_res_rounded[18]:1->0 hier=IIR
+001035  point: comment=acc_res_rounded[19]:0->1 hier=IIR
+001031  point: comment=acc_res_rounded[19]:1->0 hier=IIR
+000999  point: comment=acc_res_rounded[1]:0->1 hier=IIR
+000997  point: comment=acc_res_rounded[1]:1->0 hier=IIR
+001039  point: comment=acc_res_rounded[20]:0->1 hier=IIR
+001038  point: comment=acc_res_rounded[20]:1->0 hier=IIR
+001032  point: comment=acc_res_rounded[21]:0->1 hier=IIR
+001031  point: comment=acc_res_rounded[21]:1->0 hier=IIR
+001034  point: comment=acc_res_rounded[22]:0->1 hier=IIR
+001032  point: comment=acc_res_rounded[22]:1->0 hier=IIR
+001039  point: comment=acc_res_rounded[23]:0->1 hier=IIR
+001037  point: comment=acc_res_rounded[23]:1->0 hier=IIR
+001031  point: comment=acc_res_rounded[24]:0->1 hier=IIR
+001027  point: comment=acc_res_rounded[24]:1->0 hier=IIR
+001042  point: comment=acc_res_rounded[25]:0->1 hier=IIR
+001039  point: comment=acc_res_rounded[25]:1->0 hier=IIR
+001035  point: comment=acc_res_rounded[26]:0->1 hier=IIR
+001032  point: comment=acc_res_rounded[26]:1->0 hier=IIR
+001008  point: comment=acc_res_rounded[27]:0->1 hier=IIR
+001005  point: comment=acc_res_rounded[27]:1->0 hier=IIR
+001026  point: comment=acc_res_rounded[28]:0->1 hier=IIR
+001024  point: comment=acc_res_rounded[28]:1->0 hier=IIR
+001037  point: comment=acc_res_rounded[29]:0->1 hier=IIR
+001033  point: comment=acc_res_rounded[29]:1->0 hier=IIR
+001051  point: comment=acc_res_rounded[2]:0->1 hier=IIR
+001047  point: comment=acc_res_rounded[2]:1->0 hier=IIR
+001034  point: comment=acc_res_rounded[30]:0->1 hier=IIR
+001029  point: comment=acc_res_rounded[30]:1->0 hier=IIR
+001081  point: comment=acc_res_rounded[31]:0->1 hier=IIR
+001078  point: comment=acc_res_rounded[31]:1->0 hier=IIR
+001114  point: comment=acc_res_rounded[32]:0->1 hier=IIR
+001110  point: comment=acc_res_rounded[32]:1->0 hier=IIR
+001097  point: comment=acc_res_rounded[33]:0->1 hier=IIR
+001093  point: comment=acc_res_rounded[33]:1->0 hier=IIR
+001114  point: comment=acc_res_rounded[34]:0->1 hier=IIR
+001112  point: comment=acc_res_rounded[34]:1->0 hier=IIR
+001071  point: comment=acc_res_rounded[35]:0->1 hier=IIR
+001066  point: comment=acc_res_rounded[35]:1->0 hier=IIR
+001082  point: comment=acc_res_rounded[36]:0->1 hier=IIR
+001078  point: comment=acc_res_rounded[36]:1->0 hier=IIR
+001052  point: comment=acc_res_rounded[37]:0->1 hier=IIR
+001051  point: comment=acc_res_rounded[37]:1->0 hier=IIR
+001092  point: comment=acc_res_rounded[38]:0->1 hier=IIR
+001088  point: comment=acc_res_rounded[38]:1->0 hier=IIR
+001049  point: comment=acc_res_rounded[39]:0->1 hier=IIR
+001046  point: comment=acc_res_rounded[39]:1->0 hier=IIR
+001052  point: comment=acc_res_rounded[3]:0->1 hier=IIR
+001050  point: comment=acc_res_rounded[3]:1->0 hier=IIR
+001061  point: comment=acc_res_rounded[40]:0->1 hier=IIR
+001057  point: comment=acc_res_rounded[40]:1->0 hier=IIR
+001073  point: comment=acc_res_rounded[41]:0->1 hier=IIR
+001068  point: comment=acc_res_rounded[41]:1->0 hier=IIR
+001092  point: comment=acc_res_rounded[42]:0->1 hier=IIR
+001088  point: comment=acc_res_rounded[42]:1->0 hier=IIR
+001089  point: comment=acc_res_rounded[43]:0->1 hier=IIR
+001084  point: comment=acc_res_rounded[43]:1->0 hier=IIR
+001042  point: comment=acc_res_rounded[44]:0->1 hier=IIR
+001038  point: comment=acc_res_rounded[44]:1->0 hier=IIR
+001045  point: comment=acc_res_rounded[45]:0->1 hier=IIR
+001043  point: comment=acc_res_rounded[45]:1->0 hier=IIR
+001084  point: comment=acc_res_rounded[46]:0->1 hier=IIR
+001080  point: comment=acc_res_rounded[46]:1->0 hier=IIR
+001067  point: comment=acc_res_rounded[47]:0->1 hier=IIR
+001065  point: comment=acc_res_rounded[47]:1->0 hier=IIR
+001081  point: comment=acc_res_rounded[48]:0->1 hier=IIR
+001076  point: comment=acc_res_rounded[48]:1->0 hier=IIR
+001066  point: comment=acc_res_rounded[49]:0->1 hier=IIR
+001063  point: comment=acc_res_rounded[49]:1->0 hier=IIR
+001029  point: comment=acc_res_rounded[4]:0->1 hier=IIR
+001028  point: comment=acc_res_rounded[4]:1->0 hier=IIR
+001056  point: comment=acc_res_rounded[50]:0->1 hier=IIR
+001052  point: comment=acc_res_rounded[50]:1->0 hier=IIR
+001063  point: comment=acc_res_rounded[51]:0->1 hier=IIR
+001059  point: comment=acc_res_rounded[51]:1->0 hier=IIR
+001079  point: comment=acc_res_rounded[52]:0->1 hier=IIR
+001078  point: comment=acc_res_rounded[52]:1->0 hier=IIR
+001074  point: comment=acc_res_rounded[53]:0->1 hier=IIR
+001070  point: comment=acc_res_rounded[53]:1->0 hier=IIR
+001114  point: comment=acc_res_rounded[54]:0->1 hier=IIR
+001113  point: comment=acc_res_rounded[54]:1->0 hier=IIR
+001078  point: comment=acc_res_rounded[55]:0->1 hier=IIR
+001076  point: comment=acc_res_rounded[55]:1->0 hier=IIR
+001077  point: comment=acc_res_rounded[56]:0->1 hier=IIR
+001075  point: comment=acc_res_rounded[56]:1->0 hier=IIR
+001077  point: comment=acc_res_rounded[57]:0->1 hier=IIR
+001075  point: comment=acc_res_rounded[57]:1->0 hier=IIR
+001077  point: comment=acc_res_rounded[58]:0->1 hier=IIR
+001075  point: comment=acc_res_rounded[58]:1->0 hier=IIR
+001077  point: comment=acc_res_rounded[59]:0->1 hier=IIR
+001075  point: comment=acc_res_rounded[59]:1->0 hier=IIR
+001025  point: comment=acc_res_rounded[5]:0->1 hier=IIR
+001023  point: comment=acc_res_rounded[5]:1->0 hier=IIR
+001077  point: comment=acc_res_rounded[60]:0->1 hier=IIR
+001075  point: comment=acc_res_rounded[60]:1->0 hier=IIR
+001077  point: comment=acc_res_rounded[61]:0->1 hier=IIR
+001075  point: comment=acc_res_rounded[61]:1->0 hier=IIR
+001015  point: comment=acc_res_rounded[6]:0->1 hier=IIR
+001012  point: comment=acc_res_rounded[6]:1->0 hier=IIR
+001015  point: comment=acc_res_rounded[7]:0->1 hier=IIR
+001014  point: comment=acc_res_rounded[7]:1->0 hier=IIR
+000977  point: comment=acc_res_rounded[8]:0->1 hier=IIR
+000976  point: comment=acc_res_rounded[8]:1->0 hier=IIR
+001028  point: comment=acc_res_rounded[9]:0->1 hier=IIR
+001026  point: comment=acc_res_rounded[9]:1->0 hier=IIR
        
 004005    logic                           tap_en;
+004005  point: comment=tap_en:0->1 hier=IIR
+004005  point: comment=tap_en:1->0 hier=IIR
 003522    logic                           output_en;   
+003522  point: comment=output_en:0->1 hier=IIR
+003522  point: comment=output_en:1->0 hier=IIR
        
 001110    logic [DATA_WIDTH-1:0]          y;   
+001080  point: comment=y[0]:0->1 hier=IIR
+001078  point: comment=y[0]:1->0 hier=IIR
+001077  point: comment=y[10]:0->1 hier=IIR
+001072  point: comment=y[10]:1->0 hier=IIR
+001093  point: comment=y[11]:0->1 hier=IIR
+001090  point: comment=y[11]:1->0 hier=IIR
+001084  point: comment=y[12]:0->1 hier=IIR
+001080  point: comment=y[12]:1->0 hier=IIR
+001028  point: comment=y[13]:0->1 hier=IIR
+001025  point: comment=y[13]:1->0 hier=IIR
+001043  point: comment=y[14]:0->1 hier=IIR
+001042  point: comment=y[14]:1->0 hier=IIR
+001092  point: comment=y[15]:0->1 hier=IIR
+001089  point: comment=y[15]:1->0 hier=IIR
+001070  point: comment=y[16]:0->1 hier=IIR
+001069  point: comment=y[16]:1->0 hier=IIR
+001084  point: comment=y[17]:0->1 hier=IIR
+001080  point: comment=y[17]:1->0 hier=IIR
+001065  point: comment=y[18]:0->1 hier=IIR
+001063  point: comment=y[18]:1->0 hier=IIR
+001077  point: comment=y[19]:0->1 hier=IIR
+001074  point: comment=y[19]:1->0 hier=IIR
+001099  point: comment=y[1]:0->1 hier=IIR
+001096  point: comment=y[1]:1->0 hier=IIR
+001061  point: comment=y[20]:0->1 hier=IIR
+001058  point: comment=y[20]:1->0 hier=IIR
+001078  point: comment=y[21]:0->1 hier=IIR
+001078  point: comment=y[21]:1->0 hier=IIR
+001065  point: comment=y[22]:0->1 hier=IIR
+001062  point: comment=y[22]:1->0 hier=IIR
+001077  point: comment=y[23]:0->1 hier=IIR
+001075  point: comment=y[23]:1->0 hier=IIR
+001101  point: comment=y[2]:0->1 hier=IIR
+001098  point: comment=y[2]:1->0 hier=IIR
+001110  point: comment=y[3]:0->1 hier=IIR
+001109  point: comment=y[3]:1->0 hier=IIR
+001069  point: comment=y[4]:0->1 hier=IIR
+001065  point: comment=y[4]:1->0 hier=IIR
+001086  point: comment=y[5]:0->1 hier=IIR
+001082  point: comment=y[5]:1->0 hier=IIR
+001055  point: comment=y[6]:0->1 hier=IIR
+001055  point: comment=y[6]:1->0 hier=IIR
+001083  point: comment=y[7]:0->1 hier=IIR
+001080  point: comment=y[7]:1->0 hier=IIR
+001052  point: comment=y[8]:0->1 hier=IIR
+001050  point: comment=y[8]:1->0 hier=IIR
+001063  point: comment=y[9]:0->1 hier=IIR
+001059  point: comment=y[9]:1->0 hier=IIR
 001027    logic [DATA_WIDTH-1:0]          y_tap;   
+000988  point: comment=y_tap[0]:0->1 hier=IIR
+000987  point: comment=y_tap[0]:1->0 hier=IIR
+000987  point: comment=y_tap[10]:0->1 hier=IIR
+000983  point: comment=y_tap[10]:1->0 hier=IIR
+001003  point: comment=y_tap[11]:0->1 hier=IIR
+001000  point: comment=y_tap[11]:1->0 hier=IIR
+000997  point: comment=y_tap[12]:0->1 hier=IIR
+000993  point: comment=y_tap[12]:1->0 hier=IIR
+000952  point: comment=y_tap[13]:0->1 hier=IIR
+000950  point: comment=y_tap[13]:1->0 hier=IIR
+000959  point: comment=y_tap[14]:0->1 hier=IIR
+000959  point: comment=y_tap[14]:1->0 hier=IIR
+001005  point: comment=y_tap[15]:0->1 hier=IIR
+001003  point: comment=y_tap[15]:1->0 hier=IIR
+000979  point: comment=y_tap[16]:0->1 hier=IIR
+000978  point: comment=y_tap[16]:1->0 hier=IIR
+001011  point: comment=y_tap[17]:0->1 hier=IIR
+001007  point: comment=y_tap[17]:1->0 hier=IIR
+000978  point: comment=y_tap[18]:0->1 hier=IIR
+000976  point: comment=y_tap[18]:1->0 hier=IIR
+000990  point: comment=y_tap[19]:0->1 hier=IIR
+000987  point: comment=y_tap[19]:1->0 hier=IIR
+001014  point: comment=y_tap[1]:0->1 hier=IIR
+001011  point: comment=y_tap[1]:1->0 hier=IIR
+000984  point: comment=y_tap[20]:0->1 hier=IIR
+000981  point: comment=y_tap[20]:1->0 hier=IIR
+000989  point: comment=y_tap[21]:0->1 hier=IIR
+000989  point: comment=y_tap[21]:1->0 hier=IIR
+000978  point: comment=y_tap[22]:0->1 hier=IIR
+000975  point: comment=y_tap[22]:1->0 hier=IIR
+000994  point: comment=y_tap[23]:0->1 hier=IIR
+000992  point: comment=y_tap[23]:1->0 hier=IIR
+001027  point: comment=y_tap[2]:0->1 hier=IIR
+001024  point: comment=y_tap[2]:1->0 hier=IIR
+001018  point: comment=y_tap[3]:0->1 hier=IIR
+001016  point: comment=y_tap[3]:1->0 hier=IIR
+000992  point: comment=y_tap[4]:0->1 hier=IIR
+000988  point: comment=y_tap[4]:1->0 hier=IIR
+000992  point: comment=y_tap[5]:0->1 hier=IIR
+000989  point: comment=y_tap[5]:1->0 hier=IIR
+000988  point: comment=y_tap[6]:0->1 hier=IIR
+000986  point: comment=y_tap[6]:1->0 hier=IIR
+000993  point: comment=y_tap[7]:0->1 hier=IIR
+000991  point: comment=y_tap[7]:1->0 hier=IIR
+000979  point: comment=y_tap[8]:0->1 hier=IIR
+000978  point: comment=y_tap[8]:1->0 hier=IIR
+000986  point: comment=y_tap[9]:0->1 hier=IIR
+000981  point: comment=y_tap[9]:1->0 hier=IIR
        
           typedef enum bit [1:0] {IDLE, PROCESS, STORE} state_t;
 003832    state_t  state;
+003832  point: comment=state[0]:0->1 hier=IIR
+003826  point: comment=state[0]:1->0 hier=IIR
+003522  point: comment=state[1]:0->1 hier=IIR
+003522  point: comment=state[1]:1->0 hier=IIR
 004005    state_t  next_state;
+004005  point: comment=next_state[0]:0->1 hier=IIR
+004003  point: comment=next_state[0]:1->0 hier=IIR
+003595  point: comment=next_state[1]:0->1 hier=IIR
+003591  point: comment=next_state[1]:1->0 hier=IIR
 005333    logic process_done;   
+005333  point: comment=process_done:0->1 hier=IIR
+005328  point: comment=process_done:1->0 hier=IIR
        
           // Data path
           genvar i;
           
           generate
        
 011496       for (i=0; i<INPUT_TAPS; i++) begin :  input_taps
+002475  point: comment=elsif hier=IIR
+011496  point: comment=if hier=IIR
+003832  point: comment=if hier=IIR
+007664  point: comment=else hier=IIR
 086553          always_ff @ (posedge clk_i) begin
+086553  point: comment=block hier=IIR
 002475             if (reset_i) begin             
+002475  point: comment=elsif hier=IIR
 002475                input_tap[i] <= '0;
+002475  point: comment=elsif hier=IIR
 002475                coeff_x[i] <= '0;
+002475  point: comment=elsif hier=IIR
                    end
 072582             else if (tap_en) begin
+011496  point: comment=if hier=IIR
+072582  point: comment=else hier=IIR
 011496                coeff_x[i] <= coeff_x_i[i];
+011496  point: comment=if hier=IIR
 007664                if (i == '0)
+003832  point: comment=if hier=IIR
+007664  point: comment=else hier=IIR
 003832                  input_tap [i] <= x_i;
+003832  point: comment=if hier=IIR
                       else
 007664                  input_tap [i] <= input_tap[i-1];
+007664  point: comment=else hier=IIR
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
 172848    always_comb begin
+172848  point: comment=block hier=IIR
 172848       acc_x_comb = '0;   
+172848  point: comment=block hier=IIR
 518544       for (int i=0; i<INPUT_TAPS; i++) begin
+172848  point: comment=block hier=IIR
+518544  point: comment=block hier=IIR
 518544          acc_x_comb += multi_prod_x[i];
+518544  point: comment=block hier=IIR
              end
           end
           /* verilator lint_on WIDTHEXPAND */
        
           generate
        
 007664       for (i=0; i<OUTPUT_TAPS; i++) begin :  output_taps
+001650  point: comment=elsif hier=IIR
+007664  point: comment=if hier=IIR
+003832  point: comment=if hier=IIR
+003832  point: comment=else hier=IIR
 057702          always_ff @ (posedge clk_i) begin
+057702  point: comment=block hier=IIR
 001650             if (reset_i) begin             
+001650  point: comment=elsif hier=IIR
 001650                output_tap[i] <= '0;
+001650  point: comment=elsif hier=IIR
 001650                coeff_y[i] <= '0;
+001650  point: comment=elsif hier=IIR
                    end
 048388             else if (tap_en) begin
+007664  point: comment=if hier=IIR
+048388  point: comment=else hier=IIR
 007664                coeff_y[i] <= coeff_y_i[i];            
+007664  point: comment=if hier=IIR
 003832                if (i == '0)
+003832  point: comment=if hier=IIR
+003832  point: comment=else hier=IIR
 003832                  output_tap [i] <= y_tap;
+003832  point: comment=if hier=IIR
                       else
 003832                  output_tap [i] <= output_tap[i-1];
+003832  point: comment=else hier=IIR
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
        
 172848    always_comb begin
+172848  point: comment=block hier=IIR
 172848       acc_y_comb = '0;   
+172848  point: comment=block hier=IIR
 345696       for (int i=0; i<OUTPUT_TAPS; i++) begin
+172848  point: comment=block hier=IIR
+345696  point: comment=block hier=IIR
 345696          acc_y_comb += multi_prod_y[i];
+345696  point: comment=block hier=IIR
              end
           end
        
           // This part is adding one pipeline stage therefore PROCESS_DELAY += 1
 028851    always_ff @(posedge clk_i) begin
+028851  point: comment=block hier=IIR
 028026       if (reset_i) begin
+000825  point: comment=if hier=IIR
+028026  point: comment=else hier=IIR
 000825          acc_x_reg <= '0;
+000825  point: comment=if hier=IIR
 000825          acc_y_reg <= '0;
+000825  point: comment=if hier=IIR
 000825          y_tap <= '0;      
+000825  point: comment=if hier=IIR
              end
 028026       else begin
+028026  point: comment=else hier=IIR
 014265          if(state == PROCESS) begin
+014265  point: comment=if hier=IIR
+013761  point: comment=else hier=IIR
 014265             acc_x_reg <= acc_x_comb;
+014265  point: comment=if hier=IIR
 014265             acc_y_reg <= acc_y_comb;
+014265  point: comment=if hier=IIR
                 end
 024573          if (output_en)
+003453  point: comment=if hier=IIR
+024573  point: comment=else hier=IIR
 003453            y_tap <= y;         
+003453  point: comment=if hier=IIR
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
 172848    always_comb begin
+172848  point: comment=block hier=IIR
              // Checking to see if the sign bits are uniform or not
 165579       if (&acc_res_rounded[RES_ACC_WIDTH:(FRAC_WIDTH+DATA_WIDTH-1)] != |acc_res_rounded[RES_ACC_WIDTH:(FRAC_WIDTH+DATA_WIDTH-1)]) begin
+101230  point: comment=(acc_res_rounded[61:54][0]==0) => 0 hier=IIR
+067999  point: comment=(acc_res_rounded[61:54][0]==1 && acc_res_rounded[61:54][1]==1 && acc_res_rounded[61:54][2]==1 && acc_res_rounded[61:54][3]==1 && acc_res_rounded[61:54][4]==1 && acc_res_rounded[61:54][5]==1 && acc_res_rounded[61:54][6]==1 && acc_res_rounded[61:54][7]==1) => 1 hier=IIR
+101199  point: comment=(acc_res_rounded[61:54][1]==0) => 0 hier=IIR
+101268  point: comment=(acc_res_rounded[61:54][2]==0) => 0 hier=IIR
+101268  point: comment=(acc_res_rounded[61:54][3]==0) => 0 hier=IIR
+101268  point: comment=(acc_res_rounded[61:54][4]==0) => 0 hier=IIR
+101268  point: comment=(acc_res_rounded[61:54][5]==0) => 0 hier=IIR
+101268  point: comment=(acc_res_rounded[61:54][6]==0) => 0 hier=IIR
+101268  point: comment=(acc_res_rounded[61:54][7]==0) => 0 hier=IIR
+007269  point: comment=if hier=IIR
+097580  point: comment=(acc_res_rounded[61:54][0]==0 && acc_res_rounded[61:54][1]==0 && acc_res_rounded[61:54][2]==0 && acc_res_rounded[61:54][3]==0 && acc_res_rounded[61:54][4]==0 && acc_res_rounded[61:54][5]==0 && acc_res_rounded[61:54][6]==0 && acc_res_rounded[61:54][7]==0) => 0 hier=IIR
+071618  point: comment=(acc_res_rounded[61:54][0]==1) => 1 hier=IIR
+071649  point: comment=(acc_res_rounded[61:54][1]==1) => 1 hier=IIR
+071580  point: comment=(acc_res_rounded[61:54][2]==1) => 1 hier=IIR
+071580  point: comment=(acc_res_rounded[61:54][3]==1) => 1 hier=IIR
+071580  point: comment=(acc_res_rounded[61:54][4]==1) => 1 hier=IIR
+071580  point: comment=(acc_res_rounded[61:54][5]==1) => 1 hier=IIR
+071580  point: comment=(acc_res_rounded[61:54][6]==1) => 1 hier=IIR
+071580  point: comment=(acc_res_rounded[61:54][7]==1) => 1 hier=IIR
+165579  point: comment=else hier=IIR
 003688          if(acc_res_rounded[RES_ACC_WIDTH])
+003581  point: comment=if hier=IIR
+003688  point: comment=else hier=IIR
 003581            y  = {1'b1, {(DATA_WIDTH-1){1'b0}}};
+003581  point: comment=if hier=IIR
                 else
 003688            y  = {1'b0, {(DATA_WIDTH-1){1'b1}}};
+003688  point: comment=else hier=IIR
 165579       end else begin
+165579  point: comment=else hier=IIR
 165579          y = acc_res_rounded[FRAC_WIDTH+DATA_WIDTH-1:FRAC_WIDTH];
+165579  point: comment=else hier=IIR
              end
           end
        
           //Control part
 028851    always_ff @(posedge clk_i) begin : FSM
+028851  point: comment=block hier=IIR
 028026       if (reset_i) begin
+000825  point: comment=if hier=IIR
+028026  point: comment=else hier=IIR
 000825          state <= IDLE;
+000825  point: comment=if hier=IIR
              end
 028026       else begin
+028026  point: comment=else hier=IIR
 028026          state <= next_state;         
+028026  point: comment=else hier=IIR
              end
           end  : FSM
        
 172848    always_comb begin
+172848  point: comment=block hier=IIR
              // Default assignments so not get latches
 172848       tap_en = '0;
+172848  point: comment=block hier=IIR
 172848       output_en = '0;      
+172848  point: comment=block hier=IIR
        
 172848       case(state)
+172848  point: comment=block hier=IIR
        
 063807         IDLE: begin
+063807  point: comment=case hier=IIR
 114392            if (valid_i == '1 && ready_and_o == '1) begin
+021789  point: comment=if hier=IIR
+042018  point: comment=else hier=IIR
+114392  point: comment=((ready_and_o == 1'h1)==0) => 0 hier=IIR
+052735  point: comment=((valid_i == 1'h1)==0) => 0 hier=IIR
+021789  point: comment=((valid_i == 1'h1)==1 && (ready_and_o == 1'h1)==1) => 1 hier=IIR
 021789               next_state = PROCESS; // A mealy state for maximum speed hanshake between valid/ready
+021789  point: comment=if hier=IIR
 021789               tap_en = '1;
+021789  point: comment=if hier=IIR
                   end
                   else
 042018              next_state = IDLE;             
+042018  point: comment=else hier=IIR
                end
                
 089022         PROCESS: begin
+089022  point: comment=case hier=IIR
 138989            if (process_done == 1'b1 && valid_o == 1'b0) // If there's an output traffic on the output it will stall the IP here
+020488  point: comment=if hier=IIR
+068534  point: comment=else hier=IIR
+138989  point: comment=((process_done == 1'h1)==0) => 0 hier=IIR
+021297  point: comment=((process_done == 1'h1)==1 && (valid_o == 1'h0)==1) => 1 hier=IIR
+069732  point: comment=((valid_o == 1'h0)==0) => 0 hier=IIR
 020488              next_state = STORE;
+020488  point: comment=if hier=IIR
                   else
 068534              next_state = PROCESS;             
+068534  point: comment=else hier=IIR
                end
        
 020019         STORE: begin
+020019  point: comment=case hier=IIR
 020019            output_en = '1;
+020019  point: comment=case hier=IIR
 020019            next_state = IDLE; 
+020019  point: comment=case hier=IIR
                   end
                // Turning coverage off cause this part is unreachable in simulation but necessary
                /* verilator coverage_off */
                default:
                  next_state = IDLE;
                /* verilator coverage_on */
              endcase
           end // always_comb
        
 028851    always_ff @(posedge clk_i) begin : VALID_O_READY_O
+028851  point: comment=block hier=IIR
 028026       if (reset_i) begin
+000825  point: comment=if hier=IIR
+028026  point: comment=else hier=IIR
 000825          valid_o <= 1'b0;
+000825  point: comment=if hier=IIR
 000825          ready_and_o <= 1'b0;         
+000825  point: comment=if hier=IIR
              end
 028026       else begin
+028026  point: comment=else hier=IIR
 018798          if (valid_o & ready_and_i)
+003187  point: comment=elsif hier=IIR
+018798  point: comment=(ready_and_i==0) => 0 hier=IIR
+016740  point: comment=(valid_o==0) => 0 hier=IIR
+003187  point: comment=(valid_o==1 && ready_and_i==1) => 1 hier=IIR
 003187            valid_o <= 1'b0;
+003187  point: comment=elsif hier=IIR
 021386          else if ((state == STORE))
+003453  point: comment=if hier=IIR
+021386  point: comment=else hier=IIR
 003453            valid_o <= 1'b1;
+003453  point: comment=if hier=IIR
        
 018097          if (next_state == (IDLE) || ((next_state != PROCESS) && (state == (IDLE)))) begin 
+009929  point: comment=if hier=IIR
+018097  point: comment=else hier=IIR
+006476  point: comment=((next_state != PROCESS)==1 && (state == IDLE)==1) => 1 hier=IIR
+014575  point: comment=((next_state == IDLE)==0 && (next_state != PROCESS)==0) => 0 hier=IIR
+014265  point: comment=((next_state == IDLE)==0 && (state == IDLE)==0) => 0 hier=IIR
+009929  point: comment=((next_state == IDLE)==1) => 1 hier=IIR
 009929             ready_and_o <= '1;
+009929  point: comment=if hier=IIR
 018097          end else begin
+018097  point: comment=else hier=IIR
 018097             ready_and_o <= '0;    
+018097  point: comment=else hier=IIR
                 end
              end
           end // block: VALID_O_READY_O
        
        
           generate
              if (PROCESS_DELAY <= 2) begin
                 assign process_done = '1;
              end
              else begin
                 // If the latency of the process state is custom(have used pipeline), then this part helps with generating appropriate done signal
                 typedef logic unsigned [$clog2(PROCESS_DELAY)-1:0] counter_t;   
 007077          counter_t counter;
+007077  point: comment=genblk3.counter[0]:0->1 hier=IIR
+007073  point: comment=genblk3.counter[0]:1->0 hier=IIR
+005224  point: comment=genblk3.counter[1]:0->1 hier=IIR
+005224  point: comment=genblk3.counter[1]:1->0 hier=IIR
 003735          logic cntr_clear, cntr_up;
+003735  point: comment=genblk3.cntr_clear:0->1 hier=IIR
+003734  point: comment=genblk3.cntr_clear:1->0 hier=IIR
+003734  point: comment=genblk3.cntr_up:0->1 hier=IIR
+003729  point: comment=genblk3.cntr_up:1->0 hier=IIR
        
 087290          assign cntr_clear = (state !=  PROCESS) ? 1'b1 : 1'b0;         
+082567  point: comment=cond_then hier=IIR
+087290  point: comment=cond_else hier=IIR
 087290          assign cntr_up = (state ==  PROCESS) ? 1'b1 : 1'b0;         
+087290  point: comment=cond_then hier=IIR
+082567  point: comment=cond_else hier=IIR
        
                 bsg_counter_clear_up #(.max_val_p(PROCESS_DELAY),
                                        .init_val_p(0),
                                        .disable_overflow_warning_p(0))
                 prcoess_delay_cntr(
                                    .clk_i(clk_i),
                                    .reset_i(reset_i),
                                    .clear_i(cntr_clear),
                                    .up_i(cntr_up),
                                    .count_o(counter));         
        
 169857          always_comb begin
+169857  point: comment=block hier=IIR
 138989             if (counter == counter_t'(PROCESS_DELAY-2)) begin
+030868  point: comment=if hier=IIR
+138989  point: comment=else hier=IIR
 030868                process_done = '1;         
+030868  point: comment=if hier=IIR
                    end 
 138989             else begin
+138989  point: comment=else hier=IIR
 138989                process_done = '0;
+138989  point: comment=else hier=IIR
                    end
                 end
              end // else: !if(PROCESS_DELAY <= 2)
           endgenerate
           
        endmodule
        
