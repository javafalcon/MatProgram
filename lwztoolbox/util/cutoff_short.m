%Author:Lin Wei-Zhong
%Date:2008-4-1
%cutoff_short(fastafile,len)
%Function description: 
%    cut off the sequence whose length less than the
%    length given by the seconde parameter.
%Parameter descriptiong:
%    sfile--the file to be read
%    dfile--the file to be written
%    len--the threshold
function cutoff_short(sfile,dfile,len)
[h,s]=fastaread(sfile);
n=1;
for i=1:size(s,2)
    if( length(s{i})>=len)
        seq{n}=s{i};
        head{n}=h{i};
        n=n+1;
    end
end
fastawrite(dfile,head,seq);