\name{rand2target()}
\alias{rand2target()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
rand2target()
}
\description{
map the rand number to 1 of 4 target ranges
ranges indexed as 0,1,2,3
}
\usage{
rand2target(sc,squash,dev,level,targ)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sc}{
  	
}
  \item{squash}{
2 D matrix with 9 rows and 2 columns \cr
column 1 contains a dev value \cr
column 2 contains the corresponding squashed value of dev \cr
I tried to find a function to generate these points, but nothing had the right shape \cr
I tried rectangular hyperbola and atan etc \cr
So I was forced to tabulate and then interpolate using the tabulated points  	
}
  \item{dev}{
parameter passed to targetRangeDriver()  	
}
  \item{level}{
character string "novice", "intermediate", "advanced", or "expert"  	
}
  \item{targ}{
parameter passed to targetRangeDriver()  	
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns integer index of the target range that rand mapped to
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
