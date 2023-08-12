\name{match_total()}
\alias{match_total()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
match_total()
}
\description{
total score with added points must equal original total + 26
}
\usage{
match_total(orig,tot)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{orig}{
integer = total of 4 players' scores  	
}
  \item{tot}{
integer = 79 if moonflag == 1 \cr
= 26 if moonflag == 0  	
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns integer value = orig + tot
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
