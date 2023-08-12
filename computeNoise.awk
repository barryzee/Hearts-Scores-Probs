## computeNoise.awk ##

# 02.06.19 improve formatting of output
# add std and std/mean to output
# add column headers to output
# 06.28.19 add ofile

# estimate the noise within the results of a winner.awk run
# compare p vals that should theoretically be identical

# output directory must pre-exist

# gawk -f computeNoise.awk /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/for_noise_computation/xls/06_27_2019_10_58_58_0_0.0500_100_0_novice_40_60_1_0.1000_0.4000_0.5000_0.6000.xls /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/noise.dir

# gawk -f computeNoise.awk /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/for_noise_computation/xls/06_28_2019_00_34_19_0_0.0500_100000_0_novice_40_60_1_0.1000_0.4000_0.5000_0.6000.xls /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/noise.dir

# gawk -f computeNoise.awk  /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/for_noise_computation/xls/06_27_2019_11_00_06_0_0.0500_1000_0_novice_40_60_1_0.1000_0.4000_0.5000_0.6000.xls  /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/noise.dir


BEGIN{
	idx = split(ARGV[1], parts, "/")
    fname=parts[idx]

	odir=ARGV[2]
    ARGV[2]=""

	ofile=sprintf("%s/noise.%s",odir,fname)
	ofile2=sprintf("%s/noise.archive.xls",odir)
    print "OFILE:",ofile

	print "Row Number in winner.awk Output File\tScore\tNumber of Duplicate Scores\tMean Probability\tVariance\tCoefficient of Variation\t" > ofile
	nCVs=0
}

{
	# first look for occurrences of identical vals
	delete nscores
	for(c=1;c<=4;c++)
		nscores[$c]++
	for(s in nscores) print NR,s,nscores[s]
	for(s in nscores)
		if(nscores[s]>1) {
			probs=0
			print "FOUND",s,nscores[s]
			for(c=1;c<=4;c++) # compute mean of probs
				if($c==s) {
					probs+=$(c+4)
					print "PROBS",NR,s,c,$c,$(c+4),probs
				} # if($c==s)
			probs/=nscores[s]
        	if(probs) { # avoid division by zero
				var=0
				for(c=1;c<=4;c++) # compute variance of probs
					if($c==s) {
						var+=(probs-$(c+4))^2
						print "VAR",NR,c,var
					} # if($c==s)
				var/=(nscores[s]-1)
				CV=sqrt(var)/probs
				CVs[++nCVs]=CV
				PROBs[nCVs]=probs
				print "MEAN PROB", NR,s,probs,var,CV
				print "CVS",nCVs,CVs[nCVs]
				print NR"\t",s,"\t",nscores[s],"\t",probs,"\t",var,"\t",CV > ofile
			} # if(probs) 
		} # if(nscores[s]>1)
}

END {
	# compute mean and standard deviation of coefficients of variation
	print "fname",fname
	split(fname,parts,"_")
	NSIM=parts[9]
	FCV(CVs,stats)
	print "END",stats["mean"],stats["std"]
	print "\n\t\t\t\t\t\t\t\t\t\tSTATS\tnsim\tCV mean\tCV std" > ofile
	print "\t\t\t\t\t\t\t\t\t\tSTATS\t"NSIM"\t"stats["mean"]"\t"stats["std"] > ofile

	del=0.1
	print "\n\t\t\t\t\t\t\t\t\t\tSTATS\tnPROBS\tbmin\tbmax\tCV mean\tCV std\tCV min\tCV max" > ofile
	for(i=0;i<=9;i++) {
		bmin=del*i
		bmax=bmin+del
		BINCV(CVs,PROBs,BCVs,bmin,bmax)
        if(length(BCVs)) {
		    FCV(BCVs,stats)
		    print "\t\t\t\t\t\t\t\t\t\tSTATS\t"length(BCVs)"\t"bmin"\t"bmax"\t"stats["mean"]"\t"stats["std"]"\t"stats["min"]"\t"stats["max"] > ofile # archive summary stats for CV bins
			print strftime("%m_%d_%Y_%H_%M_%S", systime())"\t"fname"\t"length(BCVs)"\t"bmin"\t"bmax"\t"stats["mean"]"\t"stats["std"]"\t"stats["min"]"\t"stats["max"] >> ofile2
            }
        } #for(i=0;i<=9;i++)
	print "\n" >> ofile2
}

function FCV(CVs,stats ,mean,std,var,i) {
	# compute mean and standard deviation of coefficients of variation

    if(length(CVs)<=1)
        return

    delete stats

	stats["min"]=1000000
	stats["max"]=-1000000

	for(i in CVs) {
		mean+=CVs[i]
		if(CVs[i]<stats["min"])
			stats["min"]=CVs[i]
		if(CVs[i]>stats["max"])
			stats["max"]=CVs[i]
		}

	mean/=length(CVs)

	for(i in CVs)
		var+=(CVs[i]-mean)^2
	var/=(length(CVs)-1)
	std=sqrt(var)

	stats["mean"]=mean
	stats["std"]=std

	return
}

function BINCV(CVs,PROBs,BCVs,bmin,bmax, i) {
	# compute mean and standard deviation of coefficients of variation that lie within a certain range
	delete BCVs
	for(i in CVs)
		if(PROBs[i]>=bmin && PROBs[i]<=bmax)
			BCVs[i]=CVs[i]

	return
}
			






