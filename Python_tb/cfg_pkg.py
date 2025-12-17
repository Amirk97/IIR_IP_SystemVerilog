import os

CFG_list = [{
    "INPUT_TAPS" : 3,
    "OUTPUT_TAPS" : 2,                    
    "DATA_WIDTH" : 24,                   
    "COEFF_FRAC_WIDTH" : 31,
    "DATA_FRAC_WIDTH" : 0,             
    "PROCESS_DELAY" : 3,
},
{
    "INPUT_TAPS" : 3,
    "OUTPUT_TAPS" : 2,                    
    "DATA_WIDTH" : 24,                   
    "COEFF_FRAC_WIDTH" : 31,
    "DATA_FRAC_WIDTH" : 0,             
    "PROCESS_DELAY" : 2,
}]

for CFG in CFG_list:
    CFG["COEFF_WIDTH"] = CFG["COEFF_FRAC_WIDTH"] +3

CFG_FIR_list = [{
    "INPUT_TAPS" : 3,
    "DATA_WIDTH" : 24,                   
    "COEFF_FRAC_WIDTH" : 31,
    "DATA_FRAC_WIDTH" : 0,             
    "PROCESS_DELAY" : 3,
},
{
    "INPUT_TAPS" : 3,
    "DATA_WIDTH" : 24,                   
    "COEFF_FRAC_WIDTH" : 31,
    "DATA_FRAC_WIDTH" : 0,             
    "PROCESS_DELAY" : 2,
}]

for CFG in CFG_FIR_list:
    CFG["COEFF_WIDTH"] = CFG["COEFF_FRAC_WIDTH"] +3

    

cfg_indx = int(os.environ.get("CFG_INDX", 0))
testcase = os.environ.get("PY_TESTCASE", "test_const_coeff")
toplevel = os.environ.get("TOPLEVEL")

if testcase == "test_process_delay":
    cfg_indx=1

if toplevel == "IIR":
    VERILATOR_COMPILE_ARGS = ""
    for key, value in CFG_list[cfg_indx].items():
        VERILATOR_COMPILE_ARGS += f" -G{key}={value}"

    CFG=CFG_list[cfg_indx]
    print(VERILATOR_COMPILE_ARGS)
