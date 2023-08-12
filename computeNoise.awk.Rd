\name{computeNoise.awk}
\alias{computeNoise.awk}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
computeNoise.awk
}
\description{
estimate the noise within the results of a winner.awk run
compare p vals that should theoretically be identical
}
\usage{
gawk -f computeNoise.awk xls odir
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{xls}{
output file for a winner.awk run  	
}
  \item{odir}{
character string containing the path name for the output directory  	
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns no value, but has side effect of estimating the noise within the results of a winner.awk run
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
