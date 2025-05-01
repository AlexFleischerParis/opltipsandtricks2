// LABS
// Low Autocorrelation Binary Sequences (LABS)
using CP;

//int mul[i in -1..1][j in -1..1]=i*j;

int n=20;
range N=1..n;
range N0=0..n;
dvar int s[N] in -1..1;
dvar int Ck[N0];
dvar int E;

minimize E;
subject to
{
  s[1]==1;
  forall(i in N) s[i] in {-1,1};
  
  forall(k in N0) Ck[k]==sum(i in 1..n-k) (s[i]*s[i+k]);
  E==sum(k in 1..n-1) Ck[k]*Ck[k];
  
  forall(k in N0) abs(Ck[k])>=(n-k) mod 2;
  E>=sum(k in 1..n-1) ((n-k) mod 2)^2;
  
}
