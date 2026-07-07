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
    tags$link(rel = "stylesheet", type = "text/css", href = "estilo.css"),
tags$script(HTML("

$(document).on('click','.img-zoom',function(){

    let titulo = $(this)
                    .closest('figure')
                    .find('figcaption')
                    .text();

    $('#tituloZoom').text(titulo);

    $('#imgZoom').attr('src',$(this).attr('src'));

    $('#modalZoom').css('display','flex');

});

"))
  ),
div(class="page-sazonal",
  div(
    class = "topo",
    h1("Brazilian Earth System Model"),
    h2("Dashboard Operacional SisMOM"),
    p("Julho a dezembro de 2026"),
    tags$img(src = "icons/sismom_ftransp.png", height = "120px")
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
            div( class = "mapa-sup",
              div( class = "mapa-tsm",
                tags$img(
                  class = "img-zoom",
                  src = "figs/bam_teste_gl2.png",
                   alt = "Mapa BESM"))#,
                ),
  br(),              
      div(
  class = "mapa-sa",

  tags$figure(
    class = "figura-mapa",
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_2607.png"
    ),
    tags$figcaption("Julho de 2026")
  ),

  tags$figure(
    class = "figura-mapa",
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_2608.png"
    ),
    tags$figcaption("Agosto de 2026")
  ),

  tags$figure(
    class = "figura-mapa",
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_2609.png"
    ),
    tags$figcaption("Setembro de 2026")
  )
),


div(
    id = "modalZoom",
    class = "modal-zoom",
    onclick = "this.style.display='none'",

    tags$span(
        class = "fechar-zoom",
        HTML("&times;")
    ),

    h2(
        id = "tituloZoom",
        class = "titulo-zoom"
    ),

    tags$img(
        id = "imgZoom",
        class = "conteudo-zoom"
    )
))))


server <- function(input, output, session) { }

shinyApp(ui, server)