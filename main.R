library(jsonlite) #used in getBoxscoreTraditional
library(rvest) #used in getBoxscoreTraditional - actually no?

setwd('nba-stats')
source('R/getBoxscoreTraditional.R')

# loads season data
player <- readRDS('data/season/player.rds') 
team <- readRDS('data/season/team.rds')
starterBench <- readRDS('data/season/starter-bench.rds')

# loads playoff data
player2 <- readRDS('data/playoffs/player.rds') 
team2 <- readRDS('data/playoffs/team.rds')
starterBench2 <- readRDS('data/playoffs/starter-bench.rds')

#goals:
#add in scraping of date for each game

game_id <- '0021500001'
url <- paste('http://stats.nba.com/stats/boxscoresummaryv2?GameID=',game_id,sep='')
x <- readLines(url)
x <- fromJSON(x)
x <- x$resultSets
x[,3][[5]][1,1]