clean <- function(p, t, sb) {
	sb <- sb[sb$GAME_ID != '0048300076', ]

	names(p) <- tolower(names(p))
	names(t) <- tolower(names(t))
	names(sb) <- tolower(names(sb))

	p[, c(1,2,5,10:28)] <- sapply(p[,c(1,2,5,10:28)], function(x) as.numeric(as.character(x)))
	t[, c(1,2,7:25)] <- sapply(t[, c(1,2,7:25)], function(x) as.numeric(as.character(x)))
	sb[, c(1,2,8:25)] <- sapply(sb[, c(1,2,8:25)], function(x) as.numeric(as.character(x)))

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

		df <- cbind(df, time)
		p_t_sb[[i]] <- df
	}
	p <- p_t_sb[[1]]
	t <- p_t_sb[[2]]
	sb <- p_t_sb[[3]]
}