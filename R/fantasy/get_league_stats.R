get_league_stats <- function(home_url, save=FALSE) {
	info <- strsplit(home_url,'=|&')[[1]]

	league <- NULL
	i <- 1
	while(i) {
		tryCatch({
			url <- paste('http://games.espn.com/fba/clubhouse?leagueId=',info[2],'&teamId=',i,'&seasonId=',info[4],sep='')
			temp <- roster_stats(url, team_name=TRUE)
			num_players <- ifelse(nrow(temp) < 13, nrow(temp), 13)
			temp <- temp[1:num_players, ]
			temp <- data.frame(temp[1, 1], getPerGameStats(temp[, 2:ncol(temp)]), stringsAsFactors=FALSE)
			colnames(temp)[1] <- 'team'

			league <- rbind(league, temp)
			print(i)
			i <- i + 1
		}, error=function(e) {
			i <<- 0
		})
	}
	#row.names(league) <- c('maga','yao','woll','mean','box','ven','chun','jz','nan','moha','yeun','math')
	if(save) {
		webpage <- home_url %>% read_html()
		league_name <- as.character(webpage %>% html_nodes("title"))
		league_name <- strsplit(league_name, '<title>| League Office')[[1]][2]
		
		file_name <- paste(league_name,' ',gsub(':','-',Sys.time()),'.xlsx',sep='')
		file.copy('league_template.xlsx',file_name)
		library(XLConnect)
		writeWorksheetToFile(file_name, league, "league", styleAction=XLC$STYLE_ACTION.NONE)

	}

	return(league)
}