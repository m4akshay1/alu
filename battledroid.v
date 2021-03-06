//DFF Module

/*
//OpCodes
`define NOOP  '4b0000 //00=system, 00=NOOP
`define RESET '4b0001 //00=system, 01=Reset
`define ADD   '4b0101 //01=Mathematics, 01=ADD
`define AND   '4b1001 //10=Logic, 01=AND
*/
// our opcodes
`define NOOP     '4b0000
`define RESET    '4b1100
`define SHUTDOWN '4b1101
`define STANDBY  '4b0100
`define ATTACK   '4b0101
`define GOTO     '4b0110
`define TARGET   '4b0111
`define RANK     '4b1000
`define BATTERY  '4b1001
`define ATLOC    '4b1010




//FLip Flop
/*module DFF(clk,in,out);
	parameter n=1;//width
	input clk;
	input [n-1:0] in;
	output [n-1:0] out;
	reg [n-1:0] out;

	always @(posedge clk)
	out = in;
endmodule

//HALF-ADDER
module Add_half (input a, b,  output c_out, sum);
   xor G1(sum, a, b);	 
   and G2(c_out, a, b);
endmodule

//FULL-ADDER
module Add_full (input a, b, c_in, output c_out, sum);
   wire w1, w2, w3;	 
   Add_half M1 (a, b, w1, w2);
   Add_half M0 (w2, c_in, w3, sum);
   or (c_out, w1, w3);
endmodule
*/

/*
Decoder (n to M)
module Dec(a,b);

parameter n=4;
parameter m=16;
input [n-1:0] a;
output [m-1:0] b;

assign  b= 1<<a; //Shift 1 a places. Makes a 1-hot.

endmodule


module Enc42(a,b);
input [3:0] a;
output [1:0] b;
assign b={a[3]|a[2],a[3]|a[1]};
endmodule


module Enc42a(a,b,c);
input [3:0] a;
output [1:0] b;
output c;
assign b={a[3]|a[2],a[3]|a[1]};
assign c=|a;
endmodule

module Enc164(a,b);
input [15:0] a;
output [3:0] b;
wire[7:0] c;
wire[3:0] d;

Enc42a e0(a[ 3: 0],c[1:0],d[0]);
Enc42a e1(a[ 7: 4],c[3:2],d[1]);
Enc42a e2(a[11: 8],c[5:4],d[2]);
Enc42a e3(a[15:12],c[7:6],d[3]);

Enc42 e4(d[3:0],b[3:2]);

endmodule


*/




/*ADD operation
module ADDER(inputA,inputB,outputC,carry);
//---------------------------------------
input [1:0] inputA;
input [1:0] inputB;
wire [1:0] inputA;
wire [1:0] inputB;
//---------------------------------------
output [1:0] outputC;
output carry;
reg [1:0] outputC;
reg carry;
//---------------------------------------

wire [1:0] S;
wire [1:0] Cin;
wire [1:0] Cout;
//Link the wires between the Adders
assign Cin[0]=0;
assign Cin[1]=Cout[0];

//Declare and Allocate 4 Full adders
Add_full FA[1:0] (inputA,inputB,Cin,Cout,S);

always @(*)
begin
 carry=Cout[1];
 outputC=S;
end

endmodule

//AND operation
module ANDER(inputA,inputB,outputC);
input [1:0] inputA;
input [1:0] inputB;
output [1:0] outputC;
wire [1:0] inputA;
wire [1:0] inputB;
reg [1:0] outputC;

reg [1:0] result;

always@(*)
begin
	result[0]=inputA[0]&inputB[0];
	result[1]=inputA[1]&inputB[1];
	outputC=result;
end
 
endmodule

//Accumulator Register
*/

//MUX Multiplexer 16 by 8
module Mux(channels,select,b);
input [15:0][7:0]channels;
input [3:0] select;
output [7:0] b;
wire[15:0][7:0] channels;
reg [7:0] b;
always @(*)
begin
 b=channels[select]; 
end

endmodule

//Breadboard
module breadboard(clk,DataIn,LocIn,GPS,opcode);
//----------------------------------
input clk;
input [3:0] opcode;
input [7:0] DataIn;
input [15:0] GPS;
input [15:0] LocIn;
wire clk;
wire [7:0] DataIn;
wire [15:0] GPS;
wire [3:0] opcode;
wire [15:0] LocIn;
//----------------------------------
output [7:0] DataOut;
reg [7:0] DataOut;
//----------------------------------

wire [15:0][7:0]channels;
wire [7:0] b;

//wire [1:0] outputADD;
//wire [1:0] outputAND;

/*
reg [1:0] regA;
reg [1:0] regB;

reg  [1:0] next;
wire [1:0] cur;
*/

Mux mux1(channels,opcode,b);
//DFF ACC1 [1:0] (clk,next,cur);


assign channels[0]=0;
assign channels[1]=1;
assign channels[2]=2;
assign channels[3]=3;
assign channels[4]=4;
assign channels[5]=5;
assign channels[6]=6;
assign channels[7]=7;
assign channels[8]=8;
assign channels[9]=9;
assign channels[10]=10;
assign channels[11]=11;
assign channels[12]=12;
assign channels[13]=13;
assign channels[14]=14;
assign channels[15]=15;

/*always @(*)
begin
 //regA=A;
 //regB=cur;

 //assign C=b;
 //assign next=b;
end
*/

endmodule
/*
always @(*)
begin
 regA=A;
 regB=cur;

 assign C=b;
 assign next=b;
end

endmodule
*/



//TEST BENCH
module testbench();

//Local Variables
   reg clk;
   reg [7:0] DataIn;
   reg [15:0] LocIn;
   reg [15:0] GPS;
   //wire [7:0] outputC;
   reg [3:0] opcode;

   



// create breadboard
breadboard bb8(clk,DataIn,LocIn,GPS,opcode);


   //CLOCK
   initial begin //Start Clock Thread
     forever //While TRUE
        begin //Do Clock Procedural
          clk=0; //square wave is low
          #5; //half a wave is 5 time units
          clk=1;//square wave is high
          #5; //half a wave is 5 time units
        end
    end



    initial begin //Start Output Thread
	forever
         begin
		 //$display("(ACC:%2b)(OPCODE:%4b)(IN:%2b)(OUT:%2b)",bb8.cur,opcode,inputA,bb8.b);
		 $display("Hello World");
		 #10;
		 end
	end

//STIMULOUS  clk,DataIn,LocIn,GPS,opcode
	//Test input
	initial begin
	#6;
	DataIn= 8'b00000000;
	LocIn = 16'b0000000000000000;
	GPS   =  16'b0000000000000000;
	opcode= 4'b0000; //NO-OP
	//#10; 
	
	
	
	$finish;
	end

endmodule