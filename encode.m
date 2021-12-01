function [outImg] = encode(encText,imAr)
%ENCODE Summary of this function goes here
%   Detailed explanation goes here
    IMGSIZE = size(imAr);
    IMGSIZE_A = IMGSIZE(1);
    IMGSIZE_B = IMGSIZE(2);
    encodeMsg = [encText,'@']; %Add a stop flag
    placement = 1;  %Placement of the 'cursor' so to speak, where in the image is the next line being inserted
    % Split the image into red, blue, and green, allowing condensed LSB
    % encoding taking only 3 pixels per character rather than 8.
    redL = imAr(:,:,1); 
    bluL = imAr(:,:,2);
    greL = imAr(:,:,3);
    %Begin encoding
    save('encode')
    for i = 1:length(encodeMsg) %Begin Message encoding
        binEnc = dec2bin(encodeMsg(i),8); %Get binary value of a character
        %Assign the lsb of each character based on mod2 value, 0 or 1.
        redL(placement) = redL(placement) - mod(redL(placement),2) + binEnc(1);
        bluL(placement) = bluL(placement)  - mod(bluL(placement),2) + binEnc(2);
        greL(placement) = greL(placement)  - mod(greL(placement),2) + binEnc(3);
        redL(placement+1) = redL(placement+1)  - mod(redL(placement+1),2) + binEnc(4);
        bluL(placement+1) = bluL(placement+1)  - mod(bluL(placement+1),2) + binEnc(5);
        greL(placement+1) = greL(placement+1)  - mod(greL(placement+1),2) + binEnc(6);
        redL(placement+2) = redL(placement+2)  - mod(redL(placement+2),2) + binEnc(7);
        bluL(placement+2) = bluL(placement+2)  - mod(bluL(placement+2),2) + binEnc(8);
        placement = placement +3; %Iterate 'cursor'
    end %end Encoding
    outImg = zeros(IMGSIZE_A,IMGSIZE_B,3);
    outImg(:,:,1) = redL(:,:);
    outImg(:,:,2) = bluL(:,:);
    outImg(:,:,3) = greL(:,:);
    outImg = uint8(outImg);
end