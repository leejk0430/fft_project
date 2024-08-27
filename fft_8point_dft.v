//////////////////////////////////////////////////////////////////////////////////
// Company: Personal
// Engineer: Joong Kyoung Lee
//
// Create Date: 2024.08.24
// Design Name: fft_8point
// License : https://github.com/leejk0430/fft_project/blob/main/LICENSE
// Module Name:
// Project Name:
// Target Devices:
// Tool Versions:
// Description: output FFT of number of 8 data each 8bit.
//              Used radix-2 buttefly operation for FFT.
//              Did not consider overflow.
//              handshake ver.
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module fft_8point_dft(
    input 			clk,
    input 			reset_n,

    input 			s_valid,
    output 			s_ready,
    input signed [7:0] x0,  // 8-point input sequence
    input signed [7:0] x1,  // 8-point input sequence
    input signed [7:0] x2,  // 8-point input sequence
    input signed [7:0] x3,  // 8-point input sequence
    input signed [7:0] x4,  // 8-point input sequence
    input signed [7:0] x5,  // 8-point input sequence
    input signed [7:0] x6,  // 8-point input sequence
    input signed [7:0] x7,  // 8-point input sequence
    

    output 			m_valid,
    input 			m_ready,
    output signed [31:0] m_X_0_real,
    output signed [31:0] m_X_0_imag,
    output signed [31:0] m_X_1_real,
    output signed [31:0] m_X_1_imag,
    output signed [31:0] m_X_2_real,
    output signed [31:0] m_X_2_imag, 
    output signed [31:0] m_X_3_real,
    output signed [31:0] m_X_3_imag, 
    output signed [31:0] m_X_4_real,
    output signed [31:0] m_X_4_imag, 
    output signed [31:0] m_X_5_real,
    output signed [31:0] m_X_5_imag, 
    output signed [31:0] m_X_6_real,
    output signed [31:0] m_X_6_imag, 
    output signed [31:0] m_X_7_real,
    output signed [31:0] m_X_7_imag 
);

    reg [2:0]  r_valid;
    
    reg signed [15:0] r_Xee_0_real;
    reg signed [15:0] r_Xee_1_real;
    reg signed [15:0] r_Xeo_0_real;
    reg signed [15:0] r_Xeo_1_real;
    reg signed [15:0] r_Xoe_0_real;
    reg signed [15:0] r_Xoe_1_real;
    reg signed [15:0] r_Xoo_0_real;
    reg signed [15:0] r_Xoo_1_real;

    reg signed [15:0] r_Xe_0_real;
    reg signed [15:0] r_Xe_0_imag;
    reg signed [15:0] r_Xe_1_real;
    reg signed [15:0] r_Xe_1_imag;
    reg signed [15:0] r_Xe_2_real;
    reg signed [15:0] r_Xe_2_imag;
    reg signed [15:0] r_Xe_3_real;
    reg signed [15:0] r_Xe_3_imag;
    reg signed [15:0] r_Xo_0_real;
    reg signed [15:0] r_Xo_0_imag;
    reg signed [15:0] r_Xo_1_real;
    reg signed [15:0] r_Xo_1_imag;
    reg signed [15:0] r_Xo_2_real;
    reg signed [15:0] r_Xo_2_imag;
    reg signed [15:0] r_Xo_3_real;
    reg signed [15:0] r_Xo_3_imag;
        
    reg signed [31:0] r_X_0_real;
    reg signed [31:0] r_X_0_imag;
    reg signed [31:0] r_X_1_real;
    reg signed [31:0] r_X_1_imag;
    reg signed [31:0] r_X_2_real;
    reg signed [31:0] r_X_2_imag;
    reg signed [31:0] r_X_3_real;
    reg signed [31:0] r_X_3_imag;
    reg signed [31:0] r_X_4_real;
    reg signed [31:0] r_X_4_imag;
    reg signed [31:0] r_X_5_real;
    reg signed [31:0] r_X_5_imag;
    reg signed [31:0] r_X_6_real;
    reg signed [31:0] r_X_6_imag;
    reg signed [31:0] r_X_7_real;
    reg signed [31:0] r_X_7_imag;



    reg signed [15:0] Xee_0_real;
    reg signed [15:0] Xee_1_real;
    reg signed [15:0] Xeo_0_real;
    reg signed [15:0] Xeo_1_real;
    reg signed [15:0] Xoe_0_real;
    reg signed [15:0] Xoe_1_real;
    reg signed [15:0] Xoo_0_real;
    reg signed [15:0] Xoo_1_real;

    reg signed [15:0] Xe_0_real;
    reg signed [15:0] Xe_0_imag;
    reg signed [15:0] Xe_1_real;
    reg signed [15:0] Xe_1_imag;
    reg signed [15:0] Xe_2_real;
    reg signed [15:0] Xe_2_imag;
    reg signed [15:0] Xe_3_real;
    reg signed [15:0] Xe_3_imag;
    reg signed [15:0] Xo_0_real;
    reg signed [15:0] Xo_0_imag;
    reg signed [15:0] Xo_1_real;
    reg signed [15:0] Xo_1_imag;
    reg signed [15:0] Xo_2_real;
    reg signed [15:0] Xo_2_imag;
    reg signed [15:0] Xo_3_real;
    reg signed [15:0] Xo_3_imag;

    reg signed [31:0] X_0_real;
    reg signed [31:0] X_0_imag;
    reg signed [31:0] X_1_real;
    reg signed [31:0] X_1_imag;
    reg signed [31:0] X_2_real;
    reg signed [31:0] X_2_imag;
    reg signed [31:0] X_3_real;
    reg signed [31:0] X_3_imag;
    reg signed [31:0] X_4_real;
    reg signed [31:0] X_4_imag;
    reg signed [31:0] X_5_real;
    reg signed [31:0] X_5_imag;
    reg signed [31:0] X_6_real;
    reg signed [31:0] X_6_imag;
    reg signed [31:0] X_7_real;
    reg signed [31:0] X_7_imag;


    reg signed [31:0] X_1_temp_real, X_1_temp_imag;
    reg signed [31:0] X_3_temp_real, X_3_temp_imag;
    reg signed [31:0] X_5_temp_real, X_5_temp_imag;
    reg signed [31:0] X_7_temp_real, X_7_temp_imag;


