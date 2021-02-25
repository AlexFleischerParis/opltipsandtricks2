int n=...;
range points=1..n;
float x[points]=...;
float y[points]=...;

float xmin=min(p in points) x[p];
float xmax=max(p in points) x[p];

int nbLines=2;

range lines=1..nbLines;

dvar float a[lines];
dvar float b[lines];

dvar float distance[points][lines];
dvar boolean which[points]; // 1 means 1, 0 means 2

minimize sum(i in points,j in lines) distance[i][j]^2; 

subject to
{
forall(i in points,j in 0..1) (which[i]==j) => (distance[i][2-j]==b[2-j]*x[i]+a[2-j]-y[i]);

}



execute
{

writeln("b = ",b);
writeln("a = ",a);
writeln("which = ",which);
}

execute display
{
function display_points_and_line(x,y,xmin,xmax,points,filename)
{
   var sep="\'";

   var o=new IloOplOutputFile(filename);
   o.writeln("import numpy as np ");
   o.writeln("import matplotlib.pyplot as plt");
   
   o.write("plt.plot([");
   for(var i in points) if (which[i]==1) o.write(x[i],",");
   o.write("], [");
   for(var i in points)  if (which[i]==1)o.write(y[i],",");
   o.writeln("],",sep,"bo",sep,")");
   
   o.write("plt.plot([");
   for(var i in points) if (which[i]==0) o.write(x[i],",");
   o.write("], [");
   for(var i in points)  if (which[i]==0)o.write(y[i],",");
   o.writeln("],",sep,"ro",sep,")");
   
   
   o.writeln("xline = np.linspace(",xmin,",",xmax,",100)");
   o.writeln("yline = ",b[1],"*xline+",a[1]);
   o.writeln("plt.plot(xline, yline,", sep,"-g",sep, ",label=",sep,"line",sep,")");
   
   o.writeln("xline = np.linspace(",xmin,",",xmax,",100)");
   o.writeln("yline = ",b[2],"*xline+",a[2]);
   o.writeln("plt.plot(xline, yline,", sep,"-g",sep, ",label=",sep,"line",sep,")");
   
   o.writeln("plt.show()");
   o.close();
   
   var exec="C:\\Python36\\python.exe "+filename;
   IloOplExec(exec);
}


display_points_and_line(x,y,xmin,xmax,points,"c:\\temp\\display.py");

}
