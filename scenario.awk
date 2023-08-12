## scenario.awk ##

# given a current score and 26 points to be added to the score,
# how are those points best distributed to optimize the chance
# of winning?

# this program computes the more general solution
# provides the p-vals for all scenarios for all players
# generates a histogram of p vals for each player

# 4 scores must be given in ascending order

# odir must already exist

# gawk -f scenario.06.15.19.awk /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/results/03_08_2019_13_34_19_0_0.0500_1000_1_advanced_20_99_1_0.1000_0.4000_0.5000_0.6000.xls /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/scenario.dir 20 21 22 41 0

# gawk -f scenario.06.15.19.awk /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/results/03_08_2019_13_34_19_0_0.0500_1000_1_advanced_20_99_1_0.1000_0.4000_0.5000_0.6000.xls /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/scenario.dir 20 21 22 41 1

BEGIN {
perm[1][1][1]=1
perm[1][1][2]=2
perm[1][1][3]=3
perm[1][1][4]=4

perm[1][2][1]=1
perm[1][2][2]=2
perm[1][2][3]=4
perm[1][2][4]=3

perm[1][3][1]=1
perm[1][3][2]=3
perm[1][3][3]=2
perm[1][3][4]=4

perm[1][4][1]=1
perm[1][4][2]=3
perm[1][4][3]=4
perm[1][4][4]=2

perm[1][5][1]=1
perm[1][5][2]=4
perm[1][5][3]=2
perm[1][5][4]=3

perm[1][6][1]=1
perm[1][6][2]=4
perm[1][6][3]=3
perm[1][6][4]=2

perm[2][1][1]=2
perm[2][1][2]=1
perm[2][1][3]=3
perm[2][1][4]=4

perm[2][2][1]=2
perm[2][2][2]=1
perm[2][2][3]=4
perm[2][2][4]=3

perm[2][3][1]=2
perm[2][3][2]=3
perm[2][3][3]=4
perm[2][3][4]=1

perm[2][4][1]=2
perm[2][4][2]=3
perm[2][4][3]=1
perm[2][4][4]=4

perm[2][5][1]=2
perm[2][5][2]=4
perm[2][5][3]=1
perm[2][5][4]=3

perm[2][6][1]=2
perm[2][6][2]=4
perm[2][6][3]=3
perm[2][6][4]=1


perm[3][1][1]=3
perm[3][1][2]=1
perm[3][1][3]=2
perm[3][1][4]=4

perm[3][2][1]=3
perm[3][2][2]=1
perm[3][2][3]=4
perm[3][2][4]=2

perm[3][3][1]=3
perm[3][3][2]=2
perm[3][3][3]=1
perm[3][3][4]=4

perm[3][4][1]=3
perm[3][4][2]=2
perm[3][4][3]=4
perm[3][4][4]=1

perm[3][5][1]=3
perm[3][5][2]=4
perm[3][5][3]=1
perm[3][5][4]=2

perm[3][6][1]=3
perm[3][6][2]=4
perm[3][6][3]=2
perm[3][6][4]=1



perm[4][1][1]=4
perm[4][1][2]=1
perm[4][1][3]=2
perm[4][1][4]=3

perm[4][2][1]=4
perm[4][2][2]=1
perm[4][2][3]=3
perm[4][2][4]=2

perm[4][3][1]=4
perm[4][3][2]=2
perm[4][3][3]=1
perm[4][3][4]=4

perm[4][4][1]=4
perm[4][4][2]=2
perm[4][4][3]=4
perm[4][4][4]=1

perm[4][5][1]=4
perm[4][5][2]=3
perm[4][5][3]=1
perm[4][5][4]=2

perm[4][6][1]=4
perm[4][6][2]=3
perm[4][6][3]=2
perm[4][6][4]=1

    idx = split(ARGV[1], parts, "/")
    fname=parts[idx]

    odir=ARGV[2]
    ARGV[2]=""

    for(i=3;i<=6;i++) {
		score[i-2]=ARGV[i]
		ARGV[i]=""
		tot+=score[i-2]
		}

	moonflag=ARGV[7]
	ARGV[7]=""

	if(tot%26) {
		print "ERROR: total score not a multiple of 26",tot
 		exit -1
        }

	label=moonflag?"moon":"nomoon"
    ofile=sprintf("%s/scenario.%s.%s.%s.%s.%s.%s.xls",odir,fname,label,score[1],score[2],score[3],score[4])
    print "OFILE:",ofile

    ofile_p1=sprintf("%s/scenario.%s.%s.%s.%s.%s.%s.p1.xls",odir,fname,label,score[1],score[2],score[3],score[4])
    ofile_p2=sprintf("%s/scenario.%s.%s.%s.%s.%s.%s.p2.xls",odir,fname,label,score[1],score[2],score[3],score[4])
    ofile_p3=sprintf("%s/scenario.%s.%s.%s.%s.%s.%s.p3.xls",odir,fname,label,score[1],score[2],score[3],score[4])
    ofile_p4=sprintf("%s/scenario.%s.%s.%s.%s.%s.%s.p4.xls",odir,fname,label,score[1],score[2],score[3],score[4])
}
{	
    if(!MIS) { # looking for the unique line that matches the input scores
        # does the current line match the initial set of scores?
        MIS=match_initial_scores(score,p0)
    if(MIS)print NR"\t"$0"\n" > ofile
    }

    else { # looking for the many lines that match various combinations of added points

        if(moonflag){ # moon
            # total score with added points must equal original total + 78
            if(!match_total(tot,78))
                next

            # exactly three players must have 26 points
            if(count_26(score)!=3)
                next
            print NR"\t"$0 > ofile
            }

        else { # no moon
            # total score with added points must equal original total + 26
            if(!match_total(tot,26))
                next

            # exactly zero players must have 26 points
            if(count_26(score))
                next

            # each player score must be >= original score
            # one player must get at least 13 points
            # it is possibe but not likely that one player will get QS and another player will get all hearts, so getting 13 points does not uniquely identify the recipient of QS 100% of the time
            nvals=match_individual(score,p0,perm,meta,vals)
        }
    }
}

