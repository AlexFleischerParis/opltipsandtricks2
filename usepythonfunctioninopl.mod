/*

Suppose we need the result of np.linspace(3, 9, 10) in OPL

we can translate this into OPL or call python from OPL

*/

// Translate into OPL

float minValue=3;
float maxValue=9;
int nbValues=10;
{float} linspace={ minValue+(maxValue-minValue)/(nbValues-1)*i | i in 0..(nbValues-1)};

execute
{
  writeln(linspace);
}


// call python
{float} linspace2;

execute
{
  var paramfile=new IloOplOutputFile("c:\\temp\\paramlinspace.txt");
  paramfile.writeln(minValue);
  paramfile.writeln(maxValue);
  paramfile.writeln(nbValues);
  paramfile.close();
  
  IloOplExec("C:\\Python36\\python.exe c:\\temp\\callnumpylinspace.py",false);
  
  var resultfile=new IloOplInputFile("c:\\temp\\resultlinspace.txt");
  while (!resultfile.eof)
  {
    var x=Opl.floatValue(resultfile.readline());
    linspace2.add(x);
  }
  resultfile.close();
}

execute
{
  writeln(linspace2);
}

/*

which gives

{3 3.6667 4.3333 5 5.6667 6.3333 7 7.6667 8.3333 9}
 {3 3.6667 4.3333 5 5.6667 6.3333 7 7.6667 8.3333 9}
 
 */
