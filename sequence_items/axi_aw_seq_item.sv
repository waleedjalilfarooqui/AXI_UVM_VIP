// AW CHANNEL SEQUENCE ITEM
class axi_aw_seq_item extends uvm_sequence_item;
  
  
  rand bit [ADDR_WIDTH-1:0]       addr;
  rand bit [ID_WIDTH-1:0]           id;
  rand bit [7:0]           	       len;
  rand bit [2:0] 			            size;
  rand bit [1:0] 			           burst;
  

  // Standard UVM Constructor
  function new(string name = "axi_aw_seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(axi_aw_seq_item)
    `uvm_field_int(addr,  UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(id,    UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(len,   UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(size,  UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(burst,  UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end
  
  
endclass