
/*
The designers:

Ahmet Can Mert <ahmetcanmert@sabanciuniv.edu>
Ferhat Yaman <ferhatyaman@sabanciuniv.edu>

To the extent possible under law, the implementer has waived all copyright
and related or neighboring rights to the source code in this file.
http://creativecommons.org/publicdomain/zero/1.0/
*/

module modred(input      [23:0] C,
              output reg [11:0] R);

// First Stage
wire [14:0] C0;
wire [14:0] S0;

dt0 level4_00 (
{C[0],!C[12],!C[14],!C[17],!C[18],!C[19],!C[20]},
{C[1],!C[13],!C[15],!C[17],!C[18],!C[20],!C[21],1'b1},
{C[2],!C[14],!C[16],!C[17],!C[18],!C[19],!C[21],!C[22]},
{C[3],!C[15],!C[18],!C[19],!C[20],!C[22],!C[23]},
{C[4],!C[16],!C[19],!C[20],!C[21],!C[23],1'b1},
{C[5],!C[17],!C[20],!C[21],!C[22]},
{C[6],!C[18],!C[21],!C[22],!C[23],1'b1},
{C[7],!C[19],!C[22],!C[23]},
{C[8], C[12],C[17],C[19],C[21],!C[14],!C[18],!C[21],!C[23]},
{C[9], C[12],C[13],C[15],C[19],C[18]},
{C[10],C[13],C[17],C[19],!C[18],!C[16],!C[15],1'b1},
{C[11],1'b1},
1'b1,
1'b1,
C0,S0
);

// Final Stage
wire [14:0] R0,R1,R2,R3,R4,R5;

dt1 level5_00(
{C0[0] ,S0[0] ,1'b1},
{C0[1] ,S0[1] ,1'b1},
{C0[2] ,S0[2] ,1'b1},
{C0[3] ,S0[3] ,1'b1},
{C0[4] ,S0[4] ,1'b1},
{C0[5] ,S0[5] ,1'b1},
{C0[6] ,S0[6] ,1'b1},
{C0[7] ,S0[7] ,1'b1},
{C0[8] ,S0[8] },
{C0[9] ,S0[9] ,1'b1},
{C0[10],S0[10]},
{C0[11],S0[11]},
{C0[12],S0[12],1'b1},
{C0[13],S0[13],1'b1},
{C0[14],S0[14],1'b1},
R0,R1);

dt2 level5_01(
{C0[0] ,S0[0] },
{C0[1] ,S0[1] ,1'b1},
{C0[2] ,S0[2] ,1'b1},
{C0[3] ,S0[3] ,1'b1},
{C0[4] ,S0[4] ,1'b1},
{C0[5] ,S0[5] ,1'b1},
{C0[6] ,S0[6] ,1'b1},
{C0[7] ,S0[7] ,1'b1},
{C0[8] ,S0[8] ,1'b1},
{C0[9] ,S0[9] },
{C0[10],S0[10],1'b1},
{C0[11],S0[11]},
{C0[12],S0[12]},
{C0[13],S0[13],1'b1},
{C0[14],S0[14],1'b1},
R2,R3);

dt3 level5_02(
{C0[0] ,S0[0] ,1'b1},
{C0[1] ,S0[1] },
{C0[2] ,S0[2] },
{C0[3] ,S0[3] },
{C0[4] ,S0[4] },
{C0[5] ,S0[5] },
{C0[6] ,S0[6] },
{C0[7] ,S0[7] },
{C0[8] ,S0[8] ,1'b1},
{C0[9] ,S0[9] },
{C0[10],S0[10],1'b1},
{C0[11],S0[11],1'b1},
{C0[12],S0[12]},
{C0[13],S0[13]},
{C0[14],S0[14]},
R4,R5);

wire [14:0] Rmp0;
wire [14:0] Rm1q,Rm2q,Rp1q;

assign Rmp0 = C0+S0;

assign Rm1q = R0+R1;
assign Rm2q = R2+R3;
assign Rp1q = R4+R5;

always @(*) begin
    if(Rm2q[14] == 0)
        R = Rm2q[11:0];
    else if(Rm1q[14] == 0)
        R = Rm1q[11:0];
    else if(Rmp0[14] == 0)
        R = Rmp0[11:0];
    else
        R = Rp1q[11:0];
end

endmodule
