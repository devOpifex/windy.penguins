check: document
	Rscript -e "devtools::check()"

document: windy
	Rscript -e "devtools::document()"

windy:
	Rscript -e "windy::windy_build()"

run: windy
	Rscript app.R
