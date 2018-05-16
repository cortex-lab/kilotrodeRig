

function root = getRootDir(mouseName, thisDate)

roots = {'\\zserver.cortexlab.net\Data\Subjects', ...
    '\\zubjects.cortexlab.net\Subjects'};

switch mouseName
    case {'Cori', 'Muller', 'Radnitz', 'Hench', 'Moniz', 'Robbins', ...
            'Theiler', 'Richards', 'Forssmann'}
        root = fullfile(roots{1}, mouseName, thisDate);
    otherwise
        root = fullfile(roots{2}, mouseName, thisDate);
end