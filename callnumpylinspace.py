
import numpy as np 


f = open("c://temp//paramlinspace.txt", "r")

minValue=int(f.readline())
maxValue=int(f.readline())
nbValues=int(f.readline())

f.close()

res=np.linspace(minValue,maxValue,nbValues)

f2= open("c://temp//resultlinspace.txt", "w")

for i in range(0,len(res)):
   f2.write(str(res[i]))
   if (i!=len(res)-1):
      f2.write("\n")

f2.close()




