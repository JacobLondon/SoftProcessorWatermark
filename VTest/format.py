
size = 32
str_size = f"{size}'b"
initialize = '0'

output = ''

for increment in range(size):
    output += f'rmemory[{increment}] = {str_size}' + (initialize * size) + ';\n'

print(output)
