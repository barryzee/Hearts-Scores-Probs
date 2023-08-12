\name{winner.awk}
\alias{winner.awk}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
winner.awk
}
\description{
Given each player's score, compute each player's probability of winning
}
\usage{
gawk -f winner.awk ODIR="odir" DEBUG=0
squash5=0.10 squash10=0.40 squash20=0.50 squash100=0.60
Pmoon=0.05 N=1000 BIAS=1 level="intermediate" initial=20 final=99 del=1
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ODIR}{
character string containing the path name for the output directory
}
  \item{DEBUG}{
Boolean if 1 then debug info is printed, typically set to 0
}
  \item{squashn}{
2 D matrix with 9 rows and 2 columns \cr
column 1 contains a dev value \cr
column 2 contains the corresponding squashed value of dev \cr
I tried to find a function to generate these points, but nothing had the right shape \cr
I tried retangular hyperbola and atan etc \cr
So I was forced to tabulate and then interpolate using the tabulated points \cr

squash5, squash10, squash20, squash 100 are manually-selected values that give the squash table the correct shape
}
  \item{Pmoon}{
a priori probability that a player will shoot the moon, typically 0.05
}
  \item{N}{
number of simulations, typically 1000
}
  \item{BIAS}{
Boolean if 1, functions apply bias depending on general skill level \cr

bias is implemented by altering the target interval length for mapping randoms. \cr
with no bias, all 4 intervals are of length 1
}
  \item{level}{
general level of experience of the 4 players: \cr
"novice", "intermediate", "advanced", or "expert"
}
  \item{initial}{
initial value for the score of the first player, typically 20
}
  \item{final}{
initial value for the score of the first player, typically 99
}
  \item{del}{
increment for the score of the first player, typically 1
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns a character string containing the pathname of the output file, \cr
and a character string containing the name of the program source directory
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
