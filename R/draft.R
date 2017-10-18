#draft

setwd('nba-stats')
p <- readRDS('data/season/player.rds')
names(p) <- tolower(names(p))
p[, c(1,2,5,10:28)] <- sapply(p[,c(1,2,5,10:28)], function(x) as.numeric(as.character(x)))

df <- p
df$min <- as.character(df$min)
temp <- strsplit(paste(df$min,':00',sep=''), split=':')

mins <- sapply(temp, "[[", 1)
secs <- sapply(temp, "[[", 2)

mins[mins == 'NA'] <- '00'
mins[nchar(mins) == 1] <- paste('0',mins[nchar(mins)==1],sep='')
time <- paste(mins,':',secs,sep='')

p <- cbind(p[, 1:9],0,0,p[, 10:ncol(p)])
colnames(p)[9:11] <- c('time','min','sec')

mins <- as.numeric(mins)
secs <- as.numeric(secs)
p$time <- mins + secs/60

p$min <- mins
p$sec <- secs

p <- p[, c(-8,-21,-22,-28,-30)]
# p <- p[substr(p$game_id,1,3) %in% c('216','215','214'), ]
p <- p[, c(-2,-5)]
colnames(p)[3] <- 'pos'

get_stats <- function(p, name, year=2016) {
	year <- paste('2', substr(year,3,4), sep='')
	p <- p[p$player_name == name & substr(p$game_id,1,3) == year, ]

	stats <- NULL

	stats <- c(stats,
		unique(as.character(p$player_name)),
		mean(p$time[p$time != 0], na.rm=TRUE),
		sum(p$fgm, na.rm=TRUE),
		sum(p$fga, na.rm=TRUE),
		sum(p$fgm, na.rm=TRUE) / sum(p$fga, na.rm=TRUE),
		sum(p$fg3m, na.rm=TRUE),
		sum(p$fg3a, na.rm=TRUE),
		sum(p$fg3m, na.rm=TRUE) / sum(p$fg3a, na.rm=TRUE),
		sum(p$ftm, na.rm=TRUE),
		sum(p$fta, na.rm=TRUE),
		sum(p$ftm, na.rm=TRUE) / sum(p$fta, na.rm=TRUE),
		mean(p$reb, na.rm=TRUE),
		mean(p$ast, na.rm=TRUE),
		mean(p$stl, na.rm=TRUE),
		mean(p$blk, na.rm=TRUE),
		mean(p$to, na.rm=TRUE),
		mean(p$pts, na.rm=TRUE))
	stats <- rbind(stats)
	stats <- as.data.frame(stats, stringsAsFactors=FALSE)
	for(i in 2:ncol(stats)) { stats[, i] <- as.numeric(stats[, i]) }

	colnames(stats) <- colnames(p)[c(4,6,9:23)]
	stats[1, 2:ncol(stats)] <- round(stats[1 , 2:ncol(stats)], digits=2)
	stats
}

stats(p, 'Carmelo Anthony')