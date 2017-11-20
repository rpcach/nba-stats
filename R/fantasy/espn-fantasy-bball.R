library(rvest)

roster_stats <- function(url, year=2017) {

	roster <- url %>% read_html() %>% html_nodes(xpath='//*[@id="playertable_0"]') %>% html_table()
	roster <- roster[[1]]
	roster <- roster[, 2]

	roster <- roster[-(which(roster %in% c('STARTERS','PLAYER, TEAM POS','','BENCH')))]

	roster <- gsub(',.*$', '', roster)
	roster <- gsub('[*]', '', roster)

	stats <- get_stats(roster, year)
}
