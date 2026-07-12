class axi_w_seq_item extends uvm_sequence_item;
  
  rand logic [DATA_WIDTH-1:0]  	data[$];
  rand logic [STRB_WIDTH-1:0]   strb[$];
  
  // Standard UVM Constructor
  function new(string name = "axi_w_seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(axi_w_seq_item)
    `uvm_field_queue_int(strb,  UVM_ALL_ON | UVM_DEC)
    `uvm_field_queue_int(data,  UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end
  
endclass
