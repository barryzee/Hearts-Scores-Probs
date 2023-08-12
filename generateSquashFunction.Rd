\name{generateSquashFunction()}
\alias{generateSquashFunction()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
generateSquashFunction()
}
\description{
the numerical values in squash were subjectively determined
by exhaustive trial and error
in order to result in the behavior that I think is reasonable}
\usage{
generateSquashFunction(squash,maxv)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{squash}{
2 D matrix with 9 rows and 2 columns \cr
column 1 contains a dev value \cr
column 2 contains the corresponding squashed value of dev \cr
I tried to find a function to generate these points, but nothing had the right shape \cr
I tried retangular hyperbola and atan etc \cr
So I was forced to tabulate and then interpolate using the tabulated points \cr
}
  \item{maxv}{
integer equal to skill[level] (see man page for winner.awk)  	
}
  \item{squashn}{
squash5, squash10, squash20, squash 100 are manually-selected values that give the squash table the correct shape
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns no values, but has side effect of generating the squash matrix
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
winner.ask
\code{\link{}}
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
