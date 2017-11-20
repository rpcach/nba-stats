library(jsonlite)
getBoxscoreTraditional <- function(game_id) {
	url <- paste('http://stats.nba.com/stats/boxscoretraditionalv2?GameID=', game_id, '&RangeType=0&StartPeriod=0&EndPeriod=0&StartRange=0&EndRange=0',sep='')
	json <- readLines(url)
	data <- fromJSON(json)
	data <- data[[3]]

	temp <- data[data$name == 'PlayerStats', ]
	PlayerStats <- temp$rowSet
	PlayerStats <- as.data.frame(PlayerStats)
	colnames(PlayerStats)<- unlist(temp$headers)

	temp <- data[data$name == 'TeamStats', ]
	TeamStats <- temp$rowSet
	TeamStats <- as.data.frame(TeamStats)
	colnames(TeamStats)<- unlist(temp$headers)

	temp <- data[data$name == 'TeamStarterBenchStats',]
	TeamStarterBenchStats <- temp$rowSet
	TeamStarterBenchStats <- as.data.frame(TeamStarterBenchStats)
	if(!nrow(TeamStarterBenchStats)) {
		TeamStarterBenchStats <- as.data.frame(matrix(nrow=0, ncol=25))
	}
	colnames(TeamStarterBenchStats)<- unlist(temp$headers)

	stats <- list(PlayerStats, TeamStats, TeamStarterBenchStats)
	names(stats) <- c('player', 'team', 'starterBench')

	return(stats)
}
