`include "axi_pkg.sv"

module tb_top;

  import axi_pkg::*;
  import uvm_pkg::*;

  `include "uvm_macros.svh"

  bit clk = 0;
  bit rst = 0;

  axi_intf vif (
    .ACLk    (clk),
    .ARESETn (rst)
  );

  // --------------------------------------------------
  // UVM configuration
  // --------------------------------------------------
  initial begin
    uvm_config_db#(virtual axi_intf)::set(
      null,
      "*",
      "vif",
      vif
    );
  end

  // --------------------------------------------------
  // Clock generation
  // --------------------------------------------------
  initial begin
    forever begin
      #5 clk = ~clk;
    end
  end

  // --------------------------------------------------
  // Reset and stimulus
  // --------------------------------------------------
  initial begin
    rst = 1;

    #10;
    rst = 0;

    reset_axi_signals();

    #20;
    rst = 1;

    #1;
    drive_single_write();
  end

  // --------------------------------------------------
  // Reset AXI signals
  // --------------------------------------------------
  task reset_axi_signals();

    // Write-address channel
    vif.AWID    = '0;
    vif.AWADDR  = '0;
    vif.AWLEN   = '0;
    vif.AWSIZE  = '0;
    vif.AWBURST = '0;
    vif.AWVALID = 0;
    vif.AWREADY = 0;

    // Write-data channel
    vif.WDATA   = '0;
    vif.WSTRB   = '0;
    vif.WLAST   = 0;
    vif.WVALID  = 0;
    vif.WREADY  = 0;

    // Write-response channel
    vif.BID     = '0;
    vif.BRESP   = '0;
    vif.BVALID  = 0;
    vif.BREADY  = 0;

    // Read-address channel
    vif.ARID    = '0;
    vif.ARADDR  = '0;
    vif.ARLEN   = '0;
    vif.ARSIZE  = '0;
    vif.ARBURST = '0;
    vif.ARVALID = 0;
    vif.ARREADY = 0;

    // Read-data channel
    vif.RID     = '0;
    vif.RDATA   = '0;
    vif.RRESP   = '0;
    vif.RLAST   = 0;
    vif.RVALID  = 0;
    vif.RREADY  = 0;

  endtask : reset_axi_signals

  // --------------------------------------------------
  // Drive a single-beat AXI write
  // --------------------------------------------------
  task drive_single_write();

    // ------------------------------------------------
    // AW channel: write address
    // ------------------------------------------------
    @(negedge vif.ACLk);

    vif.AWID    = 4'h1;
    vif.AWADDR  = 32'h0000_1000;
    vif.AWLEN   = 8'd0;       // One data beat
    vif.AWSIZE  = 3'd2;       // Four bytes per beat
    vif.AWBURST = 2'b01;      // INCR burst
    vif.AWVALID = 1;
    vif.AWREADY = 1;

    @(negedge vif.ACLk);

    vif.AWVALID = 0;
    vif.AWREADY = 0;

    // ------------------------------------------------
    // W channel: write data
    // ------------------------------------------------
    @(negedge vif.ACLk);

    vif.WDATA  = 32'hDEAD_BEEF;
    vif.WSTRB  = 4'b1111;
    vif.WLAST  = 1;
    vif.WVALID = 1;
    vif.WREADY = 1;

    @(negedge vif.ACLk);

    vif.WVALID = 0;
    vif.WREADY = 0;
    vif.WLAST  = 0;

    // ------------------------------------------------
    // B channel: write response
    // ------------------------------------------------
    @(negedge vif.ACLk);

    vif.BID    = 4'h1;
    vif.BRESP  = 2'b00;       // OKAY
    vif.BVALID = 1;
    vif.BREADY = 1;

    @(negedge vif.ACLk);

    vif.BVALID = 0;
    vif.BREADY = 0;

  endtask : drive_single_write

  // --------------------------------------------------
  // VCD waveform dumping
  // --------------------------------------------------
  initial begin
    $dumpfile("axi_wave.vcd");
    $dumpvars(0, tb_top);
  end
  
  initial begin
  	#100;
  	$finish;
  end

endmodule : tb_top