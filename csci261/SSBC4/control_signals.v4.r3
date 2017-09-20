SSBC Control Signals 

Control signals are all asserted active-high.

Registers 
---------
Program counter (PC) 16 bits
Stack pointer (SP) 16 bits
Memory register (MR) 16 bits
ALU registers (R0, R1, R2) 8 bits each
Instruction Register (IR) 8 bits

Busses/Signals
--------------
Internal address bus (int_abus) 16 bits
Internal read data bus (int_rbus) 8 bits
Internal write data bus (int_wbus) 8 bits
ALU output (alu_out) 8 bits

Operation          Behaviour/Meaning
---------          -----------------
halt               halt the CU
fault              signal a fault
br                 memory read/write request
read               memoryRead
write              memoryWrite
initPC             PC <= 0
initSP             SP <= 0xFFFA
initR1             R1 <= 0x00
abusPC             int_abus <= PC
abusSP             int_abus <= SP
abusMR             int_abus <= MR
IRrbus             IR <= int_rbus
R0rbus             R0 <= int_rbus
R1rbus             R1 <= int_rbus
wbusR0             int_wbus <= R0
wbusR2             int_wbus <= R2
wbusPSW            int_wbus <= PSW
PCR1R0             PC <= R1#R0
MRR1R0             MR <= R1#R0
R2alu              R2 <= alu_out
PSWalu             PSW <= alu_out
addop              alu_out <= R0 + R1
subop              alu_out <= R0 - R1
norop              alu_out <= R0 nor R1
incPC              PC <= PC + 1
incSP              SP <= SP + 1
decSP              SP <= SP - 1
