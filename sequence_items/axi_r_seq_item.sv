class axi_r_seq_item extends uvm_sequence_item;
  

  rand bit [ID_WIDTH-1:0]         id[$];
  rand bit [1:0]  			     rsp[$];
  rand bit [DATA_WIDTH-1:0]  	data[$];

  
  // Standard UVM Constructor
  function new(string name = "axi_r_seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(axi_r_seq_item)
    `uvm_field_queue_int(id,    UVM_ALL_ON | UVM_DEC)
    `uvm_field_queue_int(rsp,   UVM_ALL_ON | UVM_BIN)
    `uvm_field_queue_int(data,  UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end
  
endclass
