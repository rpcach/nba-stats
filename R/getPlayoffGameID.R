getPlayoffGameID <- function(year) {
	year <- substring(year,3,4)

	stats <- NULL
	player<- NULL
	team <- NULL
	starterBench <- NULL
	if(year %in% c('17','16','15','14','13','12','11','10','09','08','07','06','05','04','03','02','01')) {
		for(round in 1:4) {
			for(match in 0:(16/(2**round) - 1)) {
				for(game in 1:7) {
					game_id <- c('004',year,'00',round,match,game)
					game_id <- paste(game_id, collapse='')
					tryCatch(
					{
						stats <- getBoxscoreTraditional(game_id)
						player <- rbind(player, stats$player)
						team <- rbind(team, stats$team)
						starterBench <- rbind(starterBench, stats$starterBench)
						print(game_id)
					},
					error=function(e) {
						#Sys.sleep(1)
					})
				}
			}
		}
	} else {
		is_complete <- FALSE
		i <- 1
		matchups <- NULL
		a_wins <- 0
		b_wins <- 0
		while(!is_complete) {
			i <- as.character(i)
			game_num <- rep('0', 5-nchar(i))
			game_id <- paste(c('004',year,game_num,i), collapse='')
			tryCatch (
			{
				stats <- getBoxscoreTraditional(game_id)
				player <- rbind(player, stats$player)
				team <- rbind(team, stats$team)
				starterBench <- rbind(starterBench, stats$starterBench)
				print(game_id)

				a <- min(as.numeric(as.character(stats$team$TEAM_ID)))
				b <- max(as.numeric(as.character(stats$team$TEAM_ID)))
				matchups <- rbind(matchups, cbind(a,b))
				if(nrow(unique(matchups)) == 15) {
					games <- intersect(team$GAME_ID[team$TEAM_ID == a], team$GAME_ID[team$TEAM_ID == b])

					a_pts <- as.numeric(as.character(stats$team$PTS[stats$team$TEAM_ID == a]))
					b_pts <- as.numeric(as.character(stats$team$PTS[stats$team$TEAM_ID == b]))

					a_wins <- a_wins + (a_pts > b_pts)
					b_wins <- b_wins + (b_pts > a_pts)

					if(a_wins == 4 | b_wins == 4) {
						is_complete <- TRUE
					}
				}
			},
			error=function(e) {
				Sys.sleep(2)
			})
			i <- as.numeric(i) + 1
		}
	}
	return(list(player, team, starterBench))
}
# so far have all the playoff games going back to the 01-02 season
# so the next 'year' should be equal to 00
# for game_num '00', this gets really tricky.
# saveRDS(player, file='data/playoffs/player.rds')
# saveRDS(team, file='data/playoffs/team.rds')
# saveRDS(starterBench, file='data/playoffs/starterBench.rds')

#for(x in unique(player$PLAYER_NAME)) {if(length(unique(player$PLAYER_ID[player$PLAYER_NAME == x])) > 1) {print(x)}}

player <- NULL
team <- NULL
starterBench <- NULL
#for(i in 1995:1986) {
	abc <- getPlayoffGameID(i)
	player <- rbind(player, abc[[1]])
	team <- rbind(team, abc[[2]])
	starterBench <- rbind(starterBench, abc[[3]])

	saveRDS(player, 'p2.rds')
	saveRDS(team, 't2.rds')
	saveRDS(starterBench, 'sb2.rds')
	print(i)
#}

#remove starterBench data for game_id: 0048700079