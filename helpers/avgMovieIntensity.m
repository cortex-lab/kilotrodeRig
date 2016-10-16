
function avgMovieIntensity(direc, fname, outputSuffix, makePlots, ROI, varargin)
%function avgMovieIntensity(direc, fname, outputSuffix, makePlots, ROI[, datPath])

if ~isempty(varargin)
    datPath = varargin{1};
else
    datPath = [];
end

vr = VideoReader(fullfile(direc, [fname '.mj2']));

nF = get(vr, 'NumberOfFrames');
avgIntensity = zeros(1, nF);

if ~isempty(datPath)
    fnOut = fullfile(datPath);
    fid = fopen(fnOut, 'w');
end
if isempty(ROI)
    ROI = [1 1 vr.Width vr.Height];
elseif strcmp(ROI, 'ask')
    f = figure; 
    img1 = read(vr,round(nF/2));
    imagesc(img1); colormap gray
    title('choose roi');
    q = imrect;
    ROI = q.getPosition;
    close(f);
end

if makePlots
    f = figure; set(f, 'Name', fname);
end

tic


% for f = 1:nF
%     img = read(vr, f);
%     avgIntensity(f) = mean(img(:));
%
%     if mod(f, 1000)==0
%            fprintf(1, '%d / %d\n', f, nF);
%            toc
%     end
% end

% ** TEST of chunk-reading method
chunkSize = 5000;
numChunks = floor(nF/chunkSize);

for ch = 1:numChunks
    img = read(vr, [(ch-1)*chunkSize+1 ch*chunkSize]);
    avgIntensity((ch-1)*chunkSize+1:ch*chunkSize) = squeeze(mean(mean(img(ROI(2):ROI(4), ROI(1):ROI(3),:,:), 1),2));
    if ~isempty(datPath)
        fwrite(fid, reshape(img, size(img,1)*size(img,2), chunkSize), 'uint8');
    end
    fprintf(1, '%d / %d\n', ch*chunkSize, nF);
    toc
end
% last bit
img = read(vr, [ch*chunkSize+1 nF]);
avgIntensity(ch*chunkSize+1:nF) = squeeze(mean(mean(img, 1),2));
if ~isempty(datPath)
    fwrite(fid, reshape(img, size(img,1)*size(img,2), []), 'uint8');
    fclose(fid);
end
% ** TEST of readFrame method. Result is that it is slower
% f = 1;
% while hasFrame(vr)
%     img = readFrame(vr, 'native');
%     avgIntensity(f) = mean(img(:));
%     f = f+1;
%     if mod(f, 1000)==0
%            fprintf(1, '%d / %d\n', f, nF);
%            toc
%     end
% end

delete(vr)
clear vr

if makePlots
    subplot(121); imagesc(img(:,:,1,1));        title('current frame'); colormap gray
    subplot(122); plot(avgIntensity); title('avg. intensity vs. frame');
    drawnow;  %    pause(0.01);
end
if ~isempty(outputSuffix)
    save(fullfile(direc, [fname '_avgIntensity_' outputSuffix '.mat']), 'avgIntensity');
else
    save(fullfile(direc, [fname '_avgIntensity.mat']), 'avgIntensity');
end