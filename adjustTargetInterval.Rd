\name{adjustTargetInterval()}
\alias{adjustTargetInterval()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
adjustTargetInterval()
}
\description{
compute the endpoints of the target intervals
}
\usage{
adjustTargetInterval(lint,targ,level,dev)}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{lint}{
numeric vector returned by interpolateSquashFunction()  	
}
  \item{targ}{
vector of endpoints for the target intervals for the 4 players  	
}
  \item{level}{
character string "novice", "intermediate", "advanced", or "expert"  	
}
  \item{dev}{
parameter passed to targetRangeDriver()  	
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns no values, but has side effect of computing the endpoints of the target intervals
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
