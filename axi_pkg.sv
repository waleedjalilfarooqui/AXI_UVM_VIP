`include "axi_intf.sv"
package axi_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

parameter ADDR_WIDTH = 32;
parameter DATA_WIDTH = 32;
parameter ID_WIDTH   = 4 ;
parameter STRB_WIDTH = DATA_WIDTH/8;

typedef enum bit{

  AXI_WRITE,
  AXI_READ
} axi_op_code;

typedef enum bit {
  ACTIVE,
  PASSIVE
} axi_vip_active_passive_enum ;

`include "axi_sequence_item.sv"
`include "axi_agnt_cfg.sv"
endpackage 