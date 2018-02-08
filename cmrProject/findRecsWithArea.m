

function r = findRecsWithArea(acronym)
% function r = findRecsWithArea(acronym)
% return a struct with details about the recordings that contain a specific
% brain region

rAll = listInclRecs();
r = [];

st = loadStructureTree('structure_tree_safe_2017.csv');
% determine which acronyms we're looking for: this area and any children
thisID = st(strcmp(st.acronym, acronym),:).id;
thisAndChildren = st.acronym(...
    arrayfun(@(x)contains(st.structure_id_path{x}, sprintf('/%d/', thisID)), ...
    1:size(st,1)));

for q = 1:numel(rAll)
    
    mouseName = rAll(q).mouseName; thisDate = rAll(q).thisDate;
    
    rootE = dat.expPath(mouseName, thisDate, 1, 'main', 'master');
    root = fileparts(rootE);
    alfDir = fullfile(root, 'alf');
    
    tags = getEphysTags(mouseName, thisDate);
    
    for t = 1:numel(tags)
        
        bordersFile = fullfile(alfDir, tags{t}, ['borders_' tags{t} '.tsv']);
        if exist(bordersFile, 'file')
            borders = readtable(bordersFile ,'Delimiter','\t', 'FileType', 'text');
        end
        
        if any(ismember(borders.acronym, thisAndChildren))
            foundIdx = find(ismember(borders.acronym, thisAndChildren));
            for f = 1:numel(foundIdx)
                fprintf(1, 'found %s in %s/%s/%s\n', borders.acronym{foundIdx(f)}, ...
                    mouseName, thisDate, tags{t});
            end
            
            if isempty(r)
                r = rAll(q); r.tag = tags{t};
            else
                tmp = rAll(q); tmp.tag = tags{t};
                r(end+1) = tmp;
            end
        end
    end
    
end