updateCurrentSeasonData <- function() {
	player <- readRDS('data/raw/player.rds')
	team <- readRDS('data/raw/team.rds')
	starterBench <- readRDS('data/raw/starter-bench.rds')

	p2 <- player[substr(player$GAME_ID,3,5) == 217, ]
	game_ids_to_skip <- unique(p2$GAME_ID)

	if(!length(game_ids_to_skip)) {
		game_ids_to_skip <- NULL
	}

	new_data <- getSeasonData(2017, game_ids_to_skip)

	saveRDS(rbind(new_data[[1]], player), 'data/raw/player.rds')
	saveRDS(rbind(new_data[[2]], team), 'data/raw/team.rds')
	saveRDS(rbind(new_data[[3]], starterBench), 'data/raw/starter-bench.rds')

	dataClean()
}