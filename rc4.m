clc;
clear all;
close all;
n = zeros(1,256);
str = input('Enter the key: ');
key = double(char(str));
disp(str);
disp(key);
k = zeros(1,256);
message = input('Enter the Message which you want to encrypt: '); 
msg = double(char(message));
disp(message);
disp(msg);
keylen = length(key);
for i = 1:256
n(i) = i-1;
a = mod(i-1, keylen)+1;
k(i) = key(a);
end
j=0;
for i = 1:256
j = mod((i+n(i)+k(i)),256)+1;
n([i j]) = n([j i]);
end
ciphtext = [];
ciphtextstore = [];
keystream = [];
j = 0;
for i = 1:length(msg)
j = mod((j + n(i)), 256)+1;
n([i j]) = n([j i]);
a = mod((n(i)+n(j)),256)+i;
currentkey = n(i);
keystream = [keystream, currentkey]; 
ciphtext(i) = bitxor(msg(i), currentkey);
ciphtextstore = [ciphtextstore, ciphtext]; 
end
ciphertextstring = char(ciphtextstore); 
disp("ciphertext:")
disp(ciphertextstring);
decryptedmsg = [];
for p = 1:length(ciphtext)
currentmsg = bitxor(ciphtext(p), keystream(p)); 
decryptedmsg = [decryptedmsg, currentmsg]; 
end
decryptedoutput = char(decryptedmsg); 
disp("decrypted message:");
disp(decryptedoutput)