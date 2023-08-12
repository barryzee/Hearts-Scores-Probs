\name{BINCV()}
\alias{BINCV()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
BINCV()
}
\description{
compute mean and standard deviation of coefficients of variation that lie within a certain range
}
\usage{
BINCV(CVs,PROBs,BCVs,bmin,bmax)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{CVs}{
numeric array of coefficients of variation among probabilities that theoretically should be identical  	
}
  \item{PROBs}{
numeric array of prob values  	
}
  \item{BCVs}{
binned values of CVs [computed in BINCV()]  	
}
  \item{bmin}{
min value for current bin
}
  \item{bmax}{
max value for current bin  	
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns no values, but has side effect of populating the array BCVs
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
computeNoise.awk
\code{\link{}}
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
