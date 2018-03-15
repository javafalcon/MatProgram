function [best_c,best_g,best_rate] = libsvm_grid(instance_matrix,label_vector, nr_fold)
% [best_c,best_g,best_rate] = libsvm_grid(instance_matrix,label_vector, nr_fold)


%nr_fold = 5;
if nargin < 3
    nr_fold = 5;
end
best_c = 0; best_g = 0;best_rate=0;
argv = '-s 0 -t 2 -c ';


%%
%loose grid
c_begin = -5; c_end = 15; c_step = 2;
g_begin = 3; g_end = -15; g_step = -2;
c_seq = rang_f(c_begin, c_end, c_step);
g_seq = rang_f(g_begin, g_end, g_step);
for c = c_seq
        for g = g_seq
            option = [argv num2str(2^c) ' -g ' num2str(2^g) ' -v ' num2str(nr_fold)] ;
            rate = svmtrain(label_vector, instance_matrix, option);
            if( best_rate < rate)
                best_c = c; best_g = g; best_rate = rate;
            end
        end
end 

%%
%fine grid
c_begin = best_c - 2; c_end = best_c + 2; c_step = 0.25;
g_begin = best_g + 2; g_end = best_g - 2; g_step = 0.25;
c_seq = rang_f(c_begin, c_end, c_step);
g_seq = rang_f(g_begin, g_end, g_step);
for c = c_seq
        for g = g_seq
            option = [argv num2str(2^c) ' -g ' num2str(2^g) ' -v ' num2str(nr_fold)] ;
            rate = svmtrain(label_vector, instance_matrix, option);
            if( best_rate < rate)
                best_c = 2^c; best_g = 2^g; best_rate = rate;
            end
        end
end 
%%

function seq = rang_f(begin_val, end_val, step)
    seq = [];
    while (true)
        if (step > 0 && begin_val > end_val)
            break;
        end
        if (step < 0 && begin_val < end_val)
            break;
        end
        seq = [seq, begin_val];
        begin_val = begin_val + step;
    end
end


end
