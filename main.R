library(jsonlite)

source('R/getBoxscoreTraditional.R')

# loads season data
player <- readRDS('data/season/player.rds') 
team <- readRDS('data/season/team.rds')
starterBench <- readRDS('data/season/starter-bench.rds')

# loads playoff data
player <- readRDS('data/playoffs/player.rds') 
team <- readRDS('data/playoffs/team.rds')
starterBench <- readRDS('data/playoffs/starter-bench.rds')