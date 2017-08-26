getPlayoffGameID <- function(year) {
	year <- substring(year,3,4)

	stats <- NULL
	player<- NULL
	team <- NULL
	starterBench <- NULL
	for(year in c('16','15','14','13','12','11','10','09','08','07','06','05','04','03','02','01')) {
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
}
# so far have all the playoff games going back to the 01-02 season
# so the next 'year' should be equal to 00
# for game_num '00', this gets really tricky.
saveRDS(player, file='data/playoffs/player.rds')
saveRDS(team, file='data/playoffs/team.rds')
saveRDS(starterBench, file='data/playoffs/starterBench.rds')

#for(x in unique(player$PLAYER_NAME)) {if(length(unique(player$PLAYER_ID[player$PLAYER_NAME == x])) > 1) {print(x)}}