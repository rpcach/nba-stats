get_league_stats <- function(home_url) {
	info <- strsplit(home_url,'=|&')[[1]]

	league <- NULL
	i <- 1
	while(i) {
		tryCatch({
			url <- paste('http://games.espn.com/fba/clubhouse?leagueId=',info[2],'&teamId=',i,'&seasonId=',info[4],sep='')
			temp <- roster_stats(url, team_name=TRUE)
			temp <- data.frame(temp[1, 1], getPerGameStats(temp[, 2:ncol(temp)]), stringsAsFactors=FALSE)
			colnames(temp)[1] <- 'team'

			league <- rbind(league, temp)
			print(i)
			i <- i + 1
		}, error=function(e) {
			i <<- 0
		})
	}

	return(league)
}