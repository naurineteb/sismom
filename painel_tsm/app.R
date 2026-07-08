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

  div(
    class = "topo-texto",
    h1("Brazilian Earth System Model"),
    h2("Dashboard Operacional SisMOM"),
    p("Julho a dezembro de 2026")
  ),

  div(
    class = "topo-logo",
    tags$img(
      src = "icons/sismom_ftransp.png",
      height = "120px"
    ),
        tags$img(
      src = "icons/inpe.png",
      height = "120px"
    )
  )
),

  br(),

  div(class="cards-columns",

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
      h3(style="margin-top: 0","Previsão Média Mensal BESM - Julho/2026"),
              div( class = "mapa-tsm",    
                  tags$p(class="title-img",style="width:300px","Anomalia mensal Temperatura do ar (°C)"),
                tags$img(
                  class = "img-zoom",
                  src = "figs/IC062026_anomalia_TSM_C202607.png",
                   alt = "Mapa BESM")),
  br(),              
      div(
  class = "mapa-sa",
  tags$figure(
    class = "figura-mapa",
    tags$figcaption("Anomalia mensal \n Precipitação (mm/mês) Julho/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_mmmes202607.png"
    )),

  tags$figure(
    class = "figura-mapa",
    tags$figcaption("Anomalia Percentual \n precipitação (%) Julho/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec__202607.png"
    )),
  
  tags$figure(
    class = "figura-mapa",
    tags$figcaption("Anomalia mensal \n Temperatura do ar (°C) Julho/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_T2m_C202607.png"
    ))
),
  br(),

# Dados sazonais                 
  div(
      class = "mapa-box",style="display:flex",
      tags$img(class = "img-zoom",style="height:70px",
                  src = "figs/IC062026_anomalia_TSM_C202610.png"),
  tags$figure(
    class = "figura-mapa",style="width: 50px",
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_mmmes_JAS2026.png"
    )),

  tags$figure(
    class = "figura-mapa",style="width: 50px",
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec___JAS2026.png"
    )),
  
  tags$figure(
    class = "figura-mapa",style="width: 50px",
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_T2m_C_JAS2026.png"
    ))
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