class axi_sequence_item extends uvm_sequence_item;
  
  rand axi_op_code 			  OpCode;
  
  rand bit [ADDR_WIDTH-1:0]     addr;
  rand bit [ID_WIDTH-1:0]         id;
  rand bit [7:0]           	     len;
  rand bit [2:0] 			    size;
  rand bit [1:0] 			   burst;
  rand bit [DATA_WIDTH-1:0]  	data[$];
  rand bit [(DATA_WIDTH/8)-1:0] strb;
  
  rand bit [1:0]  			     rsp;
  rand bit [1:0]              rd_rsp;
  
  // Standard UVM Constructor
  function new(string name = "axi_sequence_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(axi_sequence_item)
    `uvm_field_enum(axi_op_code, OpCode, UVM_ALL_ON)
    `uvm_field_int(addr,  UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(id,    UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(len,   UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(strb,  UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(size,  UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(burst,  UVM_ALL_ON | UVM_HEX)
    `uvm_field_queue_int(data,  UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end
  
endclass
