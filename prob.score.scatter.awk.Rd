\name{prob.score.scatter.awk}
\alias{prob.score.scatter.awk}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
prob.score.scatter.awk
}
\description{
for a given original position, retrieve the subsequent points taken and probabilities from the scenario output file \cr
this allows analysis of the relationship between points taken and probabilities, to assess when to stop a moon. \cr
prob.score.scatter.awk was used to retrieve the data from the scenario.awk output file to construct figure 5 in the manuscript.
}
\usage{
gawk -f prob.score.scatter.awk scenario.dir rp1 rp2 rp3 rp4
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{scenario.dir}{
character string containing the path name for the scenario directory  	
}
  \item{rpn}{
optional reference probability to include in scatter plot file  	
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns no values, but has side effect of generating an output file 
whose lines are of the form: \cr
subsequent_probability TAB subsequent_score - original_score
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Barry Zeeberg
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{}}

\code{\link{}}
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
