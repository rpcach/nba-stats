server <- function(input, output) {
	datasetInput <- reactive({
		get_league_stats(input$league_url, save=TRUE, shiny=TRUE)
	})

	output$downloadData <- downloadHandler(
		filename= function() {
			datasetInput()
		},
		content = function(file) {
			file.copy(datasetInput(),file)
		}
	)
}