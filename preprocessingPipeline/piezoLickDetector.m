

function [lickTimes, lickSigC, pks] = piezoLickDetector(times, sig, Fs, varargin)

% thresh = how tall does a peak in the filtered signal need to be. Should have a
% good way to determine this automatically but I don't yet...
thresh = 0.03; 
if ~isempty(varargin)
    thresh = varargin{1};
end


smSize = 0.01;
lickSeparation = 0.05;

lickSigC = conv(abs(sig), myGaussWin(smSize, Fs), 'same');
lickSigCdownsamp = lickSigC(1:5:end); ttdown = times(1:5:end); % just for speed, there's no reason not to
[pks,lickTimes] = findpeaks(lickSigCdownsamp, ttdown, 'MinPeakDistance', lickSeparation, 'MinPeakProminence', thresh);
