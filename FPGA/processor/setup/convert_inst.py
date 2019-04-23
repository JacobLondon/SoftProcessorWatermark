
# Use to convert instructions to hex
# http://www.kurtm.net/mipsasm/index.cgi

hex_insts = open('hex_inst.txt', 'r')

bits = 32   # how many bits each instruction is
base = 16  # base to convert to

converted_binary_insts = []

for inst in hex_insts.readlines():
    binary = bin(int(inst, base))[2:].zfill(bits)
    converted_binary_insts.append(binary)

output = ''
mem_name = 'memdata'
for line_no, inst in enumerate(converted_binary_insts):
    output += f"{mem_name}[{line_no}] = {bits}'b{inst};\n"

print(output)
