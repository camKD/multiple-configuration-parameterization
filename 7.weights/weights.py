import numpy as np

namein='GZW1C1'
tempa=310.0
outflag='MC' #a free label, not necessary to  modify
wmultipl=9 #equal to the sum of the weights: it should be equal to the number of configurations

### ### ### DO NOT MODIFY BEYOND THIS POINT

#/mnt/nms-tier3/kcl/group/molteni/alescrnjar/molt_SIMULAZIONI/4a_parametriz/ellagic/enandbolz.f95

kB=0.0019872041 #1.0 #0.0019872041 #1.38e-5 #1.0
factor=627.5 #1.0 #627.5
inpname='../6.energy_sort/energy.log'
outname='energy_weights.log'
data=[]
inpf=open(inpname,"r")
for line in inpf.readlines():
    data.append([])
    for i in line.split():
        data[-1].append(i)
inpf.close()
minen=999999.99999
for line in range(len(data)):
    if (float(data[line][1])<minen):
        minen=factor*float(data[line][1])
print("Minimum energy:",minen)
outf=open(outname,"w")
wsum=0.0
#wsum1=0.0
for line in range(len(data)):
    differ=factor*float(data[line][1])-minen
    wsum+=np.exp(-(differ)/(kB*tempa))
    #wsum1+=np.exp(-(factor*float(data[line][1]))/(kB*tempa)) #NaN
for line in range(len(data)):
    w1=np.exp(-(factor*float(data[line][1])-minen)/(kB*tempa))
    w2=(np.exp(-(factor*float(data[line][1])-minen)/(kB*tempa)))/wsum
    w2x=format(wmultipl*w2,'.16f')
    #w3=(np.exp(-(factor*float(data[line][1]))/(kB*tempa))) #NaN
    #w4=(np.exp(-(factor*float(data[line][1]))/(kB*tempa)))/wsum1 #NaN
    #print data[line][0],str(factor*float(data[line][1])),str(w1),str(w2),str(w3),str(w4)
    print(data[line][0],str(factor*float(data[line][1])),str(w1),str(w2))
    ##outf.write(data[line][0]+' '+str(factor*float(data[line][1]))+' '+str(w1)+'\n')
    #outf.write(data[line][0]+' '+str(factor*float(data[line][1]))+' '+str(w2)+'\n') #PERFECT OLD ONE
    outf.write(data[line][0]+' '+str(factor*float(data[line][1]))+' '+str(w2x)+'\n')
outf.close()
print("DONE: "+str(outname))

