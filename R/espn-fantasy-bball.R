library(rvest)

url <- ''

roster <- url %>% read_html() %>% html_nodes(xpath='//*[@id="playertable_0"]') %>% html_table()
roster <- roster[[1]]
roster <- roster[, 2]

roster <- roster[-(which(roster %in% c('STARTERS','PLAYER, TEAM POS','','BENCH')))]

roster <- gsub(',.*$','', roster)

get_stats(p, roster[1], 2016)