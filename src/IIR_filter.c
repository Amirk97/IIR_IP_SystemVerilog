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

short compute_filter_output(filter* IIR_filter, short input, float input_coeff[INPUT_BUFFER_LENGTH], float output_coeff[OUTPUT_BUFFER_LENGTH]) {

	int8_t saved_index ;

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

	/* Computing the product of multiplication between input buffer and corresponding coefficients */
	for(uint8_t i =0; i<INPUT_BUFFER_LENGTH; i++) {

		saved_index --;
		if(saved_index < 0) {
			saved_index = INPUT_BUFFER_LENGTH-1;
		}

		IIR_filter->output += (short)(input_coeff[i] * IIR_filter->input_buffer[saved_index]);
	}

	/* Make a copy of output buffer index so we can manipulate it */
	saved_index = IIR_filter->output_buffer_index;

	/* Computing the product of multiplication between output buffer and corresponding coefficients */
	for(uint8_t i =0; i<OUTPUT_BUFFER_LENGTH; i++) {

		saved_index --;
		if(saved_index < 0) {
			saved_index = OUTPUT_BUFFER_LENGTH-1;
		}
		IIR_filter->output -= (short)(output_coeff[i] * IIR_filter->output_buffer[saved_index]);
	}

	/* Insert the calculated output into output buffer */
	IIR_filter->output_buffer[IIR_filter->output_buffer_index] = IIR_filter->output;

	/* Update output Buffer Index */
	IIR_filter->output_buffer_index ++;
	if(IIR_filter->output_buffer_index == OUTPUT_BUFFER_LENGTH) {

		IIR_filter->output_buffer_index = 0;
	}

	return IIR_filter->output;
}
