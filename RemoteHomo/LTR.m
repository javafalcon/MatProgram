function LTR(trainFile, testFile, predictionsResult)
    javaaddpath('jforests.jar');
    %converting data sets to binary format
    cmd = ['java -jar jforests.jar --cmd=generate-bin --ranking --folder . --file ' trainFile ' --file  ' testFile];
    system(cmd,'-echo');
    %training a LambdaMART ensemble 
    [~,a,~] = fileparts(trainFile);
    [~,b,~] = fileparts(testFile);
    cmd = ['java  -Xms4000m -Xmx6000m -jar jforests.jar --cmd=train --ranking --config-file ranking.properties --train-file ' a '.bin --output-model ensemble.txt'];
    system(cmd, '-echo');
    %predicting
    cmd = ['java -jar jforests.jar --cmd=predict --ranking --model-file ensemble.txt --tree-type RegressionTree --test-file ' b '.bin --output-file ' predictionsResult];
    system(cmd, '-echo');
    
    
    