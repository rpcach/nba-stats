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

for(year in 1985:1983) {
	print(year)
	stats <- getSeasonData(year)

	player <- rbind(player, stats[[1]])
	team <- rbind(team, stats[[2]])
	starterBench <- rbind(starterBench, stats[[3]])

	saveRDS(player, file='data/season/player.rds')
	saveRDS(team, file='data/season/team.rds')
	saveRDS(starterBench, file='data/season/starterBench.rds')

}