

function [responseMoveInds, earlyMoveInds, allMoveInds] = findChoiceWorldMoveTimesDirect(...
    trialStarts, trialEnds, stimOn, beepOn, moveTimes, moveAmps, responseMadeLabel, responseMadeTimes)


responseMoveInds = zeros(1,length(trialStarts));
earlyMoveInds = nan(1,length(trialStarts));
allMoveInds = cell(1,length(trialStarts));



for t = 1:length(trialStarts)
    if responseMadeLabel(t) < 3
        thisMove = find(moveTimes(1,:)<responseMadeTimes(t) & moveTimes(2,:)>=responseMadeTimes(t));
        
        % check that it makes sense
        if isempty(thisMove)
            disp(['  warning: no move found for trial ' num2str(t)]);
        elseif ( moveAmps(thisMove)>0 && responseMadeLabel(t)==2 ) || ( moveAmps(thisMove)<0 && responseMadeLabel(t)==1 )
            disp(['  warning: move doesn''t match? trial number ' num2str(t)]);
            responseMoveInds(t) = thisMove;
        else
            responseMoveInds(t) = thisMove;
        end
    end
    
    earlyMove = find(moveTimes(1,:)>stimOn(t) & moveTimes(1,:)<beepOn(t),1);
    if ~isempty(earlyMove)
        earlyMoveInds(t) = earlyMove;
    end
    
    allMoves = find(moveTimes(1,:)>trialStarts(t) & moveTimes(1,:)<=trialEnds(t));
    if ~isempty(allMoves)
        allMoveInds{t} = allMoves;
    end
    
end    