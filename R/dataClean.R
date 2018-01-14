dataClean <- function() {
	p <- readRDS('data/raw/player.rds')
	t <- readRDS('data/raw/team.rds')
	sb <- readRDS('data/raw/starter-bench.rds')

	sb <- sb[sb$GAME_ID != '0048300076', ]

	names(p) <- tolower(names(p))
	names(t) <- tolower(names(t))
	names(sb) <- tolower(names(sb))

	p[, c(1,2,5,10:28)] <- sapply(p[,c(1,2,5,10:28)], function(x) as.numeric(as.character(x)))
	t[, c(1,2,7:25)] <- sapply(t[, c(1,2,7:25)], function(x) as.numeric(as.character(x)))
	sb[, c(1,2,8:25)] <- sapply(sb[, c(1,2,8:25)], function(x) as.numeric(as.character(x)))

	#fixes playing time
	p_t_sb <- list(p,t,sb)
	for(i in 1:3) {
		print(i)
		df <- p_t_sb[[i]]
		df$min <- as.character(df$min)
		temp <- strsplit(paste(df$min,':00',sep=''), split=':')

		mins <- sapply(temp, "[[", 1)
		secs <- sapply(temp, "[[", 2)

		mins[mins == 'NA'] <- '00'
		mins[nchar(mins) == 1] <- paste('0',mins[nchar(mins)==1],sep='')

		df <- cbind(df[, 1:9],0,0,df[, 10:ncol(df)])
		colnames(df)[9:11] <- c('time','min','sec')

		mins <- as.numeric(mins)
		secs <- as.numeric(secs)
		df$time <- round(mins + secs/60, digits=2)

		df$min <- mins
		df$sec <- secs
		df <- df[, c(-8,-21,-22,-28,-30)]

		df <- cbind(substr(df[, 1], 1, 1), substr(df[, 1], 2, 3) , substr(df[, 1], 5, 8), df[, 2:ncol(df)], stringsAsFactors=FALSE)
		colnames(df)[1:3] <- c('type','year','game_num')
		df$type <- as.numeric(df$type)
		df$year <- as.numeric(df$year)
		df$game_num <- as.numeric(df$game_num)

		p_t_sb[[i]] <- df
	}
	p <- p_t_sb[[1]]
	t <- p_t_sb[[2]]
	sb <- p_t_sb[[3]]

	# p$is_season <- sapply(p$game_id, function(x) substr(x,3,3))
	# t$is_season <- sapply(t$game_id, function(x) substr(x,3,3))
	# sb$is_season <- sapply(sb$game_id, function(x) substr(x,3,3))

	p_season <- p[p$type == 2, ]
	t_season <- t[t$type == 2, ]
	sb_season <- sb[sb$type == 2, ]

	saveRDS(p_season, 'data/season/player.rds')
	saveRDS(t_season, 'data/season/team.rds')
	saveRDS(sb_season, 'data/season/starter-bench.rds')

	p_playoff <- p[p$type == 4, ]
	t_playoff <- t[t$type == 4, ]
	sb_playoff <- sb[sb$type == 4, ]

	saveRDS(p_playoff, 'data/playoffs/player.rds')
	saveRDS(t_playoff, 'data/playoffs/team.rds')
	saveRDS(sb_playoff, 'data/playoffs/starter-bench.rds')

}