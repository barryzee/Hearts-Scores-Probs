## winner.good.awk ##
## several mistakes were corrected on 02.04.19
## final = 99
## formatting of printf statements
## adding maxi to s3start function
## on 02.05.19 correct
## initial as param to function s3start,modify function s3start to use initial
## 02.9.19 start to integrate the bias functions from test.awk
## 03.04.19 correct call to s3start() replace "initial" with "s[2]": for(s[3]=s3start(s,s[2],final);s[3]<=final;s[3]+=26) {

## use XCODE app to check for matching parentheses and brackets

# nohup gawk -f winner.good.dev.awk &> OUTPUTFILE_NAME &
# tail -f OUTPUTFILE_NAMEfsquash5

# gawk -f winner.good.dev.awk -v ODIR="/Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/results" -v DEBUG=0 -v Pmoon=0.05 -v N=100000 -v BIAS=0 -v level="novice" -v initial=40 -v final=60 -v del=1

# gawk -f winner.good.dev.awk -v ODIR="/Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/results" -v DEBUG=0 -v Pmoon=0.05 -v N=1000 -v BIAS=1 -v level="advanced" -v initial=20 -v final=99 -v del=1 -v squash5=.10 -v squash10=.40 -v squash20=.50 -v squash100=.60

#Barrys-Mac-mini:score.testing.01.23.19 barryzeeberg$ nohup gawk -f winner.good.awk &> winner.out.unbias.100000 &
#[1] 2997 


# implements a bias of the player(s) with low score taking hearts or QS
# ie, being differentially targeted by the other players

