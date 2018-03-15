function acc = SubsetAcc( Outputs,test_target)
%Outputs: the predicted outputs of the classifier, the output of the ith instance for the jth class is stored in Outputs(j,i)
%test_target: the actual labels of the test instances, if the ith instance belong to the jth class, test_target(j,i)=1, otherwise test_target(j,i)~=1
    [num_class,num_instance]=size(Outputs);
    k = 0;
    for i = 1 : num_instance
        flag = 1;
		for j = 1 : num_class
			if Outputs(j,i) ~= test_target(j,i)
				flag = 0;
                break;
			end
		end
		if flag == 1
			k = k + 1;
		end
    end
    
    acc = k/num_instance;

end

