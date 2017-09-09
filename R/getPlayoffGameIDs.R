#data in season/team.rds must exist
getPlayoffGameIDs <- function(year) {
	season_string <- paste(year, '-', substr(year+1, 3, 4), sep='')

	year_game_id <- paste('004', substr(year,3,4), sep='')
	team <- readRDS('data/season/team.rds')
	team_ids <- unique(team$TEAM_ID[substr(team$GAME_ID,1,5) == year_game_id])

	game_ids <- NULL
	for(i in team_ids) {
		url <- paste('stats.nba.com/stats/teamgamelog/?TeamID=',i,'?Season=',season_string,'?SeasonType=Playoffs', sep='')

		###### Do stuff #####
	}

	return(game_ids)
}