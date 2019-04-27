import sys

class RType:
    def __init__(self, opcode, rs, rt, rd, shamt, funct):
        self.opcode = opcode
        self.rs = rs
        self.rt = rt
        self.rd = rd
        self.shamt = shamt
        self.funct = funct
class IType:
    def __init__(self, opcode, rs, rt, addr):
        self.opcode = opcode
        self.rs = rs
        self.rt = rt
        self.addr = addr

alu = {
    'add' : 0b100000,
    'sub' : 0b100010,
    'and' : 0b100100,
    'or'  : 0b100101,
    'lsr' : 0b000010,
    'lsl' : 0b000000,
}

operations = {
    'alu' : 0b000000,
    'lw'  : 0b100011,
    'sw'  : 0b101011,
    'beq' : 0b000100,
    'bne' : 0b000101
}

# registers in 32-bit hex
registers = {}
for r in range(32):
    registers[f'${r}'] = '{0:08x}'.format(0)

"""build the program in a list"""

# open the file
args = iter(sys.argv)
next(args)
program_file = open(next(args), 'r')

program = []
labels = {}
for nu, line in enumerate(program_file.readlines()):

    start = line.split()[0]
    words = iter(line.split())

    # determine the operation type
    # check if it's an alu operation
    if next(words) in alu.keys():

        op = RType(
            opcode=operations['alu'],
            rd=next(words),
            rs=next(words),
            rt=next(words),
            shamt=next(words),
            funct=alu[start]
        )
        program.append(op)
