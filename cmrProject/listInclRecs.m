
function r = listInclRecs(varargin)
% return a struct of all recordings included in "the dataset"

if ~isempty(varargin)
    returnAll = true;
else
    % by default, return only "included" recordings
    returnAll = false; 
end

n = 0; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-14'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-15'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-16'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-17'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Cori'; r(n).thisDate = '2016-12-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Radnitz'; r(n).thisDate = '2017-01-13'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = []; 

n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-07'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-08'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-09'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-10'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-11'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Muller'; r(n).thisDate = '2017-01-12'; r(n).tlExpNum = 3; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 

n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-13'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-14'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-15'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-16'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-17'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Moniz'; r(n).thisDate = '2017-05-19'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 

n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-14'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-15'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-16'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-17'; r(n).tlExpNum = 2; r(n).cwExpNum = 4; r(n).passiveExpNum = 6; 
n = n+1; r(n).mouseName = 'Hench'; r(n).thisDate = '2017-06-18'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

n = n+1; r(n).mouseName = 'Theiler'; r(n).thisDate = '2017-10-11'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
% n = n+1; r(n).mouseName = 'Theiler'; r(n).thisDate = '2017-10-12'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

n = n+1; r(n).mouseName = 'Richards'; r(n).thisDate = '2017-10-29'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Richards'; r(n).thisDate = '2017-10-30'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Richards'; r(n).thisDate = '2017-10-31'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Richards'; r(n).thisDate = '2017-11-01'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Richards'; r(n).thisDate = '2017-11-02'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

n = n+1; r(n).mouseName = 'Forssmann'; r(n).thisDate = '2017-11-01'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Forssmann'; r(n).thisDate = '2017-11-02'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Forssmann'; r(n).thisDate = '2017-11-04'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Forssmann'; r(n).thisDate = '2017-11-05'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

n = n+1; r(n).mouseName = 'Lederberg'; r(n).thisDate = '2017-12-05'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Lederberg'; r(n).thisDate = '2017-12-06'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Lederberg'; r(n).thisDate = '2017-12-07'; r(n).tlExpNum = 2; r(n).cwExpNum = 3; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Lederberg'; r(n).thisDate = '2017-12-08'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Lederberg'; r(n).thisDate = '2017-12-09'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Lederberg'; r(n).thisDate = '2017-12-10'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Lederberg'; r(n).thisDate = '2017-12-11'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

n = n+1; r(n).mouseName = 'Tatum'; r(n).thisDate = '2017-12-06'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Tatum'; r(n).thisDate = '2017-12-07'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Tatum'; r(n).thisDate = '2017-12-08'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 
n = n+1; r(n).mouseName = 'Tatum'; r(n).thisDate = '2017-12-09'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 5; 
n = n+1; r(n).mouseName = 'Tatum'; r(n).thisDate = '2017-12-10'; r(n).tlExpNum = 1; r(n).cwExpNum = 2; r(n).passiveExpNum = 4; 

% inclusion critera
winCountMove = [0.075 0.4]; % can be left or right move only if move falls in this window
winNoMove = [-0.1 0.4];
minMoveCount = 12;

for n = 1:numel(r)
    mouseName = r(n).mouseName; thisDate = r(n).thisDate;
    
    root = getALFdir(mouseName, thisDate);
    
    if exist(fullfile(root, 'include.recording.npy'))
        r(n).include = readNPY(fullfile(root, 'include.recording.npy'));
    else
        fprintf(1, 'determining inclusion for %s, %s\n', mouseName, thisDate);
        tags = getEphysTags(mouseName, thisDate);

        [sp, cweA, cwtA, moveData, lickTimes] = ...
            alf.loadCWAlf(mouseName, thisDate, []);

        [moveTimeUse, firstMoveType, firstMoveTime, hasNoMoveInWin] = ...
            findMoveTimes(cweA, cwtA, moveData, winCountMove, winNoMove);
        hasLeftMove = firstMoveTime<winCountMove(2) & firstMoveTime>winCountMove(1) & firstMoveType==1;
        hasRightMove = firstMoveTime<winCountMove(2) & firstMoveTime>winCountMove(1) & firstMoveType==2;
    %     fprintf(1, '    left moves = %d; right moves = %d; no moves = %d\n', ...
    %         sum(hasLeftMove&cweA.inclTrials), ...
    %         sum(hasRightMove&cweA.inclTrials), ...
    %         sum(hasNoMoveInWin&cweA.inclTrials));
        if sum(hasLeftMove&cweA.inclTrials)>=minMoveCount && ...
                sum(hasRightMove&cweA.inclTrials)>=minMoveCount && ...
                sum(hasNoMoveInWin&cweA.inclTrials)
            %fprintf(1, '    INCLUDE\n');
            r(n).include = true;
        else
            r(n).include = false;
        end
        writeNPY(r(n).include, fullfile(root, 'include.recording.npy'));
    end
end

if ~returnAll
    % only the ones labeled for inclusion
    r = r([r.include]);
end

