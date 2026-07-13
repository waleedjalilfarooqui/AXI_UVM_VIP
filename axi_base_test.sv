class axi_base_test extends uvm_test;
`uvm_component_utils(axi_base_test);

axi_monitor mon;

// constructor function
 function new(string name="axi_base_test", uvm_component parent=null);
    super.new(name, parent);
 endfunction


virtual function build_phase (uvm_phase phase);
super.phase(phase);

mon = axi_monitor::type_id::create("axi_monitor");

endfunction








endclass