
function [cwEvTimes, cwEv] = basicCWevents(block)

if isfield(block, 'trial')
    % Choiceworld version
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

%     cwEvTimes = structfun(@(x)x', t, 'uni', false);
%     cwEv = structfun(@(x)x', e, 'uni', false);
    
else
    % Signals version
    
    evs = block.events;
    nTr = numel(evs.endTrialTimes);
    
    offset = -evs.expStartTimes+block.experimentStartedTime;
    
    t.stimOn = evs.stimulusOnTimes(1:nTr)+offset;

    e.contrastLeft = evs.contrastLeftValues(1:nTr);
    e.contrastRight = evs.contrastRightValues(1:nTr);
    e.choice = evs.responseValues(1:nTr);
    e.choice(e.choice==1) = 2;
    e.choice(e.choice==-1) = 1;
    e.choice(e.choice==0) = 3;

    t.goCue = evs.interactiveOnTimes(1:nTr)+offset;

    t.responseTime = evs.responseTimes(1:nTr)+offset;

    e.reactionTime = t.responseTime-t.goCue;
    e.repNum = evs.repeatNumValues(1:nTr);
    e.feedback = double(evs.feedbackValues(1:nTr));
    e.feedback(e.feedback==0) = -1;

    t.trialStarts = evs.newTrialTimes(1:nTr)+offset;

    t.trialEnds = evs.endTrialTimes(1:nTr)+offset;
end

cwEvTimes = structfun(@(x)x', t, 'uni', false);
cwEv = structfun(@(x)x', e, 'uni', false);
    