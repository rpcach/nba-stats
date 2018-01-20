ui <- fluidPage(

titlePanel("Fantasy Basketball league stats (ESPN only)"),

mainPanel(

	textInput(inputId = 'league_url',
		label='Enter the home page of your ESPN Fantasy Basketball league',
		value='i.e. http://games.espn.com/fba/leagueoffice?leagueId=277777&seasonId=2018',
		width='600px'),
	
	"This will take around 30 seconds.",
	
	downloadButton('downloadData', 'Download')
)
)
