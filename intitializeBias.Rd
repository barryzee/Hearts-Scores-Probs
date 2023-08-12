\name{intitializeBias()}
\alias{intitializeBias()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
intitializeBias()
}
\description{
call functions to generate skill levels and generate squash function
}
\usage{
intitializeBias(level,squash)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{level}{
character string "novice", "intermediate", "advanced", or "expert"  	
}
  \item{squash}{
2 D matrix with 9 rows and 2 columns \cr
column 1 contains a deviation from the mean (dev) value \cr
column 2 contains the corresponding squashed value of dev \cr
I tried to find a function to generate these points, but nothing had the right shape \cr
I tried retangular hyperbola and atan etc \cr
So I was forced to tabulate and then interpolate using the tabulated points  
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns no values, but has side effect of calling functions to generate skill levels and generate squash function
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
