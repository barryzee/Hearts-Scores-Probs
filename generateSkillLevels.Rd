\name{generateSkillLevels()}
\alias{generateSkillLevels()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
generateSkillLevels()
}
\description{
assign bias weight depending on general level of players \cr
ie, novice will not try to hit low whatsoever \cr
ie, expert try to hit low as often as possible AND as effectively as possible \cr
these values are based on intuition,  \cr and they can be adjusted manually after examining tabulation generated in adjustTargetInterval()
}
\usage{
generateSkillLevels(skill)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{skill}{
vector of bias weight that depend on general level of players \cr
these go into determining the endpoints of the target intervals \cr

skill["novice"]=0.00 \cr
skill["intermediate"]=0.25 \cr
skill["advanced"]=0.50 \cr
skill["expert"]=1.00 \cr
}
}
\details{
more details are given in the manual entry for winner.awk
}
\value{
returns the matrix skill
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
