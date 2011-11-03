`timescale 1ns / 1ps
module VRAM(
	input					RST_I,
	input					CLK_I,
	input		[12:0]	ADR_I,
	input					CYC_I,
	input					STB_I,
	output				ACK_O,
	output	[15:0]	DAT_O
);

	reg				raw_ack;
	reg				ram_ack;
	wire	[15:0]	dat0, dat1, dat2, dat3, dat4, dat5, dat6, dat7;
	reg	[15:0]	ram_q;

	assign	ACK_O	= ram_ack;
	assign	DAT_O = ram_q;

	always @(*) begin
		ram_ack <= raw_ack & CYC_I & STB_I;
		
		case(ADR_I[12:10])
			0:	ram_q <= dat0;
			1: ram_q <= dat1;
			2:	ram_q <= dat2;
			3:	ram_q <= dat3;
			4:	ram_q <= dat4;
			5: ram_q <= dat5;
			6:	ram_q <= dat6;
			7:	ram_q <= dat7;
		endcase
	end

	always @(posedge CLK_I) begin
		raw_ack <= STB_I & !raw_ack;
	end

	RAMB16_S18 r0(
		.WE(1'b0),
		.EN(ADR_I[12:10] == 0),
		.SSR(RST_I),
		.CLK(CLK_I),
		.ADDR(ADR_I[9:0]),
		.DO(dat0),
		.DI(16'hFFFF),
		.DIP(2'b11)
	);

	RAMB16_S18 r1(
		.WE(1'b0),
		.EN(ADR_I[12:10] == 1),
		.SSR(RST_I),
		.CLK(CLK_I),
		.ADDR(ADR_I[9:0]),
		.DO(dat1),
		.DI(16'hFFFF),
		.DIP(2'b11)
	);

	RAMB16_S18 r2(
		.WE(1'b0),
		.EN(ADR_I[12:10] == 2),
		.SSR(RST_I),
		.CLK(CLK_I),
		.ADDR(ADR_I[9:0]),
		.DO(dat2),
		.DI(16'hFFFF),
		.DIP(2'b11)
	);

	RAMB16_S18 r3(
		.WE(1'b0),
		.EN(ADR_I[12:10] == 3),
		.SSR(RST_I),
		.CLK(CLK_I),
		.ADDR(ADR_I[9:0]),
		.DO(dat3),
		.DI(16'hFFFF),
		.DIP(2'b11)
	);

	RAMB16_S18 r4(
		.WE(1'b0),
		.EN(ADR_I[12:10] == 4),
		.SSR(RST_I),
		.CLK(CLK_I),
		.ADDR(ADR_I[9:0]),
		.DO(dat4),
		.DI(16'hFFFF),
		.DIP(2'b11)
	);

	RAMB16_S18 r5(
		.WE(1'b0),
		.EN(ADR_I[12:10] == 5),
		.SSR(RST_I),
		.CLK(CLK_I),
		.ADDR(ADR_I[9:0]),
		.DO(dat5),
		.DI(16'hFFFF),
		.DIP(2'b11)
	);

	RAMB16_S18 r6(
		.WE(1'b0),
		.EN(ADR_I[12:10] == 6),
		.SSR(RST_I),
		.CLK(CLK_I),
		.ADDR(ADR_I[9:0]),
		.DO(dat6),
		.DI(16'hFFFF),
		.DIP(2'b11)
	);

	RAMB16_S18 r7(
		.WE(1'b0),
		.EN(ADR_I[12:10] == 7),
		.SSR(RST_I),
		.CLK(CLK_I),
		.ADDR(ADR_I[9:0]),
		.DO(dat7),
		.DI(16'hFFFF),
		.DIP(2'b11)
	);

	defparam
r0.INIT_3F = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_3E = 256'h55555555555555555555555555555555AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_3D = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_3C = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_3B = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_3A = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_39 = 256'h55555555555555555555000000000000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_38 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_37 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA000C228AF1C2,
r0.INIT_36 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_35 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_34 = 256'h55555555555555555555010C228A8882AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_33 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_32 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA019822FA8882,
r0.INIT_31 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_30 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_2F = 256'h55555555555555555555C1D82A53F082AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_2E = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_2D = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA21F02A528882,
r0.INIT_2C = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_2B = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_2A = 256'h5555555555555555555521FC36228882AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_29 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_28 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC1F8A223F1CF,
r0.INIT_27 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_26 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_25 = 256'h5555555555555555555501F000000000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_24 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_23 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAE1E0A0FB7228,
r0.INIT_22 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_21 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_20 = 256'h5555555555555555555501C0A0828A28AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_1F = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_1E = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA0180A0820A28,
r0.INIT_1D = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_1C = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_1B = 256'h555555555555555555558100BC8373EAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_1A = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_19 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA0000A282822A,
r0.INIT_18 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_17 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_16 = 256'h555555555555555555550000A282894DAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_15 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_14 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAE000BC837088,
r0.INIT_13 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_12 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_11 = 256'h55555555555555555555000000000000AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_10 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_0F = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEF88088B8BE7,
r0.INIT_0E = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_0D = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_0C = 256'h55555555555555555555080088929208AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_0B = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_0A = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA080888A2A200,
r0.INIT_09 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_08 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_07 = 256'h55555555555555555555880808F3C387AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_06 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_05 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA081C088AA208,
r0.INIT_04 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_03 = 256'h5555555555555555555555555555555555555555555555555555555555555555,
r0.INIT_02 = 256'h55555555555555555555081C888A9208AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_01 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,
r0.INIT_00 = 256'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAE8083EF38BE7;

endmodule