assign s_ready = ~m_valid | m_ready;

//flow of valid
always @(posedge clk or negedge reset_n) begin
	if(!reset_n) begin
		r_valid <= 3'd0;
	end else if (s_ready) begin
		r_valid <= {r_valid[1:0], s_valid};
	end
end


//reset signal

always @(posedge clk) begin
    if(!reset_n) begin
        r_Xee_0_real <= 16'b0;
        r_Xee_1_real <= 16'b0;

        r_Xeo_0_real <= 16'b0;
        r_Xeo_1_real <= 16'b0;
        
        r_Xoe_0_real <= 16'b0;
        r_Xoe_1_real <= 16'b0;

        r_Xoo_0_real <= 16'b0;
        r_Xoo_1_real <= 16'b0;


        r_Xe_0_real <= 16'b0;
        r_Xe_0_imag <= 16'b0;
        r_Xe_1_real <= 16'b0;
        r_Xe_1_imag <= 16'b0;
        r_Xe_2_real <= 16'b0;
        r_Xe_2_imag <= 16'b0;
        r_Xe_3_real <= 16'b0;
        r_Xe_3_imag <= 16'b0;

        r_Xo_0_real <= 16'b0;
        r_Xo_0_imag <= 16'b0;
        r_Xo_1_real <= 16'b0;
        r_Xo_1_imag <= 16'b0;
        r_Xo_2_real <= 16'b0;
        r_Xo_2_imag <= 16'b0;
        r_Xo_3_real <= 16'b0;
        r_Xo_3_imag <= 16'b0;
        

        r_X_0_real <= 32'b0;
        r_X_0_imag <= 32'b0;
        r_X_1_real <= 32'b0;
        r_X_1_imag <= 32'b0;
        r_X_2_real <= 32'b0;
        r_X_2_imag <= 32'b0;
        r_X_3_real <= 32'b0;
        r_X_3_imag <= 32'b0;
        r_X_4_real <= 32'b0;
        r_X_4_imag <= 32'b0;
        r_X_5_real <= 32'b0;
        r_X_5_imag <= 32'b0;
        r_X_6_real <= 32'b0;
        r_X_6_imag <= 32'b0;
        r_X_7_real <= 32'b0;
        r_X_7_imag <= 32'b0;
    end
    else if(s_ready) begin
        r_Xee_0_real <= Xee_0_real;
        r_Xee_1_real <= Xee_1_real;

        r_Xeo_0_real <= Xeo_0_real;
        r_Xeo_1_real <= Xeo_1_real;
        
        r_Xoe_0_real <= Xoe_0_real;
        r_Xoe_1_real <= Xoe_1_real;

        r_Xoo_0_real <= Xoo_0_real;
        r_Xoo_1_real <= Xoo_1_real;


        r_Xe_0_real <= Xe_0_real;
        r_Xe_0_imag <= Xe_0_imag;
        r_Xe_1_real <= Xe_1_real;
        r_Xe_1_imag <= Xe_1_imag;
        r_Xe_2_real <= Xe_2_real;
        r_Xe_2_imag <= Xe_2_imag;
        r_Xe_3_real <= Xe_3_real;
        r_Xe_3_imag <= Xe_3_imag;

        r_Xo_0_real <= Xo_0_real;
        r_Xo_0_imag <= Xo_0_imag;
        r_Xo_1_real <= Xo_1_real;
        r_Xo_1_imag <= Xo_1_imag;
        r_Xo_2_real <= Xo_2_real;
        r_Xo_2_imag <= Xo_2_imag;
        r_Xo_3_real <= Xo_3_real;
        r_Xo_3_imag <= Xo_3_imag;



        r_X_0_real <= X_0_real;
        r_X_0_imag <= X_0_imag;
        r_X_1_real <= X_1_real;
        r_X_1_imag <= X_1_imag;
        r_X_2_real <= X_2_real;
        r_X_2_imag <= X_2_imag;
        r_X_3_real <= X_3_real;
        r_X_3_imag <= X_3_imag;
        r_X_4_real <= X_4_real;
        r_X_4_imag <= X_4_imag;
        r_X_5_real <= X_5_real;
        r_X_5_imag <= X_5_imag;
        r_X_6_real <= X_6_real;
        r_X_6_imag <= X_6_imag;
        r_X_7_real <= X_7_real;
        r_X_7_imag <= X_7_imag;


    end
