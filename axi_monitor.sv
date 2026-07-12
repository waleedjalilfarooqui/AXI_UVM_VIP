`define AW_SEQ_ITEM_ASSIGN(item) \
    item.addr  = vif.AWADDR;     \
    item.id    = vif.AWID;       \
    item.len   = vif.AWLEN;      \
    item.size  = vif.AWSIZE;     \
    item.burst = vif.AWBURST;

`define AR_SEQ_ITEM_ASSIGN(item) \
    item.addr  = vif.ARADDR;     \
    item.id    = vif.ARID;       \
    item.len   = vif.ARLEN;      \
    item.size  = vif.ARSIZE;     \
    item.burst = vif.ARBURST;

`define W_SEQ_ITEM_ASSIGN(item) \
	item.data.push_back(vif.WDATA);       \
    item.strb.push_back(vif.WSTRB);       \

`define B_SEQ_ITEM_ASSIGN(item) \
    item.id  = vif.BID;          \
    item.rsp = vif.BRESP;

`define R_SEQ_ITEM_ASSIGN(item) \
	item.id.push_back(vif.RID);     \
	item.data.push_back(vif.RDATA);       \
	item.rsp.push_back(vif.RRESP);


class axi_monitor extends uvm_monitor;

  `uvm_component_utils(axi_monitor)

  int aw_tr_numbr  = 0;
  int w_tr_numbr   = 0;
  int b_rsp_numbr  = 0;
  int r_rsp_numbr  = 0;
  int ar_tr_numbr  = 0;

  virtual axi_intf vif;

  axi_aw_seq_item aw_itm;
  axi_ar_seq_item ar_itm;
  axi_b_seq_item  b_itm;
  axi_r_seq_item  r_itm;
  axi_w_seq_item  w_itm;

  function new(string name = "axi_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!(uvm_config_db#(virtual axi_intf)::get(this, "", "vif", vif))) begin
      `uvm_fatal(get_type_name(), "Failed to get intf")
    end

  endfunction


  virtual task main_phase(uvm_phase phase);

    phase.raise_objection(this);

    fork
      AW_tx_mon();
      W_tx_mon();
      b_rx_mon();
      ar_tx_mon();
      r_rx_mon();
    join_none

    phase.drop_objection(this);

  endtask


  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    phase.drop_objection(this);
  endtask


  virtual task AW_tx_mon();

    forever begin

      @(posedge vif.ACLk);

      if (!vif.ARESETn)
        continue;

      if (vif.AWVALID && vif.AWREADY) begin

        aw_itm = axi_aw_seq_item::type_id::create("aw_itm");
        aw_tr_numbr++;

        `AW_SEQ_ITEM_ASSIGN(aw_itm)

        `uvm_info(get_type_name(),
                  $sformatf("TR:%0d AW CHANNEL HANDSHAKE COMPLETED", aw_tr_numbr),
                  UVM_DEBUG)

        `uvm_info(get_type_name(),
                  $sformatf("AW captured: addr=%0h id=%0h len=%0d size=%0d burst=%0d",
                            aw_itm.addr,
                            aw_itm.id,
                            aw_itm.len,
                            aw_itm.size,
                            aw_itm.burst),
                  UVM_DEBUG)

      end

    end

  endtask


  virtual task W_tx_mon();

    forever begin

      @(posedge vif.ACLk);

      if (!vif.ARESETn)
        continue;

      if (vif.WVALID && vif.WREADY && vif.WLAST) begin

        w_itm = axi_w_seq_item::type_id::create("w_itm");
        w_tr_numbr++;

        `W_SEQ_ITEM_ASSIGN(w_itm)

        `uvm_info(get_type_name(),
                  $sformatf("TR:%0d W CHANNEL HANDSHAKE COMPLETED", w_tr_numbr),
                  UVM_DEBUG)

        `uvm_info(get_type_name(),
                  $sformatf("W captured: data=%0p strb=%0p",
                            w_itm.data,
                            w_itm.strb),
                  UVM_DEBUG)

      end

    end

  endtask


  virtual task b_rx_mon();

    forever begin

      @(posedge vif.ACLk);

      if (!vif.ARESETn)
        continue;

      if (vif.BVALID && vif.BREADY) begin

        b_itm = axi_b_seq_item::type_id::create("b_itm");
        b_rsp_numbr++;

        `B_SEQ_ITEM_ASSIGN(b_itm)

        `uvm_info(get_type_name(),
                  $sformatf("TR:%0d WRITE RESPONSE BRESP RECEIVED", b_rsp_numbr),
                  UVM_DEBUG)

        `uvm_info(get_type_name(),
                  $sformatf("B Response captured: ID=%0h RESP=%0b",
                            b_itm.id,
                            b_itm.rsp),
                  UVM_DEBUG)

      end

    end

  endtask


  virtual task ar_tx_mon();

    forever begin

      @(posedge vif.ACLk);

      if (!vif.ARESETn)
        continue;

      if (vif.ARVALID && vif.ARREADY) begin

        ar_itm = axi_ar_seq_item::type_id::create("ar_itm");
        ar_tr_numbr++;

        `AR_SEQ_ITEM_ASSIGN(ar_itm)

        `uvm_info(get_type_name(),
                  $sformatf("TR:%0d AR CHANNEL HANDSHAKE COMPLETED", ar_tr_numbr),
                  UVM_DEBUG)

        `uvm_info(get_type_name(),
                  $sformatf("AR captured: addr=%0h id=%0h len=%0d size=%0d burst=%0d",
                            ar_itm.addr,
                            ar_itm.id,
                            ar_itm.len,
                            ar_itm.size,
                            ar_itm.burst),
                  UVM_DEBUG)

      end

    end

  endtask


  virtual task r_rx_mon();

    forever begin

      @(posedge vif.ACLk);

      if (!vif.ARESETn)
        continue;

      if (vif.RVALID && vif.RREADY && vif.RLAST) begin

        r_itm = axi_r_seq_item::type_id::create("r_itm");
        r_rsp_numbr++;

        `R_SEQ_ITEM_ASSIGN(r_itm)

        `uvm_info(get_type_name(),
                  $sformatf("TR:%0d RD RESPONSE RECEIVED", r_rsp_numbr),
                  UVM_DEBUG)

        `uvm_info(get_type_name(),
                  $sformatf("R captured: data=%0p", r_itm.data),
                  UVM_DEBUG)

        `uvm_info(get_type_name(),
                  $sformatf("RD Response: ID=%0p | Rsp=%0p",
                            r_itm.id,
                            r_itm.rsp),
                  UVM_DEBUG)

      end

    end

  endtask

endclass