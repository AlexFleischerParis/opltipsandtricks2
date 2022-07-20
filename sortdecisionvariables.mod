

        using CP;

        int n=10;
        int v[i in 1..n]=rand(20);

        dvar int x[1..n]; // not sorted
        dvar int y[1..n]; // sorted
        dvar int perm[1..n] in 1..n;

        subject to
        {
        forall(i in 1..n) x[i]==v[i];

        allDifferent(perm); // permutation

        forall(i in 1..n) y[i]==x[perm[i]]; // apply permutation

        forall(i in 1..n-1) y[i]<=y[i+1]; // order

        }

        execute
        {
        writeln("input ",x);
        writeln("perm ",perm);
        writeln("output ",y);
        }
        
        assert forall(i in 1..n-1) x[perm[i]]<=x[perm[i+1]]; 
        
        /*
        
        which can give
        
        input  [4 4 4 2 8 19 13 16 11 1]
		perm  [10 4 2 3 1 5 9 7 8 6]
		output  [1 2 4 4 4 8 11 13 16 19]

        */
