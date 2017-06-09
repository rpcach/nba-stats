library(jsonlite)

source('R/getBoxscoreTraditional.R')

# loads data
player <- readRDS('data/season/player.rds') 
team <- readRDS('data/season/team.rds')
starterBench <- readRDS('data/season/starter-bench.rds')

