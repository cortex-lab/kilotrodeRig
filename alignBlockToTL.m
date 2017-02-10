

function [corrFun, b] = alignBlockToTL(block, Timeline)
% function [corrFun, b] = alignBlockToTL(block, Timeline)
% work out a correction to convert block times to Timeline times. The most
% straightforward way to do this for behavioral experiments in kilotrode
% rig is with reward onsets, though these will 

tt = Timeline.rawDAQTimestamps;
rew = Timeline.rawDAQData(:, strcmp({Timeline.hw.inputs.name}, 'rewardEcho'));
[~, rewardOnsets] = schmittTimes(tt,rew, [2 3]);

blockRewTimes = block.rewardDeliveryTimes(block.rewardDeliveredSizes(:,1)>0);
[corrFun, b] = makeCorrection(rewardOnsets, blockRewTimes, true);