end 


always @(*) begin

//2-point DFT calculation

    Xee_0_real = x0 + x4;  
    Xee_1_real = x0 - x4;  

    Xeo_0_real = x2 + x6;  
    Xeo_1_real = x2 - x6;

    Xoe_0_real = x1 + x5; 
    Xoe_1_real = x1 - x5;  

    Xoo_0_real = x3 + x7; 
    Xoo_1_real = x3 - x7; 

//4-point DFT calculation

    Xe_0_real = r_Xee_0_real + r_Xeo_0_real;
    Xe_0_imag = 'b0;

    Xe_1_real = r_Xee_1_real;
    Xe_1_imag = -r_Xeo_1_real;
    
    Xe_2_real = r_Xee_0_real - r_Xeo_0_real;
    Xe_2_imag = 'b0;
    
    Xe_3_real = r_Xee_1_real;
    Xe_3_imag = r_Xeo_1_real;

    
    Xo_0_real = r_Xoe_0_real + r_Xoo_0_real;
    Xo_0_imag = 'b0;
    
    Xo_1_real = r_Xoe_1_real;
    Xo_1_imag = -r_Xoo_1_real;
    
    Xo_2_real = r_Xoe_0_real - r_Xoo_0_real;
    Xo_2_imag = 'b0;
    
    Xo_3_real = r_Xoe_1_real;
    Xo_3_imag = r_Xoo_1_real;

//8-point DFT calculation

    X_0_real = r_Xe_0_real + r_Xo_0_real;
    X_0_imag = r_Xe_0_imag + r_Xo_0_imag;

    // W_8^1 = cos(pi/4) - j*sin(pi/4) = 0.707 - j*0.707
    // 0.707 is approximately 23170 in a 16-bit signed fixed-point
    X_1_temp_real = (r_Xo_1_real *  23170 + r_Xo_1_imag * 23170) >>> 15;
    X_1_temp_imag = (r_Xo_1_real * -23170 + r_Xo_1_imag * 23170) >>> 15;
    X_1_real = r_Xe_1_real + X_1_temp_real;
    X_1_imag = r_Xe_1_imag + X_1_temp_imag;

    X_2_real = r_Xe_2_real +r_Xo_2_imag;
    X_2_imag = r_Xe_2_imag -r_Xo_2_real; 

    // W_8^3 = cos(3*pi/4) - j*sin(3*pi/4) = -0.707 - j*0.707
    X_3_temp_real = (r_Xo_3_real * -23170 + r_Xo_3_imag *  23170) >>> 15;
    X_3_temp_imag = (r_Xo_3_real * -23170 + r_Xo_3_imag * -23170) >>> 15; 
    X_3_real = r_Xe_3_real + X_3_temp_real;
    X_3_imag = r_Xe_3_imag + X_3_temp_imag;



    X_4_real = r_Xe_0_real - r_Xo_0_real;
    X_4_imag = r_Xe_0_imag - r_Xo_0_imag;

    X_5_temp_real = (r_Xo_1_real * -23170 + r_Xo_1_imag * -23170) >>> 15; 
    X_5_temp_imag = (r_Xo_1_real *  23170 + r_Xo_1_imag * -23170) >>> 15; 
    X_5_real = r_Xe_1_real + X_5_temp_real;  
    X_5_imag = r_Xe_1_imag + X_5_temp_imag;

    X_6_real = r_Xe_2_real - r_Xo_2_imag; 
    X_6_imag = r_Xe_2_imag + r_Xo_2_real;

    X_7_temp_real = (r_Xo_3_real *  23170 + r_Xo_3_imag * -23170) >>> 15; 
    X_7_temp_imag = (r_Xo_3_real *  23170 + r_Xo_3_imag *  23170) >>> 15; 
    X_7_real = r_Xe_3_real + X_7_temp_real; 
    X_7_imag = r_Xe_3_imag + X_7_temp_imag;


 end


assign m_valid = r_valid[2];

assign m_X_0_real = r_X_0_real;
assign m_X_0_imag = r_X_0_imag; 
assign m_X_1_real = r_X_1_real;
assign m_X_1_imag = r_X_1_imag;
assign m_X_2_real = r_X_2_real;
assign m_X_2_imag = r_X_2_imag;
assign m_X_3_real = r_X_3_real;
assign m_X_3_imag = r_X_3_imag;
assign m_X_4_real = r_X_4_real;
assign m_X_4_imag = r_X_4_imag;
assign m_X_5_real = r_X_5_real;
assign m_X_5_imag = r_X_5_imag;
assign m_X_6_real = r_X_6_real;
assign m_X_6_imag = r_X_6_imag;
assign m_X_7_real = r_X_7_real;
assign m_X_7_imag = r_X_7_imag;


endmodule