END {

}

function match_initial_scores(score,p0, i) {
    # does the current line match the initial set of scores?
    if($1==score[1] && $2==score[2] && $3==score[3] && $4==score[4]) {
        for(i=1;i<=4;i++)
            p0[i]=$(4+i)
        return 1
        }
    return 0
}

function match_total(orig,tot, t,i) {
    # total score with added points must equal original total + tot
    t=0
    for(i=1;i<=4;i++)
        t+=$i

#print "match_total",t,"orig",orig,"o+m",orig+tot,"==",t==orig+tot
#if(t==orig+tot) print "match_total",NR,$0

    return t==orig+tot
}

function match_individual(score,p0,perm,meta,vals, x,y,i,found) {
    # individual scores with added points must be >= original scores
    for(x=1;x<=4;x++)
        for(y=1;y<=6;y++) {
            found=0
            if($1>=score[perm[x][y][1]] && $2>=score[perm[x][y][2]] && $3>=score[perm[x][y][3]] && $4>=score[perm[x][y][4]])
                {
                # player designated as mooner must get at least 13 points
                if($1>=score[perm[x][y][1]]+13) {
                    meta[NR][x][y][1]=perm[x][y][1]
                    found=1
                    }
                if($2>=score[perm[x][y][2]]+13) {
                    meta[NR][x][y][2]=perm[x][y][2]
                    found=2
                    }
                if($3>=score[perm[x][y][3]]+13) {
                    meta[NR][x][y][3]=perm[x][y][3]
                    found=3
                    }
                if($4>=score[perm[x][y][4]]+13) {
                    meta[NR][x][y][4]=perm[x][y][4]
                    found=4
                    }

                if(found) {
                    valsNR[NR]=NR
                    for(i=1;i<=4;i++)
                        vals[NR,i]=score[perm[x][y][i]]
                    # perm[x][y][found] (column 5/E in ofile) is the original position of the player who got >= 13 points
                    # found (column 4/D in ofile) is the permuted position of the player who got >= 13 points
                    print NR"\t"x"\t"y"\t"found"\t"perm[x][y][found]"\t"length(vals)"\t""\t"perm[x][y][1]"\t"perm[x][y][2]"\t"perm[x][y][3]"\t"perm[x][y][4]"\t""\t"$1"\t"$2"\t"$3"\t"$4"\t""\t"score[perm[x][y][1]]"\t"score[perm[x][y][2]]"\t"score[perm[x][y][3]]"\t"score[perm[x][y][4]]"\t""\t"$5"\t"$6"\t"$7"\t"$8"\t""\t"p0[perm[x][y][1]]"\t"p0[perm[x][y][2]]"\t"p0[perm[x][y][3]]"\t"p0[perm[x][y][4]] > ofile
					# grab the subsequent p values for the original player 1 in the instances where
					#    original player 1 score increases by at least 13 (ie, original player 1 took QS). 
                    if(perm[x][y][found] == 1) print NR"\t"$(4+found) > ofile_p1
                    if(perm[x][y][found] == 2) print NR"\t"$(4+found) > ofile_p2
                    if(perm[x][y][found] == 3) print NR"\t"$(4+found) > ofile_p3
                    if(perm[x][y][found] == 4) print NR"\t"$(4+found) > ofile_p4
                    }
                }
            }
    return length(vals)
}

function count_26(score, i,j,n) {
    # how many players receive exactly 26 points?
    for(i=1;i<=4;i++)
        unused[i]=i
    n=0
    for(i=1;i<=4;i++)
        for(j in unused)
            if($i-score[j]==26) {
                n++
                delete unused[j]
                #print "count_26",NR,i,$i,j,score[j],$i-score[j]==26,n
                break
                }

    return n
}


function count_npoints(score,comp_op,npoints, i,j,n) {
    # how many players receive >= npoints?
    n=0
    for(i=1;i<=4;i++) {
        if(comp_op=="eq") {
            if($i-score[i]==npoints)n++
            #print i,$i,score[i],$i-score[i]==npoints,n
            }
        else
            if($i-score[i]>=npoints)n++
    }

    # print "N",comp_op,n

    return n
}
