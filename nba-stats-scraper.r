library(jsonlite)
library(sqldf)
library(curl)
setwd('nba/db')
db <- dbConnect(SQLite(), dbname='Test.sqlite') #creates db if it doesn't exist

get_standings <- function() {
  link <- 'http://stats.nba.com/stats/leaguedashteamstats?Conference=&DateFrom=&DateTo=&Division=&GameScope=&GameSegment=&LastNGames=0&LeagueID=00&Location=&MeasureType=Advanced&Month=0&OpponentTeamID=0&Outcome=&PORound=0&PaceAdjust=N&PerMode=PerGame&Period=0&PlayerExperience=&PlayerPosition=&PlusMinus=N&Rank=N&Season=2016-17&SeasonSegment=&SeasonType=Regular+Season&ShotClockRange=&StarterBench=&TeamID=0&VsConference=&VsDivision='
  link <- curl::curl(link)
  x <- fromJSON(link)
  x3 <- x[[3]]
  y2 <- x3[[2]]
  y2 <- y2[[1]]
  y3 <- data.frame(x3[[3]])
  colnames(y3) <- y2
  
  dbWriteTable(db,'standings',y3,append=TRUE)
}

#Don't know what is going on here
get_playbyplay <- function() {
  link <- 'http://stats.nba.com/stats/playbyplay?GameID=0021300592&RangeType=0&StartPeriod=0&EndPeriod=0&StartRange=0&EndRange=0'
  link <- curl::curl(link)
  x <- fromJSON(link)
  x3 <- x[[3]]
  y2 <- x3[[2]]
  y2 <- y2[[1]]
  y3 <- data.frame(x3[[3]])
  colnames(y3) <- y2
  
  dbWriteTable(db,'playbyplay',y3,append=TRUE)
}

get_boxscore_advanced2 <- function() {
  link <- 'http://stats.nba.com/stats/boxscoreadvancedv2?GameID=0021600808&RangeType=0&StartPeriod=0&EndPeriod=0&StartRange=0&EndRange=0'
  link <- curl::curl(link)
  x <- fromJSON(link)
  x3 <- x[[3]]
  y2 <- x3[[2]]
  y2 <- y2[[1]]
  y3 <- data.frame(x3[[3]])
  colnames(y3) <- y2
  
  dbWriteTable(db,'boxscore_adv',y3,append=TRUE)
}
get_boxscore_traditional <- function(game_id) {
  #gameid <- '0021600711' #'0021600808'
  #game_int <- 21600809
  link <- paste('http://stats.nba.com/stats/boxscoretraditionalv2?GameID=',game_id,'&RangeType=0&StartPeriod=0&EndPeriod=0&StartRange=0&EndRange=0',sep='')
  link <- curl::curl(link)
  x <- fromJSON(link)
  y3 <- x[[3]]
  
  column_names <- y3[1,2][[1]]
  data <- y3[1,3][[1]]
  data <- data.frame(data)
  colnames(data) <- column_names
  dbWriteTable(db,'boxscore',data,append=TRUE)

  column_names2 <- y3[2,2][[1]]
  data2 <- y3[2,3][[1]]
  data2 <- data.frame(data2)
  colnames(data2) <- column_names2
  dbWriteTable(db,'boxscore_team',data2,append=TRUE)

  #boxscore_starter_bench only exists starting from the '96-'97 season
  # column_names3 <- y3[3,2][[1]]
  # data3 <- y3[3,3][[1]]
  # data3 <- data.frame(data3)
  # colnames(data3) <- column_names3
  # dbWriteTable(db,'boxscore_starter_bench',data3,append=TRUE)
}

loop <- function() { 
  year <- 1988
  year <- substring(year,3,4)
  for(x in 1107:1000) {
    y <- paste('002',year,'0',x,sep='')
    get_boxscore_traditional(y)
    print(paste(x,'done'))
  }
  for(x in 999:100) {
    y <- paste('002',year,'00',x,sep='')
    get_boxscore_traditional(y)
    print(paste(x,'done'))
  }
  for(x in 99:10) {
    y <- paste('002',year,'000',x,sep='')
    get_boxscore_traditional(y)
    print(paste(x,'done'))
  }
  for(x in 9:1) {
    y <- paste('002',year,'0000',x,sep='')
    get_boxscore_traditional(y)
    print(paste(x,'done'))
  }
}
