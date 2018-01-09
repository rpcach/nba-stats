library(rvest)

roster_stats <- function(url, year=2017, team_name=FALSE) {

	webpage <- url %>% read_html()
	roster <- webpage %>% html_nodes(xpath='//*[@id="playertable_0"]') %>% html_table()
	roster <- roster[[1]]
	roster <- roster[, 2]

	roster <- roster[-(which(roster %in% c('STARTERS','PLAYER, TEAM POS','','BENCH')))]

	roster <- gsub(',.*$', '', roster)
	roster <- gsub('[*]', '', roster)

	stats <- get_stats(roster, year)

	if(team_name) {
		team_name <- url %>% read_html() %>% html_nodes(xpath='//*[@id="content"]/div/div[4]/div/div/div[3]/div[1]/div[2]/div[1]/h3/text()')
		team_name <- as.character(team_name)
		team_name <- gsub(' $', '', team_name)
		stats <- cbind(team_name, stats, stringsAsFactors=FALSE)
		colnames(stats)[1] <- 'team'
	}

	return(stats)
}