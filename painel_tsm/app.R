library(shiny)
library(bslib)
library(shinyjs)

ui <- page_fluid(
  theme = bs_theme(
    version = 5,
    bg = "#F8F4ED",
    fg = "#0F3131",
    primary = "#16566B",
    base_font = font_google("Montserrat")
  ),
  useShinyjs(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "estilo.css")
  ),
div(class="page-sazonal",
  div(
    class = "topo",
    h1("Brazilian Earth System Model"),
    h2("Dashboard Operacional SisMOM"),
    p("Julho a dezembro de 2026")
  ),

  br(),

  layout_columns(
    col_widths = c(4,4,4),

    div(class = "card-operacional",
        div(class = "titulo-card", "Previsão"),
        div(class = "valor-card", "Sazonal")
    ),

    div(class = "card-operacional",
        div(class = "titulo-card", "Rodada"),
        div(class = "valor-card", "Jun/2026")
    ),

    div(class = "card-operacional",
        div(class = "titulo-card", "Período"),
        div(class = "valor-card", "Julho a dezembro 2026")
    )
  ),
  br(),

    div(
      class = "mapa-box",
      h3("Mapa sazonal BESM"),
            div( class = "mapa-global",
                tags$img(
                  id = "mapa_besm",
                  src = "figs/bam_teste_gl.png",
                  alt = "Mapa BESM") ,
                tags$img(
                  id = "mapa_besm",
                  src = "figs/bam_teste_tsm.png",
                  alt = "Mapa BESM"
                )),
  br(),              
      div(
      class = "mapa-sa",
      tags$img(
        id = "mapa_besm",
        src = "figs/bam_teste_tsm.png",
        alt = "Mapa BESM"
      ),
      tags$img(
        id = "mapa_besm",
        src = "figs/bam_teste_tsm.png",
        alt = "Mapa BESM"
      ),
      tags$img(
        id = "mapa_besm",
        src = "figs/bam_teste_tsm.png",
        alt = "Mapa BESM"
      )))))


server <- function(input, output, session) {

  observeEvent(input$mes, {

    arquivo <- switch(
      input$mes,
      "Julho" = "figs/bam_teste_tsm.png",
      "Agosto" = "figs/bam_teste_tsm3.png",
      "Setembro" = "figs/bam_teste_tsm2.png",
      "Outubro" = "figs/bam_teste_tsm4.png",
      "Novembro" = "figs/bam_teste_tsm.png",
      "Dezembro" = "figs/bam_teste_tsm2.png",
      "prec_jul.png"
    )

    shinyjs::runjs(
      sprintf(
        "$('#mapa_besm').attr('src', '%s?v=' + new Date().getTime());",
        arquivo
      )
    )

  }, ignoreInit = FALSE)
}

shinyApp(ui, server)