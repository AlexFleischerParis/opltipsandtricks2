

      

        int n=10;
        int v[i in 1..n]=rand(20);

        dvar int x[1..n]; // not sorted
        dvar int y[1..n]; // sorted
        dvar boolean perm[1..n][1..n];
        dvar int permx[1..n][1..n];

        subject to
        {
        forall(i in 1..n) x[i]==v[i];

        // permutation
        forall(i in 1..n)
          {
            sum(j in 1..n) perm[i][j]==1;
            sum(j in 1..n) perm[j][i]==1;
          }
          
        forall(i in 1..n,j in 1..n) (perm[i][j]==0) => (permx[i][j]==0);
        forall(i in 1..n,j in 1..n) (perm[i][j]==1) => (permx[i][j]==x[j]);

        forall(i in 1..n) y[i]==sum(j in 1..n) permx[i][j]; // apply permutation

        forall(i in 1..n-1) y[i]<=y[i+1]; // order

        }

        execute
        {
        writeln("input ",x);
        writeln("perm ",perm);
        writeln("output ",y);
        }
        
        //assert forall(i in 1..n-1) x[perm[i]]<=x[perm[i+1]]; 
        
        /*
        
        which can give
        
        input  [4 4 4 2 8 19 13 16 11 1]
		perm  [10 4 2 3 1 5 9 7 8 6]
		output  [1 2 4 4 4 8 11 13 16 19]

        */

