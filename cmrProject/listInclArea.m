
function [acr, descendents] = listInclArea()
% final list of acronyms of included brain regions

acr = {'VISp', 'VISa','VISl','VISpm','VISam', 'VISrl' ... % visual cortex
    'MOs', 'ACA', 'PL', 'ORB','ILA','MOp','RSP','SSp',... % all other cortex
    'CA1', 'CA3', 'DG', 'POST', 'SUB',... % hippocampal
    'VPL', 'LD', 'LGd','LP','MD','MG','PO', 'POL', 'VPM','ZI','RT',... % thalamic
    'SCs', 'SCm', 'MRN', 'APN','PAG',... % midbrain
    'CP', 'ACB', 'GPe','LS','SNr',... % basal ganglia
    'BLA', 'OLF'}; % other

if nargout>1
    % asked also for descendents of each
    mfPath = mfilename('fullpath');
    dpath = fullfile(fileparts(mfPath), 'acrDesc.mat');
    if exist(dpath, 'file')
        q = load(dpath);
        acr = q.acr;
        descendents = q.descendents;
    else
        % compute anew
        st = loadStructureTree('structure_tree_safe_2017.csv');

        thisID = zeros(size(acr));
        descendents = {};

        for a = 1:numel(acr)
            % determine which acronyms we're looking for: this area and any children
            thisID(a) = st(strcmp(st.acronym, acr{a}),:).id;
            descendents{a} = st.acronym(...
                arrayfun(@(x)contains(st.structure_id_path{x}, sprintf('/%d/', thisID(a))), ...
                1:size(st,1)));
        end
    end
end

return;

%% determined with:
t = listAllAreas('all');
rn = t.Properties.RowNames;
for q = 1:size(t,1)
    if sum(t{q,:}>0)>1
        fprintf(1, '%s: %d\n', rn{q}, sum(t{q,:}>0));
    end
end

% need one more for: RN, SI, VAL, MS
% LH excluded because the two recordings contain only 10 and 18 units, i.e.
% not sufficient numbers
