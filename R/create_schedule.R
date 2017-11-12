library(openxlsx)
source('team_names.R')

# download xls files from basketball-reference.com
# convert xlsx files to xlsx files
# rename them with the following format "nba-MONTH.xlsx"
files <- list(read.xlsx('D:/downloads/nba-oct.xlsx'))
files <- c(files, list(read.xlsx('D:/downloads/nba-nov.xlsx')))
files <- c(files, list(read.xlsx('D:/downloads/nba-dec.xlsx')))
files <- c(files, list(read.xlsx('D:/downloads/nba-jan.xlsx')))
files <- c(files, list(read.xlsx('D:/downloads/nba-feb.xlsx')))
files <- c(files, list(read.xlsx('D:/downloads/nba-mar.xlsx')))
files <- c(files, list(read.xlsx('D:/downloads/nba-apr.xlsx')))

months <- c(10,11,12,1,2,3,4)

for(i in 1:length(files)) {
	df <- files[[i]]

	dates <- strsplit(df$Date, ', ')
	dates <- unlist(dates)
	dates <- dates[seq(2, length(dates), 3)]
	dates<- strsplit(dates,' ')
	dates <- unlist(dates)
	dates <- dates[seq(2, length(dates), 2)]
	dates <-as.numeric(dates)

	ifelse(i <= 3, year <- 2017, year <- 2018)
	dates <- as.Date(paste(year, months[i], dates, sep='-'))

	df$Date <- dates

	for(j in 1:nrow(df)) {
		df$'Visitor/Neutral'[j] <- team_names$abbrev[team_names$name == df$'Visitor/Neutral'[j]]
		df$'Home/Neutral'[j] <- team_names$abbrev[team_names$name == df$'Home/Neutral'[j]]
	}

	df$time <- df$'Start.(ET)' * 24
	df$hours <- df$time %/% 1
	df$mins <- df$time %% 1 * 60

	df$dates <- as.POSIXlt(paste(df$Date,' ',df$hours,':',df$mins,':00',sep=''), tz='US/Eastern')

	df <- data.frame(df$dates, df$'Visitor/Neutral', df$'Home/Neutral')
	colnames(df) <- c('date_time','away','home')

	files[[i]] <- df
}

schedule <- files[[1]]
for(i in 2:length(files)) {
	schedule <- rbind(schedule, files[[i]])
}