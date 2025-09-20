/*
 * IIR_filter.h
 *
 *  Created on: 7 Jul 2022
 *      Author: ak2251
 */

#ifndef SRC_IIR_FILTER_H_
#define SRC_IIR_FILTER_H_

#include "stdint.h"
#include <stdio.h>
#include <math.h>

#define INPUT_BUFFER_LENGTH 3
#define OUTPUT_BUFFER_LENGTH 2


typedef struct {
	int input_buffer[INPUT_BUFFER_LENGTH];
	uint8_t input_buffer_index;

	int output_buffer[OUTPUT_BUFFER_LENGTH];
	uint8_t output_buffer_index;

	int output;

}filter;

typedef struct{
	double input_coeff[INPUT_BUFFER_LENGTH];
	double output_coeff[OUTPUT_BUFFER_LENGTH];

//	const short fabric_input_coeff[INPUT_BUFFER_LENGTH];
//	const short fabric_output_coeff[OUTPUT_BUFFER_LENGTH];  
}coeff_struct;

void init_filter(filter *);
int compute_filter_output(filter* , int, double[], double[] );

#endif /* SRC_IIR_FILTER_H_ */
