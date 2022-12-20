// Let us use slicing

float d1;
float d2;

execute
{
  d1=new Date();
}

int N=100000000;
range r=1..N;

dvar int x;

subject to
{
// forall(i in r)
//  if(i==2) x==i;
    
    forall(i in r:i==2)
   x==i;
}

execute
{
  d2=new Date();
  writeln("This takes ",(d2-d1)/1000," seconds");
}

/*

This takes 0.027 seconds

// 13s if we used "if"

*/
