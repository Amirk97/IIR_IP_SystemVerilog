CFG = {
    "INPUT_TAPS" : 3,
    "OUTPUT_TAPS" : 2,                    
    "DATA_WIDTH" : 24,                   
    "COEFF_FRAC_WIDTH" : 31,
    "DATA_FRAC_WIDTH" : 0,             
    "PROCESS_DELAY" : 3,
}

CFG["COEFF_WIDTH"] = CFG["COEFF_FRAC_WIDTH"] +3

VERILATOR_COMPILE_ARGS = ""
for key, value in CFG.items():
    VERILATOR_COMPILE_ARGS += f" -G{key}={value}"

print(VERILATOR_COMPILE_ARGS)
    
