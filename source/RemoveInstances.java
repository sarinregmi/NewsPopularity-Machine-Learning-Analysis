import weka.core.*;
  import weka.filters.Filter;
  import weka.filters.unsupervised.attribute.Add;
  import weka.core.converters.ArffSaver;
  import java.io.*;
  import java.util.*;
 
  /**
   * Adds a nominal and a numeric attribute to the dataset provided as first
   * parameter (and fills it with random values) and outputs the result to
   * stdout. It's either done via the Add filter (first option "filter")
   * or manual with Java (second option "java").
   *
   * Usage: AddAttribute &lt;file.arff&gt; &lt;filter|java&gt;
   *
   * @author FracPete (fracpete at waikato dot ac dot nz)
   */
  public class AddAttribute {
    /**
     * adds the attributes
     *
     * @param args    the commandline arguments
     */
    public static void main(String[] args) throws Exception {
      if (args.length != 2) {
        System.out.println("\nUsage: AddAttribute <file.arff> <filter|java>\n");
        System.exit(1);
      }
 
      // load dataset
      Instances data = new Instances(new BufferedReader(new FileReader(args[0])));
      Instances newData = null;
 
      // filter or java?
      if (args[1].equals("filter")) {
        Add filter;
        newData = new Instances(data);
        // 1. nominal attribute
        filter = new Add();
        filter.setAttributeIndex("last");
        filter.setNominalLabels("popular,unpopular");
        filter.setAttributeName("class");
        filter.setInputFormat(newData);
        newData = Filter.useFilter(newData, filter);
      }
      else if (args[1].equals("java")) {
        newData = new Instances(data);
        // add new attributes
        List<String> values = new ArrayList<String>(); 
        values.add("popular");               
        values.add("unpopular");
        //newData.insertAttributeAt(new Attribute("class", values), newData.numAttributes());

      }
      else {
        System.out.println("\nUsage: AddAttribute <file.arff> <filter|java>\n");
        System.exit(2);
      }
 
      for (int i = 0; i < newData.numInstances(); i++) {
      		Instance in = newData.instance(i);
			double value = in.value(newData.numAttributes() - 2); 
      		if (value < 1400 ) {
        		newData.instance(i).setValue(newData.numAttributes() - 1, 1);
        	} else {
        		newData.instance(i).setValue(newData.numAttributes() - 1, 0);
        	}

      }
		ArffSaver saver = new ArffSaver();
 		saver.setInstances(newData);
		saver.setFile(new File("/mashable_nom.arff"));
 		saver.writeBatch();
    }
  }