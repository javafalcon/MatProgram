package cocoa.examples;

import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;

import weka.classifiers.trees.J48;
import mulan.classifier.imbalance.COCOA;
import mulan.data.InvalidDataFormatException;
import mulan.data.MultiLabelInstances;
import mulan.evaluation.Evaluator;
import mulan.evaluation.MultipleEvaluation;
import mulan.evaluation.measure.AveragePrecision;
import mulan.evaluation.measure.MacroAUC;
import mulan.evaluation.measure.MacroFMeasure;
import mulan.evaluation.measure.Measure;
import mulan.evaluation.measure.RankingLoss;

public class cocoa_readme {
    public static void main(String[] args) throws InvalidDataFormatException, FileNotFoundException {

        //Loading the dataset...
        MultiLabelInstances dataset = new MultiLabelInstances("emotions.arff", "emotions.xml");
        //create the IO writer to record the experiment results.
        PrintWriter recordResutls;
        
        //the base classifier is J48 by weka.
        J48 j48 = new J48();
        //initialize the cocoa method using the base classifier j48 or any other classifiers, such as SMO, LR...
        COCOA cocoa = new COCOA(j48);
        //if you want to employ the binary imbalance learner, you can set this function true.
        cocoa.setUseBinaryBalanceLearner(true);
        
        //initialize a Evaluator (more information can be found in the introduction of MULAN)
        Evaluator eval = new Evaluator();
        MultipleEvaluation results;
        
        //this variable contains all measures you want to get. You can found more information in MULAN.
        ArrayList<Measure> allMeasures = new ArrayList<Measure>();
        int numLabels = dataset.getNumLabels();
        allMeasures.add(new MacroFMeasure(numLabels));	 
        allMeasures.add(new MacroAUC(numLabels));
        allMeasures.add(new RankingLoss());
        allMeasures.add(new AveragePrecision());
        
        int numFolds = 10;
        //training and testing by ten-fold cross validation.
        results = eval.crossValidate(cocoa, dataset, allMeasures, numFolds);
        recordResutls = new PrintWriter("COCOA_emotions_results.txt");
        recordResutls.print(results);
        recordResutls.close();
        
    }
}
