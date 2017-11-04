get_stats <- function(p, names, years='lifetime', mantissa=2, hide_null=TRUE) {
	if(years == 'lifetime') {
		years <- unique(substr(p$game_id[p$player_name %in% names],2,3))

		for(i in 1:length(years)) {
			if(years[i] > 83) {
				years[i] <- paste(19, years[i], sep='')
			} else {
				years[i] <- paste(20, years[i], sep='')
			}
		}
		years <- sort(as.numeric(years))
	}
	p <- p[p$player_name %in% names & substr(p$game_id,2,3) %in% substr(years,3,4), ]

	stats <- matrix(0, ncol=18, nrow=0)

	for(i in names) {
		if(hide_null & !(i %in% p$player_name)) { next }
		p2 <- p[p$player_name == i, ]
		for(j in 1:length(years)) {
			if(!hide_null & !(substr(years[j],3,4) %in% substr(p2$game_id,2,3))) { 
				stats <- rbind(stats, c(i,years[j],0,0,0,NaN,0,0,NaN,0,0,NaN,0,0,0,0,0,0))
				next
			}
			p3 <- p2[substr(p2$game_id,2,3) == substr(years[j],3,4), ]

			stats <- rbind(stats, c(
				i,
				years[j],
				mean(p3$time[p3$time != 0]),
				sum(p3$fgm, na.rm=TRUE),
				sum(p3$fga, na.rm=TRUE),
				sum(p3$fgm, na.rm=TRUE) / sum(p3$fga, na.rm=TRUE),
				sum(p3$fg3m, na.rm=TRUE),
				sum(p3$fg3a, na.rm=TRUE),
				sum(p3$fg3m, na.rm=TRUE) / sum(p3$fg3a, na.rm=TRUE),
				sum(p3$ftm, na.rm=TRUE),
				sum(p3$fta, na.rm=TRUE),
				sum(p3$ftm, na.rm=TRUE) / sum(p3$fta, na.rm=TRUE),
				mean(p3$reb, na.rm=TRUE),
				mean(p3$ast, na.rm=TRUE),
				mean(p3$stl, na.rm=TRUE),
				mean(p3$blk, na.rm=TRUE),
				mean(p3$to, na.rm=TRUE),
				mean(p3$pts, na.rm=TRUE)))
		}
	}
	stats <- as.data.frame(stats, stringsAsFactors=FALSE)
	for(i in 2:ncol(stats)) { stats[, i] <- as.numeric(stats[, i]) }

	colnames(stats) <- c(colnames(p)[6],'season',colnames(p)[c(8,11:25)])
	stats[, 2:ncol(stats)] <- round(stats[ , 2:ncol(stats)], digits=mantissa)

	return(stats)
}