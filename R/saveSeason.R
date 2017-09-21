saveSeason <- function(player, team, starterBench) {
	p <- readRDS('data/season/player.rds')
	t <- readRDS('data/season/team.rds')
	sb <- readRDS('data/season/starterBench.rds')

	saveRDS(p, file='data/season/player-backup.rds')
	saveRDS(t, file='data/season/team-backup.rds')
	saveRDS(sb, file='data/season/starterBench-backup.rds')

	saveRDS(player, file='data/season/player.rds')
	saveRDS(team, file='data/season/team.rds')
	saveRDS(starterBench, file='data/season/starterBench.rds')

	return()
}