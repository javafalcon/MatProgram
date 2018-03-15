%����pseAACMatrix(fastaFile,option)���ļ��е�ÿ������������ת��Ϊα������ɷ�����
%fastaFile: �����������ļ���fasta��ʽ
%option: ����α������ɷ�ѡ�
%       -��Chou'��Chou������α������ɷֵķ���
%       -'GM1':��ɫģ��GM(1,1)����α������ɷֵķ���
%       -'GM2'����ɫģ��GM(2,1)����α������ɷֵķ���
%optionVal: ��Ӧ����α������ɷֵĲ���
%       -'Chou'��Ӧ��ֵ��lamda��ȡֵ��ÿ�������ʱ�ʾΪ20+lamdaά������
%       -'GM1'�� GM2��Ӧ��ֵ��ʾ���������б�����ţ���AACode������
%data�� ��������ֵ��L*M����L��ʾ�ļ��е��������е�������M��α������ɷֵĴ�С
%       ע�⣺���ص�α����������У�α������ɷֵ�Ȩֵδ���á�
function data = pseAACMatrix(fastaFile,option,optionVal)
[heads,seqs] = fastaread(fastaFile);
L = length(heads);

switch option
    case 'Chou'
        data = zeros(L,20+optionVal);
        for i = 1 : L
            seq = regexprep(seqs{i},'[?bBzZxXUu]','');
            %ǰ20���ǰ�����ɷ�
            data(i,1:20) = AAVector(seq);
            
            %������Chouα������ɷ�            
            for r = 1 : optionVal
                data(20+r) = CorrelationFactor(seq,r);
            end
        end
        
    case 'GMl'
        data = zeros(L,22);
        seq = regexprep(seqs{i},'[?bBzZxXUu]','');
        for i = 1: L
            %ǰ20���ǰ�����ɷ�
            data(i,1:20) = AAVecotr(seq);

            %�����ǻ�ɫģ�Ͳ�����α������ɷ�             
            numseq = aaseq2numseq(seq,optionVal);
            p = GMParam(numseq);
            data(i,21) = p(1);
            data(i,22) = p(2);
        end
        
    case 'GM2'
        data = zeros(L,23);
        seq = regexprep(seqs{i},'[?bBzZxXUu]','');
        for i = 1: L
            %ǰ20���ǰ�����ɷ�
            data(i,1:20) = AAVector(seq);

            %�����ǻ�ɫģ�Ͳ�����α������ɷ�             
            numseq = aaseq2numseq(seq,optionVal);
            p = GM21Param(numseq);
            data(i,21) = p(1);
            data(i,22) = p(2);
            data(i,23) = p(3);
        end
end