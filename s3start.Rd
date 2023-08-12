\name{s3start}
\alias{s3start}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
s3start
}
\description{
s3start is selected so that the sum s0 + s1 + s2 + s3 is a valid score, ie a multiple of 26
}
\usage{
s3start(s,initial,final)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{s}{
integer vector of length 4 \cr
s[0] = loop index for score of player 0, usually runs from 20 to 99 \cr
s[1] = loop index for score of player 1, usually runs from 20 to 99 \cr
s[2] = loop index for score of player 2, usually runs from 20 to 99 \cr
s[3] = loop index for score of player 3, \cr
selected so that the sum s0 + s1 + s2 + s3 is a valid score, ie a multiple of 26  	
}
  \item{initial}{
initial value for loop indices s[0], s[1], s[2], usually runs from 20 to 99 	
}
  \item{final}{
obsoleted, no longer used  	
}
}
\details{
max value for sum + initial = s[0] + s[1] + s[2] + 100 = 99 + 99 + 99 + 100 = 297 + 100 = 397}
\value{
returns an integer value to be used as the initial value for the loop index for player 3 \cr
selected so that the sum s0 + s1 + s2 + s3 is a valid score, ie a multiple of 26
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
