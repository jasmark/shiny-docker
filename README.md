## jasonmark/shiny-ubuntu

Image runs an instance of Shiny Server as shiny user in the lates version of Ubuntu. 

Usage:

`
docker run -d -p 80:3838 --name shiny_test --user shiny -v ~/ShinyApps/shinyapps/:/srv/shiny-server/ -v ~/ShinyApps/shinylog/:/var/log/ jasonmark/shiny-ubuntu
`

