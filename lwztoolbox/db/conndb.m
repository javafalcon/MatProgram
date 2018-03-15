function conn = conndb( varargin )
% conndb: connect database 
% Input:
%   specifics optional name/value
%   name        value
%   jdbcpath    the path of jdbc. Default is mysql jdbc connector.
%   dbname      the name of database
%   username    the username of database
%   pwd         the password of database
%   Vendor      the name of database. Default is MySQL
%   Servername  the name of database server. Default is localhost
% Output:
%   conn    the connection to database

pnames={'jdbcpath','dbname','username','pwd','Vendor','Servername'};
dflts={'C:\Program Files (x86)\MySQL\Connector.J 5.1\mysql-connector-java-5.1.35-bin.jar',...
    'go_09','root','123456','MySQL','localhost'};
[jdbcpath,dbname,usr,pwd,vendor,sname]=internal.stats.parseArgs(pnames,dflts,varargin{:});

javaaddpath(jdbcpath);
conn = database(dbname,usr,pwd,'Vendor',vendor,'Server',sname);

end

