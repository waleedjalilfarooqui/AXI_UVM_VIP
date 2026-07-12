interface axi_intf #(parameter int DATA_WIDTH=32,
                     parameter int ADDR_WIDTH=32,
                     parameter int ID_WIDTH=4
)(
	input logic ACLk,
  	input logic ARESETn
);
  localparam int STRB_WIDTH = DATA_WIDTH/8;
  
  // AXI WRITE REQUEST CHANNEL
  logic [ID_WIDTH-1:0]      AWID;
  logic [ADDR_WIDTH-1:0]  AWADDR;
  logic [7:0] 		       AWLEN;
  logic [2:0]			  AWSIZE;
  logic [1:0]            AWBURST;
  logic 			     AWVALID;
  logic 				 AWREADY;
  
  // AXI WRITE DATA CHANNEL
  logic [DATA_WIDTH-1:0]   WDATA;
  logic [STRB_WIDTH-1:0]   WSTRB;
  logic					   WLAST;
  logic					  WVALID;
  logic					  WREADY;
  // AXI WRITE RESPONSE CHANNEL
  
  logic [ID_WIDTH-1:0]       BID;
  logic [1:0]		       BRESP;
  logic 				  BVALID;
  logic 				  BREADY;
  
  
  // AXI READ REQUEST CHANNEL
  
  logic [ID_WIDTH-1:0]      ARID;
  logic [ADDR_WIDTH-1:0]  ARADDR;
  logic [7:0] 		       ARLEN;
  logic [2:0]			  ARSIZE;
  logic [1:0]            ARBURST;
  logic 			     ARVALID;
  logic 				 ARREADY;

  // AXI READ RESPONSE CHANNEL

  logic [ID_WIDTH-1:0] 	     RID;
  logic [1:0]			   RRESP;
  logic [DATA_WIDTH-1:0]   RDATA;
  logic  				   RLAST;
  logic 				  RVALID;
  logic 				  RREADY;
  
  modport axi4_master (
  
  // WRITE REQUEST PORTS
  input AWREADY,
  output AWVALID, AWADDR, AWID, AWLEN, AWSIZE, AWBURST,
  
  // WRITE DATA PORTS
  input WREADY,
  output WVALID, WDATA, WSTRB, WLAST,
  
  // WRITE RESPONSE PORTS 
  input BID, BRESP, BVALID,
  output BREADY,
    
  // READ REQUEST PORTS  
  input ARREADY,
  output ARID, ARADDR, ARVALID, ARSIZE, ARLEN, ARBURST,

  // READ RESPONSE PORTS  
  input RID, RRESP, RDATA, RLAST, RVALID,
  output RREADY 
         
  ); // axi4_master
  
  modport axi4_slave (
  
  // WRITE REQUEST PORTS
  output AWREADY,
  input AWVALID, AWADDR, AWID, AWLEN, AWSIZE, AWBURST,
  
  // WRITE DATA PORTS
  output WREADY,
  input WVALID, WDATA, WSTRB, WLAST,
  
  // WRITE RESPONSE PORTS 
  output BID, BRESP, BVALID,
  input BREADY,
    
  // READ REQUEST PORTS  
  output ARREADY,
  input ARID, ARADDR, ARVALID, ARSIZE, ARLEN, ARBURST,

  // READ RESPONSE PORTS  
  output RID, RRESP, RDATA, RLAST, RVALID,
  input RREADY 
         
  ); // axi4_slave

endinterface
