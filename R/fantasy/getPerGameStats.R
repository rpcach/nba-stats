getPerGameStats <- function(stats) {
	s <- stats[stats$games_played > 0, ]
	s$fgm <- s$fgm / s$games_played
	s$fga <- s$fga / s$games_played

	s$ftm <- s$ftm / s$games_played
	s$fta <- s$fta / s$games_played

	s$fg3m <- s$fg3m / s$games_played
	s$fg3a <- s$fg3a / s$games_played

	totals <- cbind(sum(s$fgm),
					sum(s$fga),
					sum(s$fgm) / sum(s$fga),
					sum(s$ftm),
					sum(s$fta),
					sum(s$ftm) / sum(s$fta),
					sum(s$fg3m),
					sum(s$fg3a),
					sum(s$fg3m) / sum(s$fg3a),
					sum(s$reb),
					sum(s$ast),
					sum(s$stl),
					sum(s$blk),
					sum(s$to),
					sum(s$pts))

	colnames(totals)<- c('fgm',
						'fga',
						'fg_pct',
						'ftm',
						'fta',
						'ft_pct',
						'fg3m',
						'fg3a',
						'fg3_pct',
						'reb',
						'ast',
						'stl',
						'blk',
						'to',
						'pts')
	return(totals)
}