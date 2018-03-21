
function predictProteinRemoteHomology(queryProteinFile)
    load 7329sequencesGrey21PSSM.mat %psepssm:7329*80
    load 7329sequences_pssm_GLCMFeature.mat %glcm :7329*4
    load 7329sequences_blastscore.mat %bitscore:7329*7328
    load 7329sequencesFamily.mat %familyId: 1*7329; seqId: 1*7329
    % load 7329sequences_hmmscore.mat

    x=[0.3 0.02 0.28 0.4];
    P = blastpssm(queryProteinFile,'swissprot');
%     cmd = 'makeblastdb -in  7329seqs.fasta -dbtype prot -parse_seqids -out 7329seqsdb' ;
%     system(cmd,'-echo');
    [testheads,~]= fastaread(queryProteinFile);
    [trainheads,~] = fastaread('7329seqs.fasta');
    blastprotspair('7329seqs.fasta','7329seqsdb',queryProteinFile,pairfile);
    [bitscore,~] = pairVals(pairfile, testheads, trainheads);
    
    if iscell(heads)
  
    


  
        trainX_psepssm = psepssm;
        trainX_glcm = glcm;
        trainY = familyId;

        testX_psepssm = psepssm(i,:);
        testX_glcm = glcm(i,[1 3]);
        testY = familyId{i};

        label_Y = strcmp(trainY,testY);
        %     r = GreyIncidenceDegree([testX_psepssm testX_glcm],[trainX_psepssm trainX_glcm]);
        r = GreyIncidenceDegree(testX_psepssm,trainX_psepssm);
        d = GreyIncidenceDegree(testX_glcm, trainX_glcm);
        b = mapminmax(bitscore(i,:),0,1);
        h = mapminmax(hmmscore(i,ind),0,1);
        dis=x(1)*r + x(2)*b + x(3)*d + x(4)*h;

    end
   
