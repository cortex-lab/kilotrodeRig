

function wf = galvoWaveform(pars, xPos, yPos, laserAmp, pulseDur, pulseInterval, pulseType)
% generate the series of analog signals that should be sent to the daq
%
% pars contains: 
% - Fs (1/s), sample rate of the output 
% - mmPerVLR, the number of mm that the galvo will travel for one V change
% - mmPerVAP, the number of mm that the galvo will travel for one V change
% - travelTime (s), how long to wait after moving to ensure the motor has made it
% - mWperV, how much power output you will get from laser per V command
% signal
% - laserZeroV, an offset voltage to add to the laser signal
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
mmPerVLR = pick(pars, 'mmPerVLR', 'def', 2);
mmPerVAP = pick(pars, 'mmPerVAP', 'def', 2);
travelTime = pick(pars, 'travelTime', 'def', 0.002);
mWperV = pick(pars, 'mWperV', 'def', 1);
laserZeroV = pick(pars, 'laserZeroV', 'def', 0);

np = numel(pulseInterval);

if numel(pulseType)==1; pulseType = repmat(pulseType, np, 1); end

totalDur = sum(pulseInterval)+travelTime*(np-1);

wf = zeros(3, ceil(totalDur*Fs));
lastPulseEnd = 1; lastPositionEnd = 0;
for p = 1:np
    
    % old method: start the pulse right after the new position
%     positionStart = 1+round(sum(pulseInterval(1:p-1))*Fs);% in samples
%     pulseStart = positionStart+ceil(travelTime*Fs); 
%     pulseEnd = pulseStart+round(pulseDur(p)*Fs);
%     positionEnd = positionStart+round(pulseInterval(p)*Fs);

    % new method: start the new position some time in between the old pulse
    % and the new pulse
    
    pulseStart = 1+round(sum(pulseInterval(1:p-1))*Fs)+ceil(travelTime*Fs); % in samples
    pulseEnd = pulseStart+round(pulseDur(p)*Fs);    
    
    % don't set the position until you know the time of the next pulse
    if p==1
        positionStart = 1; 
        positionEnd = pulseEnd;
        wf(1, positionStart:positionEnd) = xPos(p)/mmPerVLR;
        wf(2, positionStart:positionEnd) = yPos(p)/mmPerVAP;
    else
        positionStart = lastPositionEnd+1;
        positionEnd = randi(max(1,pulseStart-lastPulseEnd-ceil(travelTime*Fs)))+lastPulseEnd;
        wf(1, positionStart:positionEnd) = xPos(p-1)/mmPerVLR;
        wf(2, positionStart:positionEnd) = yPos(p-1)/mmPerVAP;
    end
            
    lastPositionEnd = positionEnd;
    
    
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
    
    wf(3, pulseStart:pulseEnd) = pulseSamps+laserZeroV;
    lastPulseEnd = pulseEnd;
end

% last position
wf(1, positionEnd+1:end-1) = xPos(p)/mmPerVLR;
wf(2, positionEnd+1:end-1) = yPos(p)/mmPerVAP;