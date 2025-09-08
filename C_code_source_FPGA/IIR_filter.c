/*
 * IIR_filter.c
 *
 *  Created on: 7 Jul 2022
 *      Author: ak2251
 */
#include "IIR_filter.h"

//float input_coeff[INPUT_BUFFER_LENGTH] = {1.0110227166961394, -1.8823319078222351, 0.8803577519625015};
//float output_coeff[INPUT_BUFFER_LENGTH] = { -1.8836532429909993, 0.8900591334898765};

//float input_coeff[INPUT_BUFFER_LENGTH] = {1.0, -1.8836532429909993, 0.8900591334898765};
//float output_coeff[OUTPUT_BUFFER_LENGTH] = { -1.8836532429909993, 0.8900591334898765};

//float input_coeff[INPUT_BUFFER_LENGTH] = {1.009271465, -1.90111746, 0.898311285};
//float output_coeff[OUTPUT_BUFFER_LENGTH] = { -1.90206157, 0.9066386};

//float input_coeff[INPUT_BUFFER_LENGTH] = {1.00084357171259, -1.883559715301141, 0.889309089467145};
//float output_coeff[OUTPUT_BUFFER_LENGTH] = {-1.8836532429909993, 0.8900591334898765};

/* This function resets the content of all buffers to zero
 */
void init_filter(filter* IIR_filter) {

	for(uint8_t i=0; i<INPUT_BUFFER_LENGTH; i++) {

		IIR_filter->input_buffer[i] = 0;
	}

	for(uint8_t i=0; i<OUTPUT_BUFFER_LENGTH; i++) {

		IIR_filter->output_buffer[i] = 0;
	}

	IIR_filter->input_buffer_index = 0;
	IIR_filter->output_buffer_index = 0;

	IIR_filter->output = 0;
}

int compute_filter_output(filter* IIR_filter, int input, double input_coeff[INPUT_BUFFER_LENGTH], double output_coeff[OUTPUT_BUFFER_LENGTH]) {

	int8_t saved_index ;
  double acc=0;

	/* Insert the input in the input buffer */
	IIR_filter->input_buffer[IIR_filter->input_buffer_index] = input;

	/* Update Buffer Index, this index should always point to the oldest sample */
	IIR_filter->input_buffer_index ++;
	if(IIR_filter->input_buffer_index == INPUT_BUFFER_LENGTH) {

		IIR_filter->input_buffer_index = 0;
	}

	/* Reset output */
	IIR_filter->output = 0;

	/* Make a copy of input buffer index so we can manipulate it */
	saved_index = IIR_filter->input_buffer_index;

  printf("In C, recieved input coeffs are: %f %f %f\n", input_coeff[0], input_coeff[1], input_coeff[2]);
  printf("In C, recieved output coeffs are: %f %f\n", output_coeff[0], output_coeff[1]);
  fflush(stdout);

	/* Computing the product of multiplication between input buffer and corresponding coefficients */
	for(uint8_t i =0; i<INPUT_BUFFER_LENGTH; i++) {

		saved_index --;
		if(saved_index < 0) {
			saved_index = INPUT_BUFFER_LENGTH-1;
		}
    
		acc += (input_coeff[i] * IIR_filter->input_buffer[saved_index]);
    printf("In C, Acc_x is %f\n", acc);
    fflush(stdout);
	}

	/* Make a copy of output buffer index so we can manipulate it */
	saved_index = IIR_filter->output_buffer_index;

	/* Computing the product of multiplication between output buffer and corresponding coefficients */
	for(uint8_t i =0; i<OUTPUT_BUFFER_LENGTH; i++) {

		saved_index --;
		if(saved_index < 0) {
			saved_index = OUTPUT_BUFFER_LENGTH-1;
		}
		acc -= (output_coeff[i] * IIR_filter->output_buffer[saved_index]);
    printf("In C, Acc_y is %f\n", acc);
    fflush(stdout);
	}

  /* Checking the saturation */
  if (acc >= 8388607) {
    acc = 8388607;
  } else if (acc <= -8388608) {
    acc = -8388608;
  }

  printf("In C, Final Output before rounding is %f\n", acc);
  fflush(stdout);

  IIR_filter->output = (int)(round(acc));
  
	/* Insert the calculated output into output buffer */
	IIR_filter->output_buffer[IIR_filter->output_buffer_index] = IIR_filter->output;
  
	/* Update output Buffer Index */
	IIR_filter->output_buffer_index ++;
	if(IIR_filter->output_buffer_index == OUTPUT_BUFFER_LENGTH) {

		IIR_filter->output_buffer_index = 0;
	}

  printf("In C, Final Output is %d\n", IIR_filter->output);
  fflush(stdout);

	return IIR_filter->output;
}
