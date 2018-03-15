%读入fasta格式文件，并把序列转换为20维氨基酸成分向量保存到指定的文件中
%  fmat--保存向量的文件.
%  fastas--cell(1,m)型变量,表示要读入的文件.
%Example:
%  fastas={'fileA_name';'fileB_name';'fileC_name'};
%  fmat='myvect.mat';
%  SaveData(fmat,fasta);
function SaveData( fmat,fastas,r)
    [Head, Sequence] = fastaread(fastas);
    len = length(Head);
    GPCR_Group = cell(1,len);
    for i = 1:len
        GPCR_Group{i} = CorrelationPseAAC(Sequence{i}, r, 0.05);
    end
    save(fmat,'GPCR_Group');
    
    %m = length( fastas);%有m个类别
    %Head = cell(1,m);
    %Aminoseq = cell(1,m);
    %LVector_Group = cell(1,m);
    %LGroup_Count = zeros(1,m);
    %for i = 1 : m
    %    [Head{i},Aminoseq{i}]=fastaread( fastas{i} );
    %    LGroup_Count(i)=length(Head{i});
    %end
    
    %for i = 1 : m
        %if i == 4
            %Sgn01_Group{i}{1}=To_02(Aminoseq{i});
            %TVector_Group{i}{1}=CorrelationPseAAC( Aminoseq{i}, 1, 0.05);
            %Group_Count(i)=1;
        %else
            %for j = 1 : LGroup_Count(i)
                %Sgn01_Group{i}{j} = To_02( Aminoseq{i}{j} );
                %AAVector_Group{i}{j}=AAVector( Aminoseq{i}{j} );
                %LVector_Group{i}{j} = CorrelationPseAAC( Aminoseq{i}{j}, 25, 0.05);
                %for k = 1:r
                %    PseAACVector_Group{k}{i}{j} = CorrelationPseAAC(Aminoseq{i}{j},1,0.05);
                %end
            %end
        %end
    %end
    %save( fmat,'LVector_Group','LGroup_Count');
    %save('test.mat','TVector_Group','Group_Count');
    %for i = 1:r
    %    Vector_Group = PseAACVector_Group{i};
    %    save( fmats{i},'Vector_Group', 'Group_Count');
    %end

