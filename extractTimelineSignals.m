

function [beeps, whiteNoise, valveClicks, licks] = extractTimelineSignals(Timeline)
%
%
% pull out some relevant signals from a kilotrode rig's Timeline file,
% making some assumptions about what these signals look like


aud = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'audioMonitor'));
tt = Timeline.rawDAQTimestamps;
tlFs = Timeline.hw.daqSampleRate;

smAud = conv(aud.^2, gausswin(7)./sum(gausswin(7)), 'same');

[~, beeps, beepsOff] = schmittTimes(tt,smAud, [0.02 0.04]);

% to detect white noise, first remove samples corresponding to beeps. 
startSamps = round(beeps*tlFs); endSamps = round(beepsOff*tlFs);
for bb = 1:length(startSamps)
    aud(startSamps(bb)-8:endSamps(bb)+8) = 0;
end
smAud = conv(aud.^2, gausswin(20)./sum(gausswin(20)), 'same');

[~, whiteNoise] = schmittTimes(tt, smAud, [0.1e-3 1e-3]);

rew = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'rewardEcho'));
[~, valveClicks] = schmittTimes(tt,rew, [2 3]);

% detect licks here
licks = [];

% wheel movements takes just a little time to do, so skip it if not
% requested
if nargout>4
end
