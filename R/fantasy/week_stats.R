week_stats <- function(stats, start, end=as.Date(start)+6) {
	x <- stats
	n <- x$games_played
	m <- sapply(x$player_name, num_games, p, schedule, start)

	x$games_played <- m

	x$fgm <- m * x$fgm / n
	x$fga <- m * x$fga / n

	x$fg3m <- m * x$fg3m / n
	x$fg3a <- m * x$fg3a / n

	x$ftm <- m * x$ftm / n
	x$fta <- m * x$fta / n

	x$reb <- m * x$reb
	x$ast <- m * x$ast
	x$blk <- m * x$blk
	x$stl <- m * x$stl
	x$to <- m * x$to
	x$pts <- m * x$pts

	x <- x[, colnames(x) != 'season']
	return(x)
}