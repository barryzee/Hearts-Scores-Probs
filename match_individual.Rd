\name{match_individual()}
\alias{match_individual()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
match_individual()
}
\description{
how many players receive exactly 26 points?
}
\usage{
match_individual(score,p0,perm,meta,vals)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{score}{
integer array of the scores of the 4 players  	
}
  \item{p0}{
numeric array of probabilities that match the 4 scores in array score, computed by match_initial_scores()
}
  \item{perm}{
integer permutation matrix to allow looping through all combinations of orders of 4 scores  	
}
  \item{meta}{
does not seem to be used in current implementation  	
}
  \item{vals}{
integer matrix of each row of which contains the 4 players' scores  	
}
}
\details{
Details about the permutation matrix are given in the manuscript
}
\value{
returns integer = length(vals)
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
scenario.awk
\code{\link{}}
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
