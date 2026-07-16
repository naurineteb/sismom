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
    tags$link(rel = "stylesheet", 
              type = "text/css", 
              href = "estilo.css"),
    tags$script(HTML("$(document).on('click','.img-zoom',  
                function(){let titulo = $(this)
                    .closest('figure')
                    .find('figcaption')
                    .text();
    $('#tituloZoom').text(titulo);
    $('#imgZoom').attr('src',$(this).attr('src'));
    $('#modalZoom').css('display','flex');});"
  ))),
  
  div( class="page-sazonal",
    div(class = "topo",
  
      div(class = "topo-texto",
        h1("Sistema de Monitoramento de Óleo no Mar - SisMOM"),
        h2("Brazilian Earth System Model - BESM"),
        h3("Dashboard Temporário da Sala de Situação")
      ),

      div(class = "topo-logo",
        tags$img(
          src = "icons/sismom_ftransp.png"),
        tags$img(
          src = "icons/inpe.png")
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
        div(class = "valor-card", "Jul/2026")
    ),

    div(class = "card-operacional",
        div(class = "titulo-card", "Período"),
        div(class = "valor-card", "agosto a dezembro 2026")
    )
  ),
  br(),
    div( class = "painel-gif",
      tags$figure(
        class = "fig-tsm-gif",    
          tags$figcaption("Anomalia temperatura da superfície do mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/sst/sstanim.gif")),
      tags$figure(
        class = "fig-tsm-gif",    
          tags$figcaption("Anomalia temperatura da superfície do mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/sst/asstanim.gif"))),

    div( class = "mapa-box-main",
      h3("Previsão Mensal BESM - Agosto/2026"),
        div( class = "bloco-mapas",
          div( class = "mapas-sec",
      # Figura TSM
      tags$figure(
        class = "figura-sec-tsm",    
          tags$figcaption("Anomalia temperatura da superfície do mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/IC072026_anomalia_TSM_202608.png")),
    br(),              
  tags$figure( class = "figura-sec",
    tags$figcaption("Anomalia \n precipitação (mm/mês) Agosto/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec_mmmes202608.png"
    )),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia percentual \n precipitação (%) Agosto/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec__202608.png"
    )),
  
  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia temperatura 2m(°C)  Agosto/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_T2m_C202608.png"
    ))
))),
  br(),

# Dados sazonais            

    div( class = "mapa-box-main",
      h3("Previsão Trimestral BESM - ASO/2026"),
        div(class = "bloco-mapas",     
  div(
  class = "mapas-sec",

  tags$figure(
    class = "figura-sec-tsm",
    tags$figcaption("Anomalia temperatura da superfície do mar (°C)(***)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_TSM_202609.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia precipitação (mm/mês)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomprec_mediaASO2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia percentual precipitação (%)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomprec___ASO2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia temperatura 2m(°C)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_T2m_C_ASO2026.png"
    )
  )
)
)),

  br(),

    div( class = "mapa-box-main",
      h3("Previsão Mensal BESM - Setembro/2026"),
        div( class = "bloco-mapas",
      # Figura TSM
        tags$figure(
        class = "fig-tsm-main",    
          tags$figcaption("Anomalia mensal temperatura da superfície do mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/IC072026_anomalia_TSM_202609.png")),
    br(),              
    div(
  class = "map-var-main",
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia  precipitação (mm/mês) Setembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec_mmmes202609.png"
    )),

  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia percentual \n precipitação (%) Setembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec__202609.png"
    )),
  
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia  temperatura do ar (°C) Setembro/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_T2m_C202609.png"
    ))
))),
  br(),

# Dados sazonais            

    div(class = "mapa-box-main",
      h3("Previsão Trimestral BESM - SON/2026"),
        div(class = "bloco-mapas",     
  div(
  class = "mapas-sec",

  tags$figure(
    class = "figura-sec-tsm",
    tags$figcaption("Anomalia temperatura da superfície do mar (°C)(***)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_TSM_202609.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia precipitação (mm/mês)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomprec_mediaSON2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia percentual precipitação (%)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomprec___SON2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia temperatura 2m(°C)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_T2m_C_SON2026.png"
    )
  )
)
)),

  br(),

    div(class = "mapa-box-main",
      h3("Previsão Mensal BESM - outubro/2026"),
        div(class = "bloco-mapas",
      # Figura TSM
      #div( class = "map-tsm-main",
        tags$figure(
        class = "fig-tsm-main",    
          tags$figcaption("Anomalia mensal temperatura da superfície do mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/IC072026_anomalia_TSM_202610.png")),
    
    br(),              
    
    div(
  class = "map-var-main",
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia  precipitação (mm/mês) Outubro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec_mmmes202610.png"
    )),

  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia percentual \n precipitação (%) Outubro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec__202610.png"
    )),
  
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia \n temperatura do ar (°C) Outubro/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_T2m_C202610.png"
    ))
))),
  br(),

# Dados sazonais            

    div(class = "mapa-box-main",
      h3("Previsão Trimestral BESM - OND/2026"),
        div(class = "bloco-mapas",     
  div(
  class = "mapas-sec",

  tags$figure(
    class = "figura-sec-tsm",
    tags$figcaption("Anomalia temperatura da superfície do mar (°C)(***)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_TSM_202611.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia precipitação (mm/mês)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomprec_mediaOND2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia percentual precipitação (%) NDJ/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomprec___OND2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia temperatura 2m(°C) NDJ/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_T2m_C_OND2026.png"
    )
  )
)
)),
    br(),     
    div(class = "mapa-box-main",
      h3("Previsão Mensal BESM - Novembro/2026"),
        div(class = "bloco-mapas",
      # Figura TSM

        tags$figure(
        class = "fig-tsm-main",    
          tags$figcaption("Anomalia temperatura da superfície do mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/IC072026_anomalia_TSM_202611.png"))
      ,
    
    br(),              
    
    div(
  class = "map-var-main",
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia precipitação (mm/mês) Novembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec_mmmes202611.png"
    )),

  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia percentual \n precipitação (%) Novembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec__202611.png"
    )),
  
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia temperatura 2m(°C) Novembro/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_T2m_C202611.png"
    ))
))),
  br(),
  
    div(class = "mapa-box-main",
      h3("Previsão Mensal BESM - Dezembro/2026"),
        div(class = "bloco-mapas",
      # Figura TSM

        tags$figure(
        class = "fig-tsm-main",    
          tags$figcaption("Anomalia temperatura da superfície do mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/IC072026_anomalia_TSM_202612.png")),
    
    br(),              
    
    div(
  class = "map-var-main",
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia precipitação (mm/mês) Dezembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec_mmmes202612.png"
    )),

  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia percentual \n precipitação (%) Dezembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_prec__202612.png"
    )),
  
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia temperatura 2m(°C) Dezembro/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC072026_anomalia_T2m_C202612.png"
    ))
)))),
  br(),

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
))


server <- function(input, output, session) { }

shinyApp(ui, server)