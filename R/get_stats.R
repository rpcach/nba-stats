get_stats <- function(names, years='lifetime', mantissa=2) {
	if(years == 'lifetime') {
		years <- unique(substr(p$game_id[p$player_name %in% names],2,3))

		for(i in 1:length(years)) {
			if(years[i] > 83) {
				years[i] <- paste(19, years[i], sep='')
			} else {
				years[i] <- paste(20, years[i], sep='')
			}
		}
	}
	years <- sort(as.numeric(years))
	p <- p[p$player_name %in% names & p$year %in% as.numeric(substr(years,3,4)), ]

	stats <- matrix(0, ncol=19, nrow=0)

	for(i in names) {
		p2 <- p[p$player_name == i, ]
		
		for(j in 1:length(years)) {
			if(!(substr(years[j],3,4) %in% p2$year)) { 
				stats <- rbind(stats, c(i,years[j],0,0,0,0,NaN,0,0,NaN,0,0,NaN,0,0,0,0,0,0))
				next
			}
			p3 <- p2[p2$year == substr(years[j],3,4), ]

			stats <- rbind(stats, c(
				i,
				years[j],
				nrow(p3),
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

	colnames(stats) <- c(colnames(p)[8],'season','games_played',colnames(p)[c(10,13:27)])
	stats[, 4:ncol(stats)] <- round(stats[ , 4:ncol(stats)], digits=mantissa)

	return(stats)
}