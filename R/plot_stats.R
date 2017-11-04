plot_stats <- function(p, name, years='lifetime') {
	df <- get_stats(p, name, years)

	par(mfrow=c(2,3))
	#plot(df$pts, ylim=c(0,max(30, max(df$pts)+5)), type='b', main='points')
	barplot(df$pts, main='points', names.arg=df$season, ylim=c(0,35))
	barplot(df$reb, main='rebounds', names.arg=df$season, ylim=c(0,20))
	barplot(df$ast, main='assists', names.arg=df$season, ylim=c(0,15))
	barplot(df$stl, main='steals', names.arg=df$season, ylim=c(0,4))
	barplot(df$blk, main='blocks', names.arg=df$season, ylim=c(0,5))
	barplot(df$to, main='turnovers', names.arg=df$season, ylim=c(0,8))

}