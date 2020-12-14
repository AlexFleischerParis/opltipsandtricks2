//using CP;

tuple t
{
int line;
int value;
}

{t} s;

// Parse cnf file
execute
    {
    var line=0;    
    
    var f=new IloOplInputFile("uf250-01.cnf");
    
    while (!f.eof)
    {
    var str=f.readline();
    
    var firstchar=str.substring(0,1);
    if (firstchar=="c") continue;
    if (firstchar=="p") continue;
    if (firstchar=="%") continue;
    
    line++;
    
    writeln(str);
    var ar=str.split(" ");
    
    if (0==ar.length) continue;
    
    
    for(var i=0;i<ar.length-1;i++) if (ar[i]!="") s.add(line,ar[i]);
    if (ar[ar.length-1]!=0) fail();
    }
    f.close();
    }
    
    
int nbConstraints = max(i in s) i.line;
{int} trueVariables[i in 1..nbConstraints]={j.value | j in s : j.line==i && j.value>0};
{int} falseVariables[i in 1..nbConstraints]={-j.value | j in s : j.line==i && j .value <0};

int nbVariables=max(i in 1..nbConstraints) 
	maxl(max(j in trueVariables[i]) j,max(j in falseVariables[i])j);
	
dvar boolean x[1..nbVariables];
dvar int+ obj;

// Minimize the number of constraints that are not satisfied
minimize obj;

subject to
{	

obj==nbConstraints-
sum(i in 1..nbConstraints) 
(1<=sum(j in trueVariables[i]) x[j]+sum(j in falseVariables[i]) (1-x[j]));

} 

{int} which={i | i in 1..nbVariables:x[i]==1};

execute
{
writeln("True : ",which); 
} 

/*

which gives

True :  {3 5 6 7 8 9 10 11 14 16 17 21 25 26 27 28 29 31 32 34 35 36 37 39 45 46 47
     48 50 51 53 57 59 61 62 64 65 67 68 69 71 72 73 74 80 82 83 85 88 89 90
     91 92 94 98 103 105 106 109 110 111 112 117 118 120 121 124 125 126 128
     133 135 137 138 139 146 148 150 151 153 155 156 157 159 160 162 163 168
     169 170 172 173 174 176 178 180 181 182 183 185 186 187 189 190 191 192
     196 197 198 199 200 202 207 208 211 212 213 214 216 217 218 219 220 223
     225 227 230 231 236 239 242 243 245 248}
     
     */

