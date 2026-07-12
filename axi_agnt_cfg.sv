class axi_agnt_cfg extends uvm_object;
  
  `uvm_object_utils (axi_agnt_cfg)
  
  virtual axi_intf vif;
  axi_vip_active_passive_enum is_active = PASSIVE;
  
     
  
  // constructor
  function new(string name="axi_agnt_cfg");
    super.new(name);
  endfunction
  
  
endclass