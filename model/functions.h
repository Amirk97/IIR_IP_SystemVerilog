#ifndef __FUNCTIONS_H
#define __FUNCTIONS_H

#include <stdint.h>
#include "IIR_filter.h"

#define FXD_POINT_COEFF (1 << 15)  // For 15 fractional numbers


typedef struct{
	short bass;
	short treble;
	short volume;
}rot_pos_struct;

typedef enum{
	INIT_ST,
	BASS_ST,
	VOLUME_ST,
	TREBLE_ST
}ROTARY_state_typedef;

typedef enum{
	SUPER_ACTIVE_ST,
	SUPER_DORMANT_ST
}ROTARY_super_state_typedef;

typedef enum{
	AB_IDLE,
	AB_NON_IDLE
}AB_sig_state_typedef;

coeff_struct update_bass_equ_coeff(short );
coeff_struct update_treble_equ_coeff(short );

#endif
