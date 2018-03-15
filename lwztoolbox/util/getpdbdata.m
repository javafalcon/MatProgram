function getpdbdata(openFileName,saveFileName)
%GETPDBDATA 读取蛋白质结构数据库PDB中的蛋白质序列
% openFileName 写有PDB库中蛋白质的ID号的文件，每个ID1行
% saveFileName 保存对应的蛋白质的序列的mat格式文件
dnabp=textread(openFileName,'%s','whitespace','\b ');

len1 = length(dnabp);
seq = cell(1,len1);

for i = 1 : len1
    i
    x = dnabp{i};
    if x(5) == '0'
        pseq = getpdb(x(1:4),'SequenceOnly',true);
        if iscell(pseq)
            seq{i} = pseq{1};
        else
            seq{i} = pseq;
        end
    else
        pid=x(1:4);
        chainid = x(5);
        pdbstruct = getpdb(pid);
        pseq = pdbstruct.Sequence;
        for j = 1 : length(pseq)
            if pseq(j).ChainID == chainid
                seq{i} = pseq(j).Sequence;
                break;
            end
        end
    end
end
save(saveFileName,'seq');
