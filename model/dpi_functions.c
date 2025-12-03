#include "IIR_filter.h"
#include <stdio.h>
#include "svdpi.h"
#include <string.h>
#define ARRAY_SIZE 2
extern coeff_struct const BASS_coeffs[];

filter IIR_filter;

double input_coeff[] = {1.0, -1.8836532429909993, 0.8900591334898765};
double output_coeff[] = {-1.8836532429909993, 0.8900591334898765};

coeff_struct coeff[ARRAY_SIZE];
int write_index = 0;
int read_index = 0;

void dpi_init_filter(void){
  init_filter(&IIR_filter);
  // For this tb, these values don't propagate from config_pkg, instead it's hard coded
  IIR_filter.params.DATA_WIDTH       = 24;
  IIR_filter.params.COEFF_FRAC_WIDTH = 31;
  IIR_filter.params.DATA_FRAC_WIDTH = 0;
}

int dpi_compute_filter_output(int input, int index) {
  printf("Recieved input in C world is %d and index is %d\n", input, index);
  fflush(stdout);
  int output = compute_filter_output(&IIR_filter, input, BASS_coeffs[index].input_coeff, BASS_coeffs[index].output_coeff);
  printf("In dpi wrapper, output is %d\n", output);
  fflush(stdout);
  return output;
}

void dpi_get_coeff (int array_index, svOpenArrayHandle arr1[], svOpenArrayHandle arr2[]) {
  
  double* arr_ptr1 = (double*) svGetArrayPtr(arr1);
  double* arr_ptr2 = (double*) svGetArrayPtr(arr2);

  printf("array_index is %d", array_index);
  fflush(stdout);

  for( uint8_t i=0; i< INPUT_BUFFER_LENGTH; i++) {
    coeff[write_index].input_coeff[i] = BASS_coeffs[array_index].input_coeff[i];
  }

  printf("In dpi wrapper, coeff is %f\n", coeff[write_index].input_coeff[0]);
  fflush(stdout);

  for( uint8_t i=0; i< OUTPUT_BUFFER_LENGTH; i++) {
    coeff[write_index].output_coeff[i] = BASS_coeffs[array_index].output_coeff[i];
  }

  memcpy(arr_ptr1, coeff[write_index].input_coeff, sizeof(coeff->input_coeff));
  memcpy(arr_ptr2, coeff[write_index].output_coeff, sizeof(coeff->output_coeff));

  write_index++;
  if(write_index == ARRAY_SIZE) {
    write_index=0;
  }

}
