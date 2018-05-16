

function wf = galvoWaveformOneStep(pars, laserDur, laserFreq, laserAmp, laserMode, galvoCoord)
% generate the series of analog signals that should be sent to the daq
%
% pars contains: 
% - Fs (1/s), sample rate of the output 
% - mmPerVLR, AP, the number of mm that the galvo will travel for one V change
% - travelTime (s), how long to wait after moving to ensure the motor has made it
% - mWperV, how much power output you will get from laser per V command
% signal
%
% 
% 
% output wf is 3xN where N is the number of samples to be delivered

if isempty(pars); pars.dummy = []; end
Fs = pick(pars, 'Fs', 'def', 20e3);
mmPerVLR = pick(pars, 'mmPerVLR', 'def', 2);
mmPerVAP = pick(pars, 'mmPerVAP', 'def', 2);
travelTime = pick(pars, 'travelTime', 'def', 0.002);
mWperV = pick(pars, 'mWperV', 'def', 1);

totalSamps = Fs*laserDur; 
%t = (0:totalSamps-1)/Fs;


% laser waveform, first build one cycle, then concatenate
tlas = linspace(0, 1/laserFreq - 1/Fs, Fs/laserFreq);
samples = 1/2*(-cos(2*pi*laserFreq*tlas) + 1);


if laserMode==0    
    % just a step but ramping up and down
    nSamp = totalSamps-numel(samples);
    m = round(numel(samples)/2);
    samples = [samples(1:m) ones(1,nSamp) samples(m+1:end)];
else
    % cycling the sine wave
    nRep = ceil(totalSamps/samples);
    samples = repmat(samples, 1, nRep);
end

laserWave = laserAmp/mWperV.*samples';
laserWave(end) = 0;

totalSamps = numel(laserWave); % redefine because it can be slightly longer than the requested duration to make even number of cycles

% galvo waveform, just move to the position right away
galvoAmpAP = galvoCoord(1)/mmPerVAP;
galvoAmpLR = galvoCoord(2)/mmPerVLR;

ngw = ceil(travelTime*Fs/2)*2;
galvoAP = [zeros(ngw/2,1) galvoAmpAP*ones(totalSamps-ngw,1) zeros(ngw/2,1)];
galvoLR = [zeros(ngw/2,1) galvoAmpLR*ones(totalSamps-ngw,1) zeros(ngw/2,1)];

gw = gausswin(ngw);
gw = gw./sum(gw);
galvoAP = conv(galvoAP, gw, 'same');
galvoLR = conv(galvoLR, gw, 'same');

% output
wf = [laserWave galvoLR galvoAP];