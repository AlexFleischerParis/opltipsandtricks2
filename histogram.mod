    execute
    {

    // turn an OPL array into a python list
    function getPythonListOfArray(_array)
    {

    var quote="\"";
    var nextline="\\\n";
    var res="[";
    for(var i in _array)
    {
    var value=_array[i];
    if (typeof(value)=="string") res+=quote;
    res+=value;
    if (typeof(value)=="string") res+=quote;
    res+=",";
    res+=nextline;
    }
    res+="]";
    return res;
    }
    // Display ahistogram for values x in num_bins bins
    function displayhistogram(x,num_bins,pythonpath,pythonfile)
    {
    writeln("displayhistogram ",x," ",num_bins," ",pythonpath," ",pythonfile);
    var python=new IloOplOutputFile(pythonfile);
    python.writeln("import matplotlib.pyplot as plt");
    python.writeln("x = ",getPythonListOfArray(x))
    python.writeln("num_bins = ",num_bins)
    
    python.writeln("n, bins, patches = plt.hist(x, num_bins)");
    python.writeln("plt.title('histogram')");
    python.writeln("plt.show()");
    python.close();
    IloOplExec(pythonpath+" "+ pythonfile,true);        
    }
   
    }
  
    // Some values
    float values[1..20]=[0,1,1,5,12,12,12,17,11,3,9,3,2,1,7,3,9,9,9,9];
    
    string pythonpath="C:\\Python36\\python.exe";
    string pythonfile="C:\\temp\\Displayhistogram.py";
    execute
    {
    displayhistogram(values,4,pythonpath,pythonfile);
    } 
