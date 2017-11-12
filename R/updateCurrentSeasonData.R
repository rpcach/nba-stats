updateCurrentSeasonData <- function() {
	player <- readRDS('data/raw/player.rds')

	player <- player[substr(player$GAME_ID,3,5) == 217, ]
	game_ids_to_skip <- unique(player$GAME_ID)

	if(!length(game_ids_to_skip)) {
		game_ids_to_skip <- NULL
	}
	
	return(getSeasonData(2017, player$GAME_ID))
}