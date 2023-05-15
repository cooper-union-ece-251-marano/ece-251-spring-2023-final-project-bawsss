#!usr/bin/env python3

import sys

opCodes = {
        'add':'0x0',
        'sub':'0x1',
        'move':'0x2',
        'jr':'0x3',
        'and':'0x4',
        'or':'0x5',
        'sll':'0x6',
        'srl':'0x7',
        'slt':'0x8',
        'beq':'0x9',
        'addi':'0xA',
        'subi':'0xB',
        'lw':'0xC',
        'sw':'0xD',
        'j':'0xE',
        'jal':'0xF'
        }

registers = {
        '$zero':'0',
        '$at':'1',
        '$v0':'2',
        '$v1':'3',
        '$a0':'4',
        '$a1':'5',
        '$t0':'6',
        '$t1':'7',
        '$t2':'8',
        '$t3':'9',
        '$s0':'A',
        '$s1':'B',
        '$s2':'C',
        '$s3':'D',
        '$sp':'E',
        '$ra':'F'
        }

def main():
    file = open(sys.argv[1])
    machineCode = open("../elements/bawsss_computer/imem_datafile.dat", "w")
    machineCodeSampleCopy = open("../bawsssASSEMBLER/machineCode.txt", "w")
    lines = []
    while True:
        line = file.readline()
        if not line:
            break
        if len(line) == 1 or line[0] == '#' or line[0] == " ":
            continue
        else:
            stripped = line.split("#", 1)[0]
            lines.append(stripped.strip())
    file.close()

    for i in range(len(lines)):
        lines[i] = lines[i].replace(',', ' ')
        lines[i] = lines[i].replace('(', ' ')
        lines[i] = lines[i].replace(')', ' ')
        lines[i] = lines[i].replace(",", '')

        lines[i] = lines[i].split()
        for j in range(len(lines[i])):
            try: lines[i][j] = hex(int(opCodes[lines[i][j]], 16))
            except: pass
            try: lines[i][j] = hex(int(registers[lines[i][j]], 16))
            except: pass
            try: lines[i][j] = hex(int(lines[i][j]), 16)
            except: pass

    for i in range(len(lines)):
        op = int(lines[i][0],16)
        if op == 3:
            lines[i] = (hex(op) + lines[i][1] + '00').replace('0x','')
        elif op in range(0,9):
            try: lines[i] = (hex(op) + lines[i][2] + lines[i][3] + lines[i][1]).replace('0x','')
            except: lines[i] = (hex(op) + lines[i][2] + '0' + lines[i][1]).replace('0x','')
        elif op == 9:
            lines[i] = (hex(op) + lines[i][1] + lines[i][2] + hex(int(lines[i][3],16) >> 1)).replace('0x','')
        elif op == 12 or op == 13:
            lines[i] = (hex(op) + lines[i][3] + lines[i][1] + lines[i][2]).replace('0x','')
        elif op in range(10,14):
            lines[i] = (hex(op) + lines[i][2] + lines[i][1] + toHex(int(lines[i][3],16),4)).replace('0x','')
        else:
            lines[i] = (hex(op) + "0x{:03x}".format(int(lines[i][1],16) >> 1)).replace('0x','')

    for i in range(len(lines)):
        machineCode.write(lines[i]+"\n")
        machineCodeSampleCopy.write(lines[i]+"\n")




def toHex(val, nbits):
    return hex((val + (1 << nbits)) % (1 << nbits))

if __name__ == "__main__":
    main()