BEGIN {
	# use default values if not assigned on command line
	if(ODIR=="") ODIR="."
	if(DEBUG=="") DEBUG=0
	if(squash5=="") squash5=.10
	if(squash10=="") squash10=.40
	if(squash20=="") squash20=.50
	if(squash100=="") squash100=.60
	if(Pmoon=="") Pmoon=0.05
	if(N=="") N=1000
	if(BIAS!=1) BIAS=0
	if(level=="" || BIAS!=1) level="novice" # see generateSkillLevels() for valid levels
	if(initial=="") initial=20
	if(final=="") final=99
	if(del=="") del=1

	for(i=1;i<ARGC;i++) delete ARGV[i]

	systime_start=systime()
	systime_start_format0=strftime("%m_%d_%Y_%H_%M_%S", systime())
	systime_start_format=strftime("%m_%d_%Y_%H_%M_%S", systime_start)
	print "FORMAT",systime_start_format0,systime_start_format

	name0=sprintf("%s_%d_%.4f_%d_%d_%s_%d_%d_%d_%.4f_%.4f_%.4f_%.4f", systime_start_format,DEBUG,Pmoon,N,BIAS,level,initial,final,del,squash5,squash10,squash20,squash100)
	dfile=sprintf("%s/%s.xls",ODIR,name0)
	mfile=sprintf("%s/%s.meta.txt",ODIR,name0)
	efile=sprintf("%s/%s.errorMessages.txt",ODIR,name0)


	#fname=sprintf("%s_%d_%.4f_%d_%d_%s_%d_%d_%d.xls", systime_start_format,DEBUG,Pmoon,N,BIAS,level,initial,final,del)
	#dfile=sprintf("%s/%s",ODIR,fname)
	#mname=sprintf("%s_%d_%.4f_%d_%d_%s_%d_%d_%d.meta.txt", systime_start_format,DEBUG,Pmoon,N,BIAS,level,initial,final,del)
	#mfile=sprintf("%s/%s",ODIR,mname)
	print "FNAME",dfile,mfile

	printf "%25s\t%15s\t%15s\t%15s\t%15s\t%15s\t%15s\t%15s\t%15s\t%15s\t%15s\t%15s\t%15s\n", "PARAMETERS:","DEBUG","squash5","squash10","squash20","squash100","Pmoon","N","BIAS","level","initial","final","del" > mfile
	printf "%25s\t%15d\t%15.4f\t%15.4f\t%15.4f\t%15.4f\t%15.4f\t%15d\t%15d%15s\t%15d\t%15d\t%15d\n", "PARAMETER VALUES:",DEBUG,squash5,squash10,squash20,squash100,Pmoon,N,BIAS,level,initial,final,del > mfile

	fflush() # flush buffer to mfile in case of premature termination

	if(BIAS) intitializeBias(level,squash)

	isMoon=notMoon=0

	for(s[0]=initial;s[0]<=final;s[0]+=del)
	for(s[1]=s[0];s[1]<=final;s[1]+=del)
	for(s[2]=s[1];s[2]<=final;s[2]+=del) {
	#for(s[3]=s3start(s,initial,final);s[3]<=final;s[3]+=26) {
	for(s[3]=s3start(s,s[2],final);s[3]<=final;s[3]+=26) {

	for(i=0;i<=3;i++) {
		score[0,i]=s[i]
		printf "%5d\t",s[i] > dfile
	}

	srand()
	cards[0]=13
	for(c=1;c<=13;c++)
		cards[c]=1

	for(nn=1;nn<=N;nn++) {
		over=0
		for(hand=1;;hand++) {
			for(p=0;p<=3;p++)
				score[hand,p]=score[hand-1,p]
			

			for(p=0;p<=3;p++)
				sc[p]=score[hand,p]

			if(BIAS) {				
				# random r determines if this hand is a moon
				r=rand()
				if(r<=Pmoon) {
					if(DEBUG) print "moon!"
					p0=rand2target(sc,squash,dev,level,targ)
					if(DEBUG) print "DEBUG","MOON LOOP","P0",p0
					if(DEBUG) print "MOON LOOP BEFORE","HAND",hand,"SCORE",score[hand,p0]
					if(DEBUG) print "MOON LOOP BEFORE2",score[hand,0],score[hand,1],score[hand,2],score[hand,3]
					for(p=0;p<=3;p++)
						score[hand,p]+=26*(p!=p0)
					if(DEBUG) print "MOON LOOP AFTER","HAND",hand,"SCORE",score[hand,p0]
					if(DEBUG) print "MOON LOOP AFTER2",score[hand,0],score[hand,1],score[hand,2],score[hand,3]
					isMoon++
				} # if(r<=Pmoon)
				else {
					for(c=0;c<=13;c++) {
						p0=rand2target(sc,squash,dev,level,targ)
						if(DEBUG) print "DEBUG","NO MOON","C",c,"P0",p0
						if(DEBUG) print "NO MOON BEFORE","HAND",hand,"C",c,"SCORE",score[hand,p0]
						score[hand,p0]+=cards[c]
						sc[p0]=score[hand,p0]
						if(DEBUG) print "NO MOON AFTER","HAND",hand,"C",c,"SCORE",score[hand,p0]
					} # for(c=0;c<=13;c++)

				if(DEBUG) for(p=0;p<=3;p++) print "NO MOON OUTSIDE",hand,p,score[hand,p] 

				notMoon++
				#exit

				} # else

			} # if(BIAS)

			else { # ie !BIAS
				# the following block is the original code, before I added bias
				r=rand()
				# which target range does the random number fall into?
				# uniformly distributed random numbers between 0 and 4
				# 4 equal length target ranges (hand 0) 0 to 1, (hand 1) 1 to 2, (hand 2) 2 to 3, (hand 3) 3 to 4
				# for example, if random number (ie, 4*rand()) is 3.2, it is truncated to 3 and mapped to hand 3
				# so hand 3 takes the hearts and QS in this trick
				if(r<=Pmoon) {
					#print "moon!"
					p0=int(4*rand())
					for(p=0;p<=3;p++)
						score[hand,p]+=26*(p!=p0)
					isMoon++
				} #if(r<=Pmoon)
				else { # ie !moon
					for(c=0;c<=13;c++) {
						p0=int(4*rand())
						for(p=0;p<=3;p++)
							score[hand,p]+=cards[c]*(p==p0)
					} # for(c=0;c<=13;c++)
					notMoon++
				} # else ie !moon
				# END OF ORIGINAL BLOCK OF CODE
			} # else, ie !BIAS

			for(p=0;p<=3;p++)
				if(score[hand,p]+0>=100+0)
					over=1

			if(over) {
				min=1000
				for(p=0;p<=3;p++)
					min=score[hand,p]+0<min+0?score[hand,p]:min

				for(h=1;h<=hand;h++)
					for(p=0;p<=3;p++) {
						v=score[hand,p]==min?"w":"l"
						#print n"\t"h"\t"p"\t"score[h,p]"\t"v
					} #for(p=0;p<=3;p++)

				for(p=0;p<=3;p++) {
					v=score[hand,p]==min?"w":"l"
					stats[s[0],s[1],s[2],s[3],p]+=v=="w"
				} #for(p=0;p<=3;p++)

				break
			} #if(over)
		} # for(hand=1;;hand++)
	} # for(n=1;n<=N;n++)
	tot=0
	for(p=0;p<=3;p++)
		tot+=stats[s[0],s[1],s[2],s[3],p]

	for(p=0;p<=3;p++)
		printf "%10.6f\t",stats[s[0],s[1],s[2],s[3],p]/tot > dfile
	printf "\n" > dfile
	fflush() # save available results to dfile in case of premature termination
	} # for(s[3]=s3start(s,initial,final);s[3]<=final;s[3]+=26)
	} # for(s[2]=s[1];s[2]<=final;s[2]+=del)

	print "\nMOON STATS:",isMoon,notMoon,isMoon/(isMoon+notMoon),Pmoon,"\n" > mfile

	print "\nTIMING STATS:" > mfile
	print "Starting Time",systime_start_format > mfile
	print strftime("Ending Time = %m/%d/%Y %H:%M:%S", systime()) > mfile
	print printTimeinterval(systime()-systime_start) > mfile

	print "HAND: ENDTIME:",systime()

} # BEGIN

