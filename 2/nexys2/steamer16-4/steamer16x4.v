`timescale 1ns / 1ps

`define	OPC_NOP		4'b0000
`define	OPC_LIT		4'b0001
`define	OPC_FWM		4'b0010
`define	OPC_SWM		4'b0011
`define	OPC_ADD		4'b0100
`define	OPC_AND		4'b0101
`define	OPC_XOR		4'b0110
`define	OPC_ZGO		4'b0111
`define	OPC_unk0		4'b1000
`define	OPC_unk1		4'b1001
`define	OPC_FBM		4'b1010
`define	OPC_SBM		4'b1011
`define	OPC_unk4		4'b1100
`define	OPC_unk5		4'b1101
`define	OPC_unk6		4'b1110
`define	OPC_unk7		4'b1111

module STEAMER16X4(
	input					clk_i,
	input					res_i,
	output	[15:1]	adr_o,
	output				we_o,
	output				cyc_o,
	output	[1:0]		stb_o,
	output				vda_o,
	output				vpa_o,
	output	[15:0]	dat_o,
	input					ack_i,
	input		[15:0]	dat_i
);

	reg	[15:1]	adr;
	reg				we;
	reg				cyc;
	reg	[1:0]		stb;
	reg				vda;
	reg				vpa;
	reg	[15:0]	dat;

	assign adr_o = adr;
	assign we_o  = we;
	assign cyc_o = cyc;
	assign stb_o = stb;
	assign vda_o = vda;
	assign vpa_o = vpa;
	assign dat_o = dat;

	// STORY 0010
	wire				cycle_done = (cyc & ack_i) | ~cyc;

	reg	[4:0]		t;
	reg	[15:1]	p;
	reg	[15:0]	x, y, z, next_x, next_y, next_z;
	reg	[15:0]	ir;

	wire				t0 = t[0];
	wire				no_more_instructions = t0 ? (dat_i == 16'h0000) : (ir[11:0] == 12'h000);
	wire	[3:0]		current_opcode = ir[15:12];
	wire				increment_p = t0 | (current_opcode == `OPC_LIT);
	wire				goto_t0 = res_i | no_more_instructions;
	wire	[15:1]	next_p = (res_i)? 15'h7FF8 : (increment_p)? p+1 : p;
	wire	[4:0]		next_t = (goto_t0)? 5'hb00001 : (t << 1);

	always @(*) begin
		if(t0)	begin
			adr <= p;
			we <= 0;
			cyc <= 1;
			stb <= 2'b11;
			vda <= 0;
			vpa <= 1;
			dat <= 0;
			next_x <= x;
			next_y <= y;
			next_z <= z;
		end
		else begin
			case(current_opcode)
			`OPC_NOP:	begin
								we <= 0;
								cyc <= 0;
								stb <= 2'b00;
								vda <= 0;
								vpa <= 0;
								adr <= 0;
								dat <= 0;
								next_x <= x;
								next_y <= y;
								next_z <= z;
							end
							
			`OPC_LIT:	begin
								we <= 0;
								cyc <= 1;
								stb <= 2'b11;
								vda <= 1;
								vpa <= 1;
								adr <= p;
								dat <= 0;
								next_x <= y;
								next_y <= z;
								next_z <= dat_i;
							end
			`OPC_FWM:	begin
								we <= 0;
								cyc <= 1;
								stb <= 2'b11;
								vda <= 1;
								vpa <= 0;
								adr <= z[15:1];
								dat <= 0;
								next_x <= x;
								next_y <= y;
								next_z <= dat_i;
							end
			`OPC_SWM:	begin
								we <= 1;
								cyc <= 1;
								stb <= 2'b11;
								vda <= 1;
								vpa <= 0;
								adr <= z[15:1];
								dat <= y;
								next_x <= x;
								next_y <= x;
								next_z <= x;
							end
			`OPC_FBM:	begin
								we <= 0;
								cyc <= 1;
								stb <= {z[0], ~z[0]};
								vda <= 1;
								vpa <= 0;
								adr <= z[15:1];
								dat <= 0;
								next_x <= x;
								next_y <= y;
								next_z <= z[0] ? {8'b00000000, dat_i[15:8]} : {8'b00000000, dat_i[7:0]};
							end
			`OPC_SBM:	begin
								we <= 1;
								cyc <= 1;
								stb <= {z[0], ~z[0]};
								vda <= 1;
								vpa <= 0;
								adr <= z[15:1];
								dat <= y;
								next_x <= x;
								next_y <= x;
								next_z <= x;
							end
			endcase
		end
	end

	always @(posedge clk_i) begin
		if(res_i || cycle_done) begin
			t <= next_t;
			p <= next_p;
		end
		if(cycle_done) begin
			if(t0)		ir <= dat_i;
			else			ir <= {ir[11:0], 4'b0000};
			x <= next_x;
			y <= next_y;
			z <= next_z;
		end
	end
	
	// Some random initial values, potentially in an inconsistent state until the processor is reset.
	initial begin
		ir <= 16'hFFFF;
		we <= 0;
		cyc <= 1;
		stb <= 2'b00;
		vda <= 1;
		vpa <= 0;
		dat <= 16'hBEEF;
		x <= 16'hCC00;
		y <= 16'hCC11;
		z <= 16'hCC22;
	end
endmodule
