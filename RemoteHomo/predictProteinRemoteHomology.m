
function families = predictProteinRemoteHomology(queryProteinFile)
    load 7329sequencesGrey21PSSM.mat %psepssm:7329*80
    load 7329sequences_pssm_GLCMFeature.mat %glcm :7329*4
    load 7329sequencesFamily.mat %familyId: 1*7329; seqId: 1*7329

    x=[0.3 0.02 0.28 0.4];
    %p = blastpssm(queryProteinFile,'swissprot');
    
    [queryheads,~]= fastaread(queryProteinFile);
    [trainheads,~] = fastaread('7329seqs.fasta');
    
    qlen = length(queryheads);
    tlen = length(trainheads);
    
    for i = 1 : qlen
        temp = split(queryheads{i});
        queryheads{i} = temp(1);
    end
    for i = 1 : tlen
        temp = split(trainheads{i});
        trainheads{i} = temp(1);
    end
    
    families = cell(1,qlen);
    % psi-blast bit score
    cmd = ['psiblast -db 7329seqsdb -query ' queryProteinFile ' -out blastpairfile -outfmt 6'];
    system(cmd, '-echo')
    [bitscore,~] = pairVals('blastpairfile', queryheads, trainheads);
    
    % hmmer score
    cmd = ['jackhmmer  --tblout hmmerscoreout.txt ' queryProteinFile ' 7329seqs.fasta'];
    system(cmd, '-echo');
    hmmscore = ones(qlen,tlen);
    fid = fopen('hmmerscoreout.txt','r');
    tline = fgetl(fid);
    while (ischar(tline) && ~isempty(tline))
        if( startsWith(tline, '#'))
            tline = fgetl(fid);
            continue;
        else
            A = split(tline);
            targetProtein = A(1);
            queryProtein = A(3);
            i = findStringInCell(queryheads, queryProtein);
            j = findStringInCell(trainheads, targetProtein);
            hmmscore(i,j) = str2double(A(6));
            %disp([queryProtein, targetProtein, num2str(hmmscore(i,j))]);
            tline = fgetl(fid);
        end
    end
    fclose(fid);
    
    % get pssm of query proteins
%     p=blastpssm(queryProteinFile,'swissprot');
    % glcm
    queryGlcm = getPSSM_GLCM(p);
    % grey(2,1) PSSM
    queryPsepssm=greyPsePssm(p,2);
    
    r = GreyIncidenceDegree(queryPsepssm,psepssm);
    d = GreyIncidenceDegree(queryGlcm, X);
    b = mapminmax(bitscore(i,:),0,1);
    h = mapminmax(hmmscore(i,ind),0,1);
    dis=x(1)*r + x(2)*b + x(3)*d + x(4)*h;
    [~,I] = sort(dis,'descend');
    families = familyId(I);
   
   
