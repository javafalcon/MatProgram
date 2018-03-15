function cdhit( cdhitpath, path, filenames, varargin )
% Call the Soft CD-HIT command line to cut off these sequence with
% high similarity.
% 
% Input:
%   cdhitpath   A string, pointing the path of the file cd-hit.exe.
%   path:       A string, the path of file.
%   filenames:  A string cell, the sequence file need to be cut off.
%   varargin:   specifies optional argument name/value pairs. Their meaning
%               can be refered CD-HIT soft.
%       Name      Value
%       c         A positive real number between 0 and 1, point the
%                 cutting threshold 
%       n         A positive integer
%   Example:
%       cdhit('c:\lwz\cd-hit\cd-hit','data\homo', filenames, 'c', 0.6, 'n', 4);

    pnames = {'c','n'};
    dflts = {0.4,2};
    [c,n] = internal.stats.parseArgs( pnames, dflts, varargin{:});
    
    if iscell(filenames)
        for i = 1 : length(filenames)
            inputfile = fullfile(path,filenames{i});
            outputfile = fullfile(path,strcat('nr',int2str(c*100),'_',filenames{i}));
            Cmdstr = {cdhitpath, ' -i ', inputfile, ' -o ', outputfile, ' -c ', num2str(c), ' -n ', int2str(n)};
            cmd = strjoin(Cmdstr);
            system(cmd);
        end
    else
        inputfile = fullfile(path, filenames);
        outputfile = fullfile(path,strcat('nr',int2str(c*100),'_',filenames));
        Cmdstr = {cdhitpath, ' -i ', inputfile, ' -o ', outputfile, ' -c ', num2str(c), ' -n ', int2str(n)};
        cmd = strjoin(Cmdstr);
        system(cmd);
    end
end

