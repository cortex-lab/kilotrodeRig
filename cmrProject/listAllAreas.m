

function areasTable = listAllAreas(varargin)
% function r = listAllAreas()
% return a table with all the areas included, broken down by subject

r = listInclRecs();

if isempty(varargin)
    % only the included areas
    ar = listInclArea(); % all areas we want to query
else
    % first collect all the area names included in any recording
    
    ar = {};
    
    for q = 1:numel(r)
        
        mouseName = r(q).mouseName; thisDate = r(q).thisDate;
        alfDir = getALFdir(mouseName, thisDate);
        tags = getEphysTags(mouseName, thisDate);
        
        for t = 1:numel(tags)
            
            bordersFile = fullfile(alfDir, tags{t}, ['borders_' tags{t} '.tsv']);
            if exist(bordersFile, 'file')
                borders = readtable(bordersFile ,'Delimiter','\t', 'FileType', 'text');
                acr = borders.acronym;
                for x = 1:numel(acr)
                    if ~ismember(acr{x}, ar)
                        ar{end+1} = acr{x};
                    end
                end
            end
        end
    end
end

ar = sort(ar); % alphabetical

mNames = unique({r.mouseName});

areasTable = table('Size', [numel(ar) numel(mNames)], 'VariableTypes', repmat({'double'}, 1, numel(mNames)),'VariableNames', mNames, 'RowNames', ar);

st = loadStructureTree('structure_tree_safe_2017.csv');


thisID = zeros(size(ar));
thisAndChildren = {};

for a = 1:numel(ar)
    % determine which acronyms we're looking for: this area and any children
    thisID(a) = st(strcmp(st.acronym, ar{a}),:).id;
    thisAndChildren{a} = st.acronym(...
        arrayfun(@(x)contains(st.structure_id_path{x}, sprintf('/%d/', thisID(a))), ...
        1:size(st,1)));
end


for q = 1:numel(r)
    
    mouseName = r(q).mouseName; thisDate = r(q).thisDate;
    alfDir = getALFdir(mouseName, thisDate);
    tags = getEphysTags(mouseName, thisDate);
    
    for t = 1:numel(tags)
        
        bordersFile = fullfile(alfDir, tags{t}, ['borders_' tags{t} '.tsv']);
        if exist(bordersFile, 'file')
            borders = readtable(bordersFile ,'Delimiter','\t', 'FileType', 'text');
            
            for a = 1:numel(ar)
                if any(ismember(borders.acronym, thisAndChildren{a}))
               
                    areasTable{ar{a}, mouseName} = areasTable{ar{a}, mouseName}+1;
                    
                end
            end
        end
    end
    
end