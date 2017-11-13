# returns the # of games the player has in the date range, assuming he did not switch teams since his last game

num_games <- function(player, p, schedule, start, end=as.Date(start)+6) {
	p <- p[p$player_name == player, ]
	p <- p[order(p$game_id, decreasing=TRUE), ]
	team <- as.character(p$team_abbreviation[1])

	schedule$date_time <- as.Date(schedule$date_time)
	schedule <- schedule[schedule$date_time >= start & schedule$date_time < as.Date(end)+1, ]
	schedule <- schedule[schedule$away == team | schedule$home == team, ]

	return(nrow(schedule))
}