function s3start(s,initial,final,  i,v,maxi,sum) {
	# s3start is selected so that the sum s0 + s1 + s2 + s3 is a valid score, ie a multiple of 26
	# max value for sum + initial = s[0] + s[1] + s[2] + 100 = 99 + 99 + 99 + 100 = 297 + 100 = 397
	# 26 * 15 = 390
	# 26 * 16 = 416
	maxi = 16

	for(i=0;i<=2;i++)
		sum+=s[i]

	for(i=0;i<=maxi;i++) {
		v=26*i
		if(v-sum>=initial) {
			###if(v-sum>final) print "S3START WARNING!!!\n","v-sum>FINAL:",v-sum,final,"\n","PLEASE INCREASE THE VALUE OF FINAL\n" > efile
			return v-sum
		}
	}
	print "S3START ERROR:",i,initial,final,maxi,v,sum,v-sum > efile
	exit
}

function printTimeinterval(sec) {
	# reasonable choice of units for time interval
	print "printTimeinterval",sec
	if(sec < 60) return sprintf("%d seconds\n",sec)
	if(sec < 3600) return sprintf("%.3f minutes\n",sec/60)
	if(sec < 86400) return sprintf("%.3f hours\n",sec/3600)
	return sprintf("%.3f days\n",sec/8400)
}

####### BELOW HERE ARE FUNCTIONS FOR BIAS #####
####### @include or multiple files to gawk -f does not seem to work for me ####

function intitializeBias(level,squash, skill,maxv,i) {
	# call functions to generate skill levels and generate squash function
	generateSkillLevels(skill)
	maxv=skill[level]
	#maxv=100*skill[level]
	if(DEBUG) for(i in skill) print "DEBUG","skill",i,skill[i],level,maxv
	generateSquashFunction(squash,maxv)
}

