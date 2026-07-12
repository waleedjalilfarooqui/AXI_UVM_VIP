class axi_b_seq_item extends uvm_sequence_item;
  
  
  rand bit [ID_WIDTH-1:0]         id;
  rand bit [1:0]  			     rsp;
  
  // Standard UVM Constructor
  function new(string name = "axi_b_seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(axi_b_seq_item)
    `uvm_field_int(id,    UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(rsp,   UVM_ALL_ON | UVM_BIN)
  `uvm_object_utils_end
  
endclass
