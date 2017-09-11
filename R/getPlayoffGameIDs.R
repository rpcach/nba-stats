#data in season/team.rds must exist
getPlayoffGameIDs <- function(year) {
	season_string <- paste(year, '-', substr(year+1, 3, 4), sep='')

	year_game_id <- paste('004', substr(year,3,4), sep='')
	team <- readRDS('data/season/team.rds')
	team_ids <- levels(team$TEAM_ID[substr(team$GAME_ID,1,5) == year_game_id])

	game_ids <- NULL	
	for(i in team_ids) {
		url <- paste('http://stats.nba.com/stats/teamgamelog/?TeamID=',i,'&Season=',season_string,'&SeasonType=Playoffs', sep='')
		print(url)
		json <- readLines(url)
		temp <- fromJSON(json)
		
		temp <- temp$resultSets
		temp <- temp[, 3]
		temp <- temp[[1]]
		if(is.null(dim(temp))) next
		temp <- temp[,2]

		game_ids <- c(game_ids, temp)
		Sys.sleep(2)
	}
	game_ids <- unique(game_ids)

	return(game_ids)
}