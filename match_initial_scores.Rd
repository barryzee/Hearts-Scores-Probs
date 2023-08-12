\name{match_initial_scores()}
\alias{match_initial_scores()}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
match_initial_scores()
}
\description{
does the current line match the initial set of scores?
}
\usage{
match_initial_scores(score,p0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{score}{
integer array of scores for the 4 players  	
}
  \item{p0}{
numeric array of probabilities that match the 4 scores in array score  	
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
returns integer 1 if the current line matches the initial set of scores, 0 otherwise
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
