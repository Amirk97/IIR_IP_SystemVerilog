/*
 * IIR_filter.h
 *
 *  Created on: 7 Jul 2022
 *      Author: ak2251
 */

#ifndef SRC_IIR_FILTER_H_
#define SRC_IIR_FILTER_H_

#include "stdint.h"

#define INPUT_BUFFER_LENGTH 3
#define OUTPUT_BUFFER_LENGTH 2


typedef struct {
	short input_buffer[INPUT_BUFFER_LENGTH];
	uint8_t input_buffer_index;

	short output_buffer[OUTPUT_BUFFER_LENGTH];
	uint8_t output_buffer_index;

	short output;

}filter;


void init_filter(filter *);
short compute_filter_output(filter* , short, float[], float[] );

#endif /* SRC_IIR_FILTER_H_ */
