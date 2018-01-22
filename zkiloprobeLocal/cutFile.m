

function cutFile(filename, nChansTotal, maxSample)

chunkSize = 1000000;

ext = filename(end-2:end);

origFile = [filename(1:end-4) '_all.' ext];
movefile(filename, origFile);

fid = fopen(origFile, 'r');
fidOut = fopen(filename, 'w');

endSamp = 0;
while 1
        
    dat = fread(fid, [nChansTotal chunkSize], '*int16');
    
    endSamp = endSamp+chunkSize;
    
    if ~isempty(dat)
        
        if endSamp>maxSample
        
            fwrite(fidOut, dat(:,1:maxSample-endSamp+chunkSize), 'int16');
            break
        else
                        
            fwrite(fidOut, dat, 'int16');
            
        end
    else
        break
    end
    
end