# gawk -f prob.score.scatter.awk /Users/barryzeeberg/personal/hearts/score/score.testing.01.23.19/scenario.dir/scenario.03_08_2019_13_34_19_0_0.0500_1000_1_advanced_20_99_1_0.1000_0.4000_0.5000_0.6000.xls.nomoon.20.21.22.41.xls 1 0.15856 0.165524 0.245933 0.284047

# for a given original position, retrieve the subsequent points taken and probabilities from the scenario output file

# this allows analysis of the relationship between points taken and probabilities, to assess when to stop a moon

# this program was used to generate figure 5 in hearts manuscript

BEGIN{
	original_position=ARGV[2]
	ARGV[2]=""

	reference_probability1=ARGV[3] # optional reference probability to include in scatter plot file
	ARGV[3]=""
	reference_probability2=ARGV[4] # optional reference probability to include in scatter plot file
	ARGV[4]=""
	reference_probability3=ARGV[5] # optional reference probability to include in scatter plot file
	ARGV[5]=""
	reference_probability4=ARGV[6] # optional reference probability to include in scatter plot file
	ARGV[6]=""

	ofile=sprintf("%s.prob.score.scatter.%d.xls",ARGV[1],original_position)

	if(reference_probability1) print reference_probability1"\t",30,"\treference_probability1" > ofile
	if(reference_probability2) print reference_probability2"\t",30,"\treference_probability2" > ofile
	if(reference_probability3) print reference_probability3"\t",30,"\treference_probability3" > ofile
	if(reference_probability4) print reference_probability4"\t",30,"\treference_probability4" > ofile

}

{
	if($5==original_position) {

		print $0

		line_number=$1
		permuted_position=$4
		original_score=$(14+permuted_position)
		subsequent_score=$(10+permuted_position)
		original_probability=$(22+permuted_position)
		subsequent_probability=$(18+permuted_position)

		print "line_number=",line_number
		print "original_position=",original_position
		print "permuted_position=",permuted_position
		print "original_score=",original_score
		print "subsequent_score=",subsequent_score
		print "original_probability=",original_probability
		print "subsequent_probability=",subsequent_probability

		print subsequent_probability"\t"subsequent_score - original_score > ofile
	}
}