from pyuvm import uvm_object, uvm_sequence_item
import vsc
from cfg_pkg import CFG
from ctypes import CDLL, Structure, POINTER, c_int, c_double, byref

# Loading the shared C library
clib = CDLL("./Python_tb/libmylib.so")

# Setting up interaction with C functions
# C struct definition
class coeff_struct(Structure):
    _fields_ = [
        ("input_coeff", c_double * CFG["INPUT_TAPS"]),
        ("output_coeff", c_double * CFG["OUTPUT_TAPS"])
    ]

# Declare return and argument types
clib.get_coeff.restype = coeff_struct
clib.get_coeff.argtypes = [c_int]

class IIR_param_struct(Structure):
    _fields_ = [
        ("INPUT_TAPS", c_int),
        ("OUTPUT_TAPS", c_int),
        ("DATA_WIDTH" ,c_int),
        ("DATA_FRAC_WIDTH",c_int),
        ("COEFF_WIDTH",c_int),
        ("COEFF_FRAC_WIDTH",c_int)
    ]

    def __init__(self):
        self.INPUT_TAPS      = CFG["INPUT_TAPS"]     
        self.OUTPUT_TAPS     = CFG["OUTPUT_TAPS"]    
        self.DATA_WIDTH      = CFG["DATA_WIDTH"]     
        self.COEFF_WIDTH     = CFG["COEFF_WIDTH"]    
        self.DATA_FRAC_WIDTH = CFG["DATA_FRAC_WIDTH"]
        self.COEFF_FRAC_WIDTH= CFG["COEFF_FRAC_WIDTH"]
        print(f"in python COEFF_FRAC_WIDTH is: {self.COEFF_FRAC_WIDTH}")
# Declare return and argument types
clib.dpi_init_param_struct.argtypes = [POINTER(IIR_param_struct)]

IIR_param = IIR_param_struct()
clib.dpi_init_param_struct(byref(IIR_param))

def signed(numb, width):
    if (numb >> (width-1)):
        return(-((2 ** width) - numb))
    else:
        return numb

@vsc.randobj
class item_basic(uvm_sequence_item):

    def __init__(self, name="item_basic",
                 INPUT_TAPS      = CFG["INPUT_TAPS"],   
                 OUTPUT_TAPS     = CFG["OUTPUT_TAPS"],
                 DATA_WIDTH      = CFG["DATA_WIDTH"],
                 COEFF_WIDTH     = CFG["COEFF_WIDTH"],
                 DATA_FRAC_WIDTH = CFG["DATA_FRAC_WIDTH"],
                 COEFF_FRAC_WIDTH= CFG["COEFF_FRAC_WIDTH"]
                 ):
        super().__init__(name)
        # Setting up the parameters
        self.INPUT_TAPS       = INPUT_TAPS      
        self.OUTPUT_TAPS      = OUTPUT_TAPS     
        self.DATA_WIDTH       = DATA_WIDTH      
        self.COEFF_WIDTH      = COEFF_WIDTH     
        self.DATA_FRAC_WIDTH  = DATA_FRAC_WIDTH 
        self.COEFF_FRAC_WIDTH = COEFF_FRAC_WIDTH
        self.FXD_POINT_COEFF = vsc.bit_t(COEFF_FRAC_WIDTH+1, 1 << self.COEFF_FRAC_WIDTH)
        
        # Delcaring the data members
        self.x_i = vsc.rand_int_t(DATA_WIDTH)
        self.y_o = vsc.bit_t(DATA_WIDTH)
        self.coeff_x_i = vsc.list_t(vsc.bit_t(COEFF_WIDTH), INPUT_TAPS)
        self.coeff_y_i = vsc.list_t(vsc.bit_t(COEFF_WIDTH), OUTPUT_TAPS)

        self.coeff_index = vsc.rand_uint8_t(0)
        self.prev_coeff_index = vsc.uint8_t(0) # Used in child classes for randomizing the coeff_index
        self.change = vsc.rand_bit_t(1)

    def post_randomize(self):

        # Fetch coeffs
        self.prev_coeff_index = int(self.coeff_index)
        coeffs = clib.get_coeff(int(self.coeff_index))

        for i in range(self.INPUT_TAPS):
            self.coeff_x_i[i] = int(coeffs.input_coeff[i] * self.FXD_POINT_COEFF)

        for i in range(self.OUTPUT_TAPS):
            self.coeff_y_i[i] = int(coeffs.output_coeff[i] * self.FXD_POINT_COEFF)


