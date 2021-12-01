function [outStr] = decode(inImg)
%DECODE Summary of this function goes here
%   Detailed explanation goes here
    % Split the image into red, blue, and green
    done = false;
    placement = 1;
    IMGSIZE = size(inImg);
    IMGSIZE_A = IMGSIZE(1);
    IMGSIZE_B = IMGSIZE(2);
    
    redL = inImg(:,:,1); 
    bluL = inImg(:,:,2);
    greL = inImg(:,:,3);
    outStr = '';
    i = 1;
    while (done == false)&&placement<(numel(redL)-3) %Stop on last few pixels incase of invalid encoding.
        nxtChar = [dec2bin(mod(redL(placement),2)),dec2bin(mod(bluL(placement),2)),dec2bin(mod(greL(placement),2)),dec2bin(mod(redL(placement+1),2)),dec2bin(mod(bluL(placement+1),2)),dec2bin(mod(greL(placement+1),2)),dec2bin(mod(redL(placement+2),2)),dec2bin(mod(bluL(placement+2),2)),];
        if(bin2dec(nxtChar) == '@') 
            save('decode')
            done = true;%Break on stop flag
        else
            outStr = [outStr,bin2dec(nxtChar)]; %Otherwise, append next char to output
        end
        i = i + 1;
        placement = placement + 3;
    end    
end