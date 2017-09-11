getPlayoffData <- function(year) {
	stats <- NULL
	player<- NULL
	team <- NULL
	starterBench <- NULL
	i <- 1

	for(game_id in getPlayoffGameIDs(year)) {
		print(i)
		stats <- getBoxscoreTraditional(game_id)
		
		player <- rbind(player, stats$player)
		team <- rbind(team, stats$team)
		starterBench <- rbind(starterBench, stats$starterBench)

		i <- i+1
	}

	return(list(player,team,starterBench))
}

#need to remove game-id 0048300076