get_stats <- function(p, name, years='lifetime', mantissa=2) {
	if(years == 'lifetime') {
		years <- unique(substr(p$game_id[p$player_name == name],2,3))

		for(i in 1:length(years)) {
			if(years[i] > 83) {
				years[i] <- paste(19, years[i], sep='')
			} else {
				years[i] <- paste(20, years[i], sep='')
			}
		}
		years <- sort(as.numeric(years))
	}
	p <- p[p$player_name == name & substr(p$game_id,2,3) %in% substr(years,3,4), ]

	stats <- matrix(0, ncol=19, nrow=0)

	for(j in 1:length(years)) {
		if(!hide_null & !(substr(years[j],3,4) %in% substr(p$game_id,2,3))) { 
			stats <- rbind(stats, c(i,years[j],0,0,0,NaN,0,0,NaN,0,0,NaN,0,0,0,0,0,0))
			next
		}
		p2 <- p[substr(p$game_id,2,3) == substr(years[j],3,4), ]

		stats <- rbind(stats, c(
			name,
			years[j],
			nrow(p2),
			mean(p2$time[p2$time != 0]),
			sum(p2$fgm, na.rm=TRUE),
			sum(p2$fga, na.rm=TRUE),
			sum(p2$fgm, na.rm=TRUE) / sum(p2$fga, na.rm=TRUE),
			sum(p2$fg3m, na.rm=TRUE),
			sum(p2$fg3a, na.rm=TRUE),
			sum(p2$fg3m, na.rm=TRUE) / sum(p2$fg3a, na.rm=TRUE),
			sum(p2$ftm, na.rm=TRUE),
			sum(p2$fta, na.rm=TRUE),
			sum(p2$ftm, na.rm=TRUE) / sum(p2$fta, na.rm=TRUE),
			mean(p2$reb, na.rm=TRUE),
			mean(p2$ast, na.rm=TRUE),
			mean(p2$stl, na.rm=TRUE),
			mean(p2$blk, na.rm=TRUE),
			mean(p2$to, na.rm=TRUE),
			mean(p2$pts, na.rm=TRUE)))
	}

	stats <- as.data.frame(stats, stringsAsFactors=FALSE)
	for(i in 2:ncol(stats)) { stats[, i] <- as.numeric(stats[, i]) }

	colnames(stats) <- c(colnames(p)[6],'season','games_played',colnames(p)[c(8,11:25)])
	stats[, 4:ncol(stats)] <- round(stats[ , 4:ncol(stats)], digits=mantissa)

	return(stats)
}