function generateSkillLevels(skill) {
	# assign bias weight depending on general level of players
	# ie, novice will not try to hit low whatsoever
	# ie, expert try to hit low as often as possible AND as effectively as possible
	# these values are based on intuition, and they can be adjusted manually after examining tabulation generated in adjustTargetInterval()
	skill["novice"]=0.00
	skill["intermediate"]=0.25
	skill["advanced"]=0.50
	skill["expert"]=1.00

	return
}

function generateSquashFunction(squash,maxv) {
	# the numerical values in squash were subjectively determined
	# by exhaustive trial and error
	# in order to result in the behavior that I think is reasonable
	# I was not able to find an analytic function that could reproduce
	# this behavior - that would have made this much simpler to implement
	# than interpolation of tabulated values

	# this block is referred to as "original" squash function
	# I examined results as "expert" level
	# I decided that this gives too high a probability for
	# high scores, need to tamp this down a bit
	# I changed to the block below this 02.25.19
	# squash[1,1]=-100
	# squash[1,2]=-maxv*1
	# squash[2,1]=-20
	# squash[2,2]=-maxv*.9
	# squash[3,1]=-10
	# squash[3,2]=-maxv*.7
	# squash[4,1]=-5
	# squash[4,2]=-maxv*.3
	# squash[5,1]=0
	# squash[5,2]=0

	# squash[1,1]=-100
	# squash[1,2]=-maxv*.85
	# squash[2,1]=-20
	# squash[2,2]=-maxv*.75
	# squash[3,1]=-10
	# squash[3,2]=-maxv*.65
	# squash[4,1]=-5
	# squash[4,2]=-maxv*.25
	# squash[5,1]=0
	# squash[5,2]=0

	squash[1,1]=-100
	squash[1,2]=-maxv*squash100
	squash[2,1]=-20
	squash[2,2]=-maxv*squash20
	squash[3,1]=-10
	squash[3,2]=-maxv*squash10
	squash[4,1]=-5
	squash[4,2]=-maxv*squash5
	squash[5,1]=0
	squash[5,2]=0

	for(i=1;i<5;i++) {
		squash[i+5,1]=-squash[5-i,1]
		squash[i+5,2]=-squash[5-i,2]
	}

	if(DEBUG) for(i=1;i<=9;i++) print "DEBUG","generateSquashFunction",maxv,i,squash[i,1],squash[i,2]
	return
}

function rand2target(sc,squash,dev,level,targ ,p,p0)    {
	# map the rand number to 1 of 4 target ranges
	# ranges indexed as 0,1,2,3

	if(DEBUG) for(p in sc) print "rand2target","SCORE",p,sc[p]

	targetRangeDriver(sc,squash,dev,level,targ)
	p0=targ[3]*rand()
	for(p=0;p<=3;p++) {
		if(DEBUG) print "rand2target","PLOOP",p0,p,targ[p]
		if(p0<=targ[p]) {
			if(DEBUG) print "rand2target","FOUND",p0,p,targ[p]
			return p # p is the index of the target range that rand mapped to
		} # if(p0<=targ[p])
	} # for(p=0;p<=3;p++)
	print "rand2target","target range not found",p0
	for(p=0;p<=3;p++) print "rand2target","target ranges:" targ[p]
	###exit
}

function targetRangeDriver(sc,squash,dev,level,targ ,p,lint,t) {	
	# compute mean and deviations from mean
	meanDev(sc)

	# linear interpolation within Squash Function
	for(p in dev) {
		lint[p]=interpolateSquashFunction(squash,length(squash),dev[p])
		if(DEBUG) print "DEBUG","ISF",sc[p],dev[p],lint[p]
	}
				
	# compute the biased end points of the biased target ranges
	adjustTargetInterval(lint,targ,level,dev)
	if(DEBUG) for(t in targ) print "DEBUG","targetRangeDriver inside function",t,targ[t]

	return
}

