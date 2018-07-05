

function [areasTable, pairList] = listAreaPairs
% function r = listAreaPairs()
% return a table the number of joint recordings for each pair of areas,
% as well as a struct defining them

r = listInclRecs();

ar = listInclArea(); % all areas we want to query

ar = sort(ar); % alphabetical

areasTable = table('Size', [numel(ar) numel(ar)], ...
    'VariableTypes', repmat({'double'}, 1, numel(ar)),...
    'VariableNames', ar, 'RowNames', ar);

pairList = struct();

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
    
    thisSessionAreas = {}; thisSessionTags = {};
    
    for t = 1:numel(tags)
        
        bordersFile = fullfile(alfDir, tags{t}, ['borders_' tags{t} '.tsv']);
        if exist(bordersFile, 'file')
            borders = readtable(bordersFile ,'Delimiter','\t', 'FileType', 'text');
            
            acr = borders.acronym;
            for a = 1:numel(acr)
                
                % determine which if any area this one belongs to
                parent = cellfun(@(x)ismember(acr{a},x), thisAndChildren);
                if any(parent)
                    thisA = ar{parent};
                
                    thisSessionAreas{end+1} = thisA;
                    thisSessionTags{end+1} = tags{t};
                end
            end
        end
    end
    
    [theseA,ii] = sort(thisSessionAreas);
    thisSessionTags = thisSessionTags(ii);
    
    for a1 = 1:numel(theseA)
        for a2 = a1+1:numel(theseA)
            pairList(end+1).mouseName = mouseName;
            pairList(end).thisDate = thisDate;
            pairList(end).tag1 = thisSessionTags{a1};
            pairList(end).tag2 = thisSessionTags{a2};
            pairList(end).area1 = theseA{a1};
            pairList(end).area2 = theseA{a2};

            areasTable{theseA{a1}, theseA{a2}} = areasTable{theseA{a1}, theseA{a2}}+1;
        end
    end
    
end