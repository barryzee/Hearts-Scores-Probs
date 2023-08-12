\name{FCV()}
\alias{FCV()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
FCV()
}
\description{
compute mean and standard deviation of coefficients of variation
}
\usage{
FCV(CVs,stats)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{CVs}{
numeric array of coefficients of variation among probabilities that theoretically should be identical 	
}
  \item{stats}{
numeric array containing mean and std for CVs [computed in FCV()]  	
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns no values, but has sude effect of computing mean and standard deviation of coefficients of variation
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