function meanDev(sc, t,p,m) {
	# mean and deviations from mean for the current set of 4 scores for the 4 players
	t=0
	for(p in sc) t+=sc[p]
	m=t/length(sc)
	for(p in sc) dev[p]=sc[p]-m
	if(DEBUG) for(p in dev) print "DEBUG","DEV",p,m,sc[p],dev[p]

	return
}

function interpolateSquashFunction(squash,n,v) {
	for(i=1;i<=n;i++) {
		# search for the tabulated point that is closest above the data point
		if(DEBUG) print "DEBUG","interpolateSquashFunction SEARCHING . . .",v,i,squash[i,1],squash[i,2]
		if(v<=squash[i,1])
			break
	}
	if(DEBUG) print "DEBUG","interpolateSquashFunction FOUND",v,i,squash[i,1],squash[i,2]
	# linear interpolation between the found end point and the previous (lower) tabulated point 
	if(typeof(li=linearInterpolate(squash,n,i,v))!="number") {
		if(DEBUG) print "DEBUG","interpolateSquashFunction","PREMATURE TERMINATION",li,v,i
		exit 
	}
	if(DEBUG) print "DEBUG","interpolateSquashFunction","RETURN VAL",li
	
	return li
}

# july 20 2021 I was testing, and I noticed that i,li needed to be added to end of function args.
# this did not seem to affect my previous results, but I add the correction here for archival purposes
function interpolateSquashFunction_corrected(squash,n,v, i,li) {
	for(i=1;i<=n;i++) {
		# search for the tabulated point that is closest above the data point
		if(DEBUG) print "DEBUG","interpolateSquashFunction SEARCHING . . .",v,i,squash[i,1],squash[i,2]
		if(v<=squash[i,1])
			break
	}
	if(DEBUG) print "DEBUG","interpolateSquashFunction FOUND",v,i,squash[i,1],squash[i,2]
	# linear interpolation between the found end point and the previous (lower) tabulated point 
	if(typeof(li=linearInterpolate(squash,n,i,v))!="number") {
		print "DEBUG","interpolateSquashFunction","PREMATURE TERMINATION",li,v,i
		exit 
	}
	if(DEBUG) print "DEBUG","interpolateSquashFunction","RETURN VAL",li
	
	return li
}

function linearInterpolate(squash,n,i,v) {
		# linear interpolation between end points of tabulated interval
		if(i<1)
			return("i<1")
		if(i>n)
			return("i>n")
		fract=(v-squash[i-1,1])/(squash[i,1]-squash[i-1,1])
		val=squash[i-1,2]+fract*(squash[i,2]-squash[i-1,2])
		if(DEBUG) print "DEBUG","linearInterpolate",v,squash[i-1,1],squash[i,1],fract,val
		return val
}

function adjustTargetInterval(lint,targ,level,dev ,i) {
	# compute the endpoints of the target intervals
	v=0
	if(DEBUG) printf "%s\t%-20s\t%-20s\t%-20s\t%-20s\t%-20s\n","adjustTargetInterval","SKILL LEVEL","PLAYER NUMBER","ORIGINAL DEVIATION","LINEAR INTERPOLATION","TARGET INTERVAL ENDPOINT"
	for(i in lint) {
		# running total of target interval endpoint plus (1 - linear interpolation)
		targ[i]=v+1-lint[i]
		v=targ[i]
		# "gawk -f test.awk | grep adjustTargetInterval" for tabulation of target intervals for each skill level
		if(DEBUG) printf "%s\t%-20s\t%d\t%20d\t%20.2f\t%20.2f\n","adjustTargetInterval",level,i,dev[i],lint[i],targ[i]		
	}
	if(DEBUG) print "adjustTargetInterval"
}


