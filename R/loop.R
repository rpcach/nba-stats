loop <- function(year) {
	year <- substring(year,3,4)
	error_count <- 0
	stats <- NULL
	player<- NULL
	team <- NULL
	starterBench <- NULL

	i <- 0
	while(error_count < 10) {
		i <- i + 1
		game_num <- rep("0", 5-nchar(i))
		game_id <- c("002", year, game_num, i)
		game_id <- paste(game_id,collapse='')
		print(i)
		tryCatch(
		{
			stats <- getBoxscoreTraditional(game_id)
			player <- rbind(player, stats$player)
			team <- rbind(team, stats$team)
			starterBench <- rbind(starterBench, stats$starterBench)
		},
		error=function(e) {
			Sys.sleep(1)
			error_count <<- error_count + 1
		}
		)
	}
	
}