%vec = PseAAVector(w,AAVector,PseVector)
%�󵰰������е�α�����ɷֱ�ʾ����
% AAVector--������ɷ֣���cell(1,type)�ͱ�����type��ʾ��������
% PseVector--α������ɷ֣���cell(1,dim)�ͱ�����dim��ʾα������ɷֵĸ���
% w--α�������Ӧ��Ȩ�أ�(1,dim)��������dim��ʾα������ɷֵĸ�����

function vec = PseAAVector(w,AAVector,PseVector)
    type = size(AAVector,2);
    vec = cell(1,type);
    dim = length(PseVector{1}{1});
    for i=1:type
        for j = 1:size(AAVector{i},2) 
            vec{i}{j} = zeros(20+dim,1);
            for k = 1:20
                vec{i}{j}(k) = AAVector{i}{j}(k);
            end
            for k = 21:20+dim
                vec{i}{j}(k) = PseVector{i}{j}(k-20)*w(k-20);
            end
            
            s = sum(vec{i}{j});
            vec{i}{j} = vec{i}{j}/s;
        end
    end
    