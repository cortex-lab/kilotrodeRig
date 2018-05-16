
function [cwEvTimes, cwEv] = basicCWevents(block)

tr = block.trial; tr = tr(1:block.numCompletedTrials);
cond = [tr.condition];

t.stimOn = [tr.stimulusCueStartedTime];

e.vcc = [cond.visCueContrast];
e.contrastLeft = e.vcc(1,:);
e.contrastRight = e.vcc(2,:);
e.choice = [tr.responseMadeID];

t.goCue = [tr.interactiveStartedTime];

t.responseTime = [tr.responseMadeTime];

e.reactionTime = [tr.responseMadeTime]-t.goCue;
e.repNum = [cond.repeatNum];
e.feedback = [tr.feedbackType]; 

t.trialStarts = [tr.trialStartedTime];

t.trialEnds = [tr.trialEndedTime];
 
% [contrastCondDefs, ia, contrastConds] = unique(e.vcc', 'rows');
% e.contrastCondDefs = contrastCondDefs;
% e.contrastConds = contrastConds;

cwEvTimes = structfun(@(x)x', t, 'uni', false);
cwEv = structfun(@(x)x', e, 'uni', false);