from rsf.proj import*
from rsf.prog import RSFROOT
from math import *



	
def Grey3(data,other):
	Result(data,
       '''
       put d1=0.004 o3=1 d2=1 d3=1 | byte  clip=0.2 |
       grey3 flat=n frame1=60 frame2=10 frame3=9
       point1=0.8 point2=0.8 label2=Inline label3=Xline label1="Time (s)" title=
       screenratio=1.3 unit2=trace unit3=trace font=104  color=b %s'''%other)
	

       
def Greys(data,other):
     Result(data,
     '''put d1=0.004 o3=1 d2=1 d3=1 | clip clip=0.15 | byte  clip=0.4 bar=bar.rsf | grey3 labelfat=4 font=2 titlefat=4 label2=Inline label3=Xline flat=n frame1=60 frame2=10 frame3=9
       point1=0.8 point2=0.8 screenratio=1.3 label1=Time unit1=s label2=Inline label3=Xline maxval=0.4 		%s'''%(other))

def Greys2d(data,other):
	Result(data,
		'''put d1=0.004 | grey clip=0.6 label2=Inline unit2=km label3=Xline unit2=km flat=n screenratio=1.2 title= wanttitle=y flat=n labelfat=4 font=2 titlefat=4				
				label2=Trace unit2="" label1="Time"  unit1=s
				title="" wherexlabel=b wheretitle=t poly=y 
				wheretitle=t wherexlabel=b labelsz=10 color=b %s'''%(other))


def Grey3s(data,other,clip):
	Result(data,
       '''
       byte clip=%g  gainpanel=all  bar=bar.rsf|
       grey3 flat=n frame1=60 frame2=10 frame3=10
       point1=0.8 point2=0.8 label2=Inline label3=Xline label1="Time" unit1=s title=
       screenratio=1.3 color=j font=104 scalebar=y maxval=1 minval=0 %s'''%(clip,other))

## Load data

#Flow('syn3d-30-nn1','syn3d_30_nn.bin','bin2rsf bfile=${SOURCES[0]} n1=126 n2=1024 | put n2=32 n3=32 d1=0.004')
Flow('syn3d-30-c1','syn3d_30_c.bin','bin2rsf bfile=${SOURCES[0]} n1=126 n2=1024 | put n2=32 n3=32 d1=0.004')
Flow('syn3d-30-n1','syn3d_30_n.bin','bin2rsf bfile=${SOURCES[0]} n1=126 n2=1024 | put n2=32 n3=32 d1=0.004')
Flow('obs','obs_hyp.bin','bin2rsf bfile=${SOURCES[0]} n1=126 n2=1024 | put n2=32 n3=32 d1=0.004')
Flow('mask','mask_hyp.bin','bin2rsf bfile=${SOURCES[0]} n1=126 n2=1024 | put n2=32 n3=32 d1=0.004')

Flow('syn3d_30_out1','den_hyp.bin','bin2rsf bfile=${SOURCES[0]} n1=126 n2=1024 | put n2=32 n3=32 d1=0.004')
Flow('syn3d_30_err','err_hyp.bin','bin2rsf bfile=${SOURCES[0]} n1=126 n2=1024 | put n2=32 n3=32 d1=0.004')

Grey3('syn3d-30-c1','title=Clean')
Grey3('syn3d-30-n1','title=Noisy')
Grey3('obs','title=Observed')
Grey3('mask','title=Mask')

Grey3('syn3d_30_out1','title="Reconstructed data (Proposed)"')
Grey3('syn3d_30_err','title="Reconstruction error (Proposed)"')

Flow('syn3d_30-simi_Proposed','syn3d-30-c1 syn3d_30_out1','similarity other=${SOURCES[1]} niter=20 rect1=1 rect2=1 rect3=2 ')
Grey3s('syn3d_30-simi_Proposed','title="Similarity map (Proposed)"',1.0)

Flow('synth-s-c','syn3d-30-c1','window n3=1 f3=4')
Flow('synth-s-n','syn3d-30-n1','window n3=1 f3=4')
Flow('obs-s-out','obs','window n3=1 f3=4')
Flow('synth-s-out','syn3d_30_out1','window n3=1 f3=4')
Greys2d('synth-s-c','title=Clean')
Greys2d('synth-s-n','title=Noisy')
Greys2d('obs-s-out','title=Observed')
Greys2d('synth-s-out','title=Proposed')


Flow('synth-s-out-simi','syn3d_30-simi_Proposed','window n3=1 f3=4')
Greys2d('synth-s-out-simi','color=j scalebar=y clip=0.6 minval=0 maxval=1 title="Proposed" barlabel="Amplitude"')




End()
