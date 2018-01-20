

function wf = galvoWaveform(pars, xPos, yPos, laserAmp, pulseDur, pulseInterval, pulseType)
% generate the series of analog signals that should be sent to the daq
%
% pars contains: 
% - Fs (1/s), sample rate of the output 
% - mmPerV, the number of mm that the galvo will travel for one V change
% - travelTime (s), how long to wait after moving to ensure the motor has made it
% - mWperV, how much power output you will get from laser per V command
% signal
%
% all inputs after pars can be vectors to make multiple consecutive steps.
% All must have at least one entry, and have the same length.
% - xPos, yPos (mm)
% - laserAmp (mW)
% - pulseInterval (s) is from the start of one pulse to the start of the next
% (ignoring duration of the pulse). For last pulse, it's time to the end of
% the stimulus
% - pulseType can be 1 (default) for square wave for 2 for raised cosine
% 
% output wf is 3xN where N is the number of samples to be delivered

if isempty(pars); pars.dummy = []; end
Fs = pick(pars, 'Fs', 'def', 20e3);
mmPerV = pick(pars, 'mmPerV', 'def', 2);
travelTime = pick(pars, 'travelTime', 'def', 0.002);
mWperV = pick(pars, 'mWperV', 'def', 1);

np = numel(pulseInterval);

if numel(pulseType)==1; pulseType = repmat(pulseType, np, 1); end

totalDur = sum(pulseInterval)+travelTime*(np-1);

wf = zeros(3, ceil(totalDur*Fs));

for p = 1:np
    positionStart = 1+round(sum(pulseInterval(1:p-1))*Fs);% in samples
    pulseStart = positionStart+ceil(travelTime*Fs); 
    pulseEnd = pulseStart+round(pulseDur(p)*Fs);
    positionEnd = positionStart+round(pulseInterval(p)*Fs);
    
    wf(1, positionStart:positionEnd) = xPos(p)/mmPerV;
    wf(2, positionStart:positionEnd) = yPos(p)/mmPerV;
    
    ns = numel(pulseStart:pulseEnd);
    pulseSamps = zeros(1, ns);
    amp = laserAmp(p)/mWperV;
    if pulseType(p)==1
        % step
        pulseSamps = amp+pulseSamps;
        
    elseif pulseType(p)==2
        % raised cosine
        phi = linspace(0, 2*pi, ns);
        pulseSamps = amp*(1-cos(phi))/2;
        
    end
    
    wf(3, pulseStart:pulseEnd) = pulseSamps;
end