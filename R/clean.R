clean <- function(p, t, sb) {
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
		time <- paste(mins,':',secs,sep='')

		#df <- cbind(df, time)
		df <- cbind(df[, 1:9],0,0,df[, 10:ncol(df)])
		colnames(df)[9:11] <- c('time','min','sec')

		mins <- as.numeric(mins)
		secs <- as.numeric(secs)
		df$time <- mins + secs/60

		df$min <- mins
		df$sec <- secs
		df <- df[, c(-8,-21,-22,-28,-30)]

		p_t_sb[[i]] <- df
	}
	p <- p_t_sb[[1]]
	t <- p_t_sb[[2]]
	sb <- p_t_sb[[3]]

	# p$is_season <- sapply(p$game_id, function(x) substr(x,3,3))
	# t$is_season <- sapply(t$game_id, function(x) substr(x,3,3))
	# sb$is_season <- sapply(sb$game_id, function(x) substr(x,3,3))

	return(list(p, t, sb))
}