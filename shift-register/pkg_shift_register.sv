// Package for the new mode type that both shift_register and tb_shift_register will import
package shift_register_pkg;

  typedef enum logic [1:0] {
    HOLD = 2'b00,
    LOAD = 2'b01,
    SHIFT_RIGHT = 2'b10,
    SHIFT_LEFT = 2'b11
  } shift_mode_t;

endpackage
