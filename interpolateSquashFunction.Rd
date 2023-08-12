\name{interpolateSquashFunction()}
\alias{interpolateSquashFunction()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
interpolateSquashFunction()
}
\description{
search for the tabulated point that is closest above the data point
}
\usage{
interpolateSquashFunction(squash,n,v)
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
  \item{n}{
integer = length(squash)  	
}
  \item{v}{
numeric = a dev value to be mapped to squash function
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns the tabulated point that is closest above the data point
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
