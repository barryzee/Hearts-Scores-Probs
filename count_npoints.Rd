\name{count_npoints()}
\alias{count_npoints()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
count_npoints()
}
\description{
how many players receive >= npoints?
}
\usage{
count_npoints(score,comp_op,npoints)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{score}{
integer array of the scores of the 4 players  	
}
  \item{comp_op}{
character string containing the name of a comparison operator such as "eq"  	
}
  \item{npoints}{
integer containing a number of points  	
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns an integer containing the number of players that received >= npoints
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
