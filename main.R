setwd('nba-stats')

file.sources <- list.files('R', full.names=TRUE, recursive=TRUE)
sapply(file.sources, source)

#updateCurrentSeasonData()
#dataClean()

#loads season data
player <- readRDS('data/season/player.rds')#; p <- player
team <- readRDS('data/season/team.rds')
starterBench <- readRDS('data/season/starter-bench.rds')

# loads playoff data
player2 <- readRDS('data/playoffs/player.rds') 
team2 <- readRDS('data/playoffs/team.rds')
starterBench2 <- readRDS('data/playoffs/starter-bench.rds')

source('R/get_stats.R')
get_stats('Carmelo Anthony', 2017)

#goals:
#add in scraping of date for each game

game_id <- '0021500001'
url <- paste('http://stats.nba.com/stats/boxscoresummaryv2?GameID=',game_id,sep='')
x <- readLines(url)
x <- fromJSON(x)
x <- x$resultSets
x[,3][[5]][1,1]

#columbus day
setwd('nba-stats')
library(jsonlite) #used in getBoxscoreTraditional
#load data
game_ids <- as.character(unique(player$GAME_ID))
game_ids <- as.data.frame(cbind(game_ids,0), stringsAsFactors=FALSE)
colnames(game_ids)[2] <- 'date'
game_id <- game_ids$game_ids
for(i in 37714:nrow(game_ids)) {
	print(i)
	url <- paste('http://stats.nba.com/stats/boxscoresummaryv2?GameID=',game_id[i],sep='')
	x <- readLines(url)
	x <- fromJSON(x)
	x <- x$resultSets
	game_ids$date[i] <- x[,3][[5]][1,1]

	#game_ids$date[i] <- fromJSON(readLines(paste('http://stats.nba.com/stats/boxscoresummaryv2?GameID=',game_ids$game_ids[i],sep='')))$resultSets[,3][[5]][1,1]

	#Sys.sleep(1)
}
save(game_ids, file='game_ids_COMPLETE.rds')
# 38,367 rows
