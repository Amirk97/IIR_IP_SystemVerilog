#include "IIR_filter.h"
#include <stdio.h>
#include <string.h>
extern coeff_struct const BASS_coeffs[];

filter IIR_filter;

void dpi_init_param_struct(IIR_param_struct* param_struct){
  IIR_filter.params.INPUT_TAPS      = param_struct->INPUT_TAPS;
  IIR_filter.params.OUTPUT_TAPS     = param_struct->OUTPUT_TAPS;
  IIR_filter.params.DATA_WIDTH      = param_struct->DATA_WIDTH;
  IIR_filter.params.COEFF_FRAC_WIDTH= param_struct->COEFF_FRAC_WIDTH;
  IIR_filter.params.COEFF_WIDTH     = param_struct->COEFF_WIDTH;
  IIR_filter.params.DATA_FRAC_WIDTH = param_struct->DATA_FRAC_WIDTH;
  IIR_filter.params.PROCESS_DELAY   = param_struct->PROCESS_DELAY;
  printf("In wrapper COEFF_FRAC_WIDTH is %d\n", IIR_filter.params.COEFF_FRAC_WIDTH);
  printf("In wrapper INPUT_TAPS is %d\n", IIR_filter.params.INPUT_TAPS);
  fflush(stdout);
}

void dpi_init_filter(void){
  init_filter(&IIR_filter);
}

int dpi_compute_filter_output(int input, int index) {
  printf("Recieved input in C world is %d and index is %d\n", input, index);
  fflush(stdout);
  int output = compute_filter_output(&IIR_filter, input, BASS_coeffs[index].input_coeff, BASS_coeffs[index].output_coeff);
  printf("In dpi wrapper, output is %d\n", output);
  fflush(stdout);
  return output;
}

coeff_struct get_coeff (int array_index) {

  coeff_struct coeff;
  printf("array_index is %d", array_index);
  fflush(stdout);

  for( uint8_t i=0; i< INPUT_BUFFER_LENGTH; i++) {
    coeff.input_coeff[i] = BASS_coeffs[array_index].input_coeff[i];
  }

  printf("In dpi wrapper, coeff is %f\n", coeff.input_coeff[0]);
  fflush(stdout);

  for( uint8_t i=0; i< OUTPUT_BUFFER_LENGTH; i++) {
    coeff.output_coeff[i] = BASS_coeffs[array_index].output_coeff[i];
  }

  return coeff;
}
