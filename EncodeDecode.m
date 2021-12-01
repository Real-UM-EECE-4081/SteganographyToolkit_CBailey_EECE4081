% % %Testbench
% pngimgRed = imread('1024x_test.png');
% encodeTxt = 'The file encoded 1024';
% meowthree = encode(encodeTxt,imgRed);
% Recap = decode(meowthree);
% imwrite(meowthree, '1024.png','png');
a = imread('app1280x.png');
textOut = decode(a);