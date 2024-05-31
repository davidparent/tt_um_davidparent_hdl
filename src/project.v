/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */
`default_nettype none
module tt_um_davidparent_hdl (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    reg [30:0] lfsr;
    reg [30:0] lfsr_test;
    reg [7:0]  temp;
    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
        lfsr <= 31'b1;  
        lfsr_test <= 31'b1;      
        // temp[7:0] <=8'b0;
    end else begin
       // temp[7:0]<=ui_in[7:0];
        lfsr[0] <= lfsr[27] ^ lfsr[30] ;
        lfsr[30:1] <=lfsr[29:0] ;  
        lfsr_test[0]=temp[0];
        lfsr_test[30:1] <=lfsr_test[29:0] ;        
    end
end  
  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[0] = lfsr[30]    
  assign uo_out[1] = 0 ;
  assign [7:0] = ui_in[7:0];  
  assign uio_out = 0;
  assign uio_oe  = 0;
  assign uo_out[7:2]= 6'b0;
  // List all unused inputs to prevent warnings
    wire _unused = &{ena, uio_in, 1'b0}; 
endmodule

