

function galvoCalibration(rig, type)
% function galvoCalibration(rig, type)
%
% Display test patterns for spatial calibration of the galvo position

daqCon = rig.daqController;
s = daqCon.DaqSession;
sampleRate = s.Rate;

if type==1
    % hop around the whole brain pattern
    allPos = expandedBrainCoords(); % from github/cortex-lab/kilotrodeRig/
    positionX = allPos(1,:)';
    positionY = allPos(2,:)';
    
    % left hemisphere only, for testing
%     positionY = positionY(positionX<0);
%     positionX = positionX(positionX<0);
    
    np = numel(positionX);
    
    laserAmp = 0; pulseDur = 0.003; pulseInterval = 0.005; laserPulseType = 1;
    pulseDur = repmat(pulseDur, np, 1); pulseInterval = repmat(pulseInterval, np, 1);
    laserAmp = repmat(laserAmp, np, 1); laserPulseType = repmat(laserPulseType, np, 1);
    
    pars.Fs = s.Rate;
    pars.mmPerVLR = 1/daqCon.SignalGenerators(strcmp(daqCon.ChannelNames, 'galvoX')).Scale;
    pars.mmPerVAP = 1/daqCon.SignalGenerators(strcmp(daqCon.ChannelNames, 'galvoY')).Scale;
    pars.travelTime = 0.001;
    pars.mWperV = 0.001;
    wf = galvoWaveform(pars, positionX, positionY, laserAmp, pulseDur, pulseInterval, laserPulseType);
    
    wf = wf; % hardcoded offset to skip the non-responsive zone of the laser
    
    allWF = zeros(size(wf,2), sum(daqCon.AnalogueChannelsIdx));
    allWF(:,strcmp(daqCon.ChannelNames, 'galvoX')) = wf(1,:);
    allWF(:,strcmp(daqCon.ChannelNames, 'galvoY')) = wf(2,:);
    allWF(:,strcmp(daqCon.ChannelNames, 'laserShutter')) = wf(3,:)+0.12;
    
    nRep = 10;
    speedScale = 3;
    
    allWF = repmat(allWF, nRep, 1);
    
    s.queueOutputData(allWF(1:speedScale:end,:));
    s.startBackground;
    
elseif type==2
    
    % hop back and forth between [0, 0] and [0, -4]
    positionX = [0 0]';
    positionY = [0 -4]';
    np = numel(positionX);
    
    laserAmp = 0; pulseDur = 0.01; pulseInterval = 0.03; laserPulseType = 1;
    pulseDur = repmat(pulseDur, np, 1); pulseInterval = repmat(pulseInterval, np, 1);
    laserAmp = repmat(laserAmp, np, 1); laserPulseType = repmat(laserPulseType, np, 1);
    
    pars.Fs = s.Rate;
    pars.mmPerVLR = 1/daqCon.SignalGenerators(strcmp(daqCon.ChannelNames, 'galvoX')).Scale;
    pars.mmPerVAP = 1/daqCon.SignalGenerators(strcmp(daqCon.ChannelNames, 'galvoY')).Scale;
    pars.travelTime = 0.002;
    pars.mWperV = 0.001;
    wf = galvoWaveform(pars, positionX, positionY, laserAmp, pulseDur, pulseInterval, laserPulseType);
    
    wf = wf; % hardcoded offset to skip the non-responsive zone of the laser
    
    allWF = zeros(size(wf,2), sum(daqCon.AnalogueChannelsIdx));
    allWF(:,strcmp(daqCon.ChannelNames, 'galvoX')) = wf(1,:);
    allWF(:,strcmp(daqCon.ChannelNames, 'galvoY')) = wf(2,:);
    allWF(:,strcmp(daqCon.ChannelNames, 'laserShutter')) = wf(3,:)+0.12;
    
    nRep = 10;
    
    allWF = repmat(allWF, nRep, 1);
    
    s.queueOutputData(allWF);
    s.startBackground;
    
else
    fprintf(1, 'unrecognized galvo calibration pattern\n');
end
