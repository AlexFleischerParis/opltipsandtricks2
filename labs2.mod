// LABS
// Low Autocorrelation Binary Sequences (LABS)

using CP;

int n=30;
range N=1..n;
range N0=0..n;

dvar boolean x[N];
dexpr int s[i in N]=-1+2*x[i];
dvar int Ck[N0];
dvar int square[N0];
dvar int E;

int xEval[i in N]=minl(i, n - 1 - i);
   
// Search phase
execute {
  var f = cp.factory;
   var phase1 = f.searchPhase(x, 
          //f.selectSmallest(f.varIndex(x)), 
          f.selectSmallest(f.explicitVarEval(x,xEval)), 
          f.selectRandomValue());
          ;
          cp.setSearchPhases(phase1);
          cp.param.RestartProofEmphasis=0.99;
          
}

minimize E;
subject to
{
 
  
  forall(k in N0) Ck[k]==sum(i in 1..n-k) (-1+2*(s[i]==s[i+k]));
  forall(k in N) square[k]==Ck[k]*Ck[k];
  
  forall(k in N) square[k] in { (i-(n-k-i))*(i-(n-k-i))| i in 0..n-k};
  E==sum(k in 1..n-1) square[k];
  
  // Better bounds and symmetries
  
  lex(x,all(i in N)x[n+1-i]);
  
   forall(k in N0) abs(Ck[k])>=(n-k) mod 2;
  E>=sum(k in 1..n-1) ((n-k) mod 2)^2;
}
