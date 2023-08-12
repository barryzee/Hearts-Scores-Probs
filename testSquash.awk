#gawk -f testSquash.awk -v dev0=3 -v dev1=11 -v dev2=-5

	# generate interpolated values in squash tabe for 4 players' scores
	# not used in final version of gawk program
	# used for generating figure 2 in manuscript
	# and the unnumbered table just uunder figure 2

BEGIN {
	dev[0]=dev0
	dev[1]=dev1
	dev[2]=dev2
	dev[3]=-dev[0]-dev[1]-dev[2]
	for(i=1;i<ARGC;i++) delete ARGV[i]
	print "DEV: ",dev[0],dev[1],dev[2],dev[3]

	squash5=.10
	squash10=.40
	squash20=.50
	squash100=.60

	level="expert"

	intitializeBias(level,squash)


	for(i in dev) {
		lint[i]=interpolateSquashFunction(squash,length(squash),dev[i])
		print "LINT: ",i,dev[i],lint[i]
	}

	adjustTargetInterval(lint,targ,level,dev)

}

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

function interpolateSquashFunction(squash,n,v, i,li) {
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
	##printf "%s\t%-20s\t%-20s\t%-20s\t%-20s\t%-20s\n","adjustTargetInterval","SKILL LEVEL","PLAYER NUMBER","ORIGINAL DEVIATION","LINEAR INTERPOLATION","TARGET INTERVAL ENDPOINT"

	printf "%s\t%-10s\t%-10s\t%-10s\t%-10s\t%-10s\n","adjustTargetInterval","SKILL","PLAYER","ORIGINAL","    LINEAR","TARGET INTERVAL"

	printf "%s\t%-10s\t%-10s\t%-10s\t%-10s\t%-10s\n","adjustTargetInterval","LEVEL","NUMBER","DEVIATION","INTERPOLATION","   ENDPOINT"

	for(i in lint) {
		# running total of target interval endpoint plus (1 - linear interpolation)
		targ[i]=v+1-lint[i]
		v=targ[i]
		# "gawk -f test.awk | grep adjustTargetInterval" for tabulation of target intervals for each skill level
		##printf "%s\t%-20s\t%d\t%20d\t%20.2f\t%20.2f\n","adjustTargetInterval",level,i,dev[i],lint[i],targ[i]
		printf "%s\t%-15s\t%d\t%13d\t%17.2f\t%9.2f\n","adjustTargetInterval",level,i,dev[i],lint[i],targ[i]		
	}
	if(DEBUG) print "adjustTargetInterval"
}
