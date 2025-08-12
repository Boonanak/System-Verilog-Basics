// Package for new type, (state_t), that will be imported by both fsm.sv and tb_fsm.sv
package fsm_pkg;

    typedef enum logic [1:0] {
        S1, S2, S3, S4
    } state_t;
	
endpackage
