\name{targetRangeDriver()}
\alias{targetRangeDriver()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
targetRangeDriver()
}
\description{
co-ordinate procedures to map random number to target range \cr
compute mean and deviations from mean \cr
linear interpolation within Squash Function \cr
compute the biased end points of the biased target ranges
}
\usage{
targetRangeDriver(sc,squash,dev,level,targ)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sc}{
integer vector of the 4 players' scores  	
}
  \item{squash}{
2 D matrix with 9 rows and 2 columns \cr
column 1 contains a dev value \cr
column 2 contains the corresponding squashed value of dev \cr
I tried to find a function to generate these points, but nothing had the right shape \cr
I tried retangular hyperbola and atan etc \cr
So I was forced to tabulate and then interpolate using the tabulated points  	
}
  \item{dev}{
numeric vector of the deviation from the mean score for 4 players [computed in meanDev()]
}
  \item{level}{
character string "novice", "intermediate", "advanced", or "expert"  	
}
  \item{targ}{
vector of endpoints for the target intervals for the 4 players \cr
[computed in adjustTargetInterval()]
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns no values, but has side effects: \cr
compute mean and deviations from mean \cr
linear interpolation within Squash Function \cr
compute the biased end points of the biased target ranges
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
winner.awk
\code{\link{}}
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
