get_stats <- function(p, name, year=2016) {
	y <- paste('2', substr(year,3,4), sep='')
	p <- p[p$player_name == name & substr(p$game_id,1,3) == y, ]

	stats <- NULL

	stats <- c(stats,
		unique(as.character(p$player_name)),
		year,
		mean(p$time[p$time != 0]),
		sum(p$fgm, na.rm=TRUE),
		sum(p$fga, na.rm=TRUE),
		sum(p$fgm, na.rm=TRUE) / sum(p$fga, na.rm=TRUE),
		sum(p$fg3m, na.rm=TRUE),
		sum(p$fg3a, na.rm=TRUE),
		sum(p$fg3m, na.rm=TRUE) / sum(p$fg3a, na.rm=TRUE),
		sum(p$ftm, na.rm=TRUE),
		sum(p$fta, na.rm=TRUE),
		sum(p$ftm, na.rm=TRUE) / sum(p$fta, na.rm=TRUE),
		mean(p$reb, na.rm=TRUE),
		mean(p$ast, na.rm=TRUE),
		mean(p$stl, na.rm=TRUE),
		mean(p$blk, na.rm=TRUE),
		mean(p$to, na.rm=TRUE),
		mean(p$pts, na.rm=TRUE))
	stats <- rbind(stats)
	stats <- as.data.frame(stats, stringsAsFactors=FALSE)
	for(i in 2:ncol(stats)) { stats[, i] <- as.numeric(stats[, i]) }

	colnames(stats) <- c(colnames(p)[6],'season',colnames(p)[c(8,11:25)])
	stats[1, 2:ncol(stats)] <- round(stats[1 , 2:ncol(stats)], digits=2)
	row.names(stats) <- NULL

	return(stats)
}