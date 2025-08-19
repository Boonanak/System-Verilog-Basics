// Package for the new mode type that both shift_register and tb_shift_register will import
package pkg_complex_counter;

  typedef enum logic [1:0] {
    HOLD = 2'b00,
    UP = 2'b01,
    DOWN = 2'b10,
    LOAD = 2'b11
  } count_mode_t;

endpackage
