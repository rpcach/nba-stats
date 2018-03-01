getGameInfo <- function(game_id) {
	url <- paste('http://stats.nba.com/stats/boxscoresummaryv2?GameID=',game_id,sep='')
	json <- readLines(url)
	data <- fromJSON(json)
	data <- data$resultSets

	date <- as.Date(data[,3][[1]][1, 1])
	attendance <- data[[3]][[5]][1, 2]

	home_visitor <- data[[3]][[6]][1:2, 4]

	game <- as.data.frame(cbind(attendance, t(home_visitor)))
	game <- cbind(game_id, date, game)
	return(game)
}

# game <- NULL
# for(i in 1:length(x)) {
# 	print(length(x) - i + 1)
# 	game <- rbind(game, getGameInfo(x[i]))
# 	Sys.sleep(5)
# }
# #colnames(game)[4:5] <- c('home_id','visitor_id')