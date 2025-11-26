/*
 * IIR_filter.c
 *
 *  Created on: 7 Jul 2022
 *      Author: ak2251
 */
#include "IIR_filter.h"

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
  
  int COEFF_FRAC_WIDTH = IIR_filter->params.COEFF_FRAC_WIDTH;
  int DATA_FRAC_WIDTH = IIR_filter->params.DATA_FRAC_WIDTH;
  int DATA_WIDTH = IIR_filter->params.DATA_WIDTH;
//  int INPUT_BUFFER_LENGTH = IIR_filter->params.INPUT_TAPS;
//  int OUTPUT_BUFFER_LENGTH = IIR_filter->params.OUTPUT_TAPS;
  __int128 input_coeff_fxd[INPUT_BUFFER_LENGTH];
  __int128 output_coeff_fxd[OUTPUT_BUFFER_LENGTH];
  __int128 acc_x = 0;
  __int128 acc_y = 0;
  __int128 acc_res = 0;
  __int128 FXD_POINT_COEFF = ((__int128)(1)) << COEFF_FRAC_WIDTH;
  __int128 ROUNDING_ERROR = ((__int128)(1)) << (COEFF_FRAC_WIDTH + DATA_FRAC_WIDTH -1);


  printf("COEFF_FRAC_WIDTH is %d\n", COEFF_FRAC_WIDTH);
  fflush(stdout);

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

  printf("fixed-point coeff is %lld\n", FXD_POINT_COEFF);
  fflush(stdout);

	/* Computing the product of multiplication between input buffer and corresponding coefficients */
	for(uint8_t i =0; i<INPUT_BUFFER_LENGTH; i++) {

    /* Converting floating-point tp fixed-point */ 
    input_coeff_fxd[i] = (input_coeff[i] * FXD_POINT_COEFF);
//    printf("input coeff is %lld and %d\n", input_coeff_fxd[i], i);
//    fflush(stdout);

		saved_index --;
		if(saved_index < 0) {
			saved_index = INPUT_BUFFER_LENGTH-1;
		}
    
		acc += (input_coeff[i] * IIR_filter->input_buffer[saved_index]);
//    printf("In C, Acc_x is %f\n", acc);
//    fflush(stdout);

    acc_x += (__int128)(input_coeff_fxd[i] * IIR_filter->input_buffer[saved_index]);
	}
  
  printf("In C, acc_x is %lld\n", acc_x);
  fflush(stdout);

	/* Make a copy of output buffer index so we can manipulate it */
	saved_index = IIR_filter->output_buffer_index;

	/* Computing the product of multiplication between output buffer and corresponding coefficients */
	for(uint8_t i =0; i<OUTPUT_BUFFER_LENGTH; i++) {
  
    /* Converting floating-point tp fixed-point */ 
    output_coeff_fxd[i] = (__int128)(output_coeff[i] * FXD_POINT_COEFF);

		saved_index --;
		if(saved_index < 0) {
			saved_index = OUTPUT_BUFFER_LENGTH-1;
		}
		acc -= (output_coeff[i] * IIR_filter->output_buffer[saved_index]);
//  printf("In C, Acc_y is %f\n", acc);
//  fflush(stdout);

    acc_y += (__int128)(output_coeff_fxd[i] * IIR_filter->output_buffer[saved_index]);
	}
  printf("In C, acc_y is %lld\n", acc_y);
  fflush(stdout);

  
  /* Rounding and getting rid of fractionals */
  acc_res = (acc_x - acc_y);
  printf("In C, acc_res is %lld\n", acc_res);
  fflush(stdout);

  acc_res = (acc_res + ROUNDING_ERROR);
  printf("In C, acc_res_rounded is %lld\n", acc_res);
  fflush(stdout);

  acc_res = acc_res >> COEFF_FRAC_WIDTH;
  printf("In C, acc_res without fractionals is %lld\n", acc_res);
  fflush(stdout);

  acc = (int)(round(acc));
  /* Checking the saturation */
  if (acc >= ((1 << (DATA_WIDTH-1))-1)) {
    acc = ((1 << (DATA_WIDTH-1))-1);
  } else if (acc <= -(1 << (DATA_WIDTH-1))) {
    acc = -(1 << (DATA_WIDTH-1));
  }

  /* Checking the saturation */
  if (acc_res >= ((1 << (DATA_WIDTH-1))-1)) {
    acc_res = ((1 << (DATA_WIDTH-1))-1);
  } else if (acc_res <= -(1 << (DATA_WIDTH-1))) {
    acc_res = -(1 << (DATA_WIDTH-1));
  }

  printf("In C, Final Output after rounding and saturation is %lld\n", acc_res);
  fflush(stdout);

  printf("In C, Final Output from floating-point is %f\n", acc);
  fflush(stdout);
  
  IIR_filter->output = (int)(acc_res);
  
	/* Insert the calculated output into output buffer */
	IIR_filter->output_buffer[IIR_filter->output_buffer_index] = IIR_filter->output;
  
	/* Update output Buffer Index */
	IIR_filter->output_buffer_index ++;
	if(IIR_filter->output_buffer_index == OUTPUT_BUFFER_LENGTH) {

		IIR_filter->output_buffer_index = 0;
	}

	return IIR_filter->output;
}
