library(shiny)
library(bslib)
library(shinyjs)

yyyy = 2026
mm = 8
mes= "Agosto"
loc_dir="IC072026"

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
        h1("Brazilian Earth System Model"),
        h2("Dashboard Operacional SisMOM"),
        p("Julho a dezembro de 2026")
      ),

      div(class = "topo-logo",
        tags$img(
          src = "icons/sismom_ftransp.png",
          height = "120px"),
        tags$img(
          src = "icons/inpe.png",
          height = "120px")
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

    div( class = "mapa-box-main",
      h3("Previsão Mensal BESM - Agosto/2026"),
        div( class = "bloco-mapas",
      # Figura TSM
      div( class = "map-tsm-main",
        tags$figure(
        class = "fig-tsm-main",    
          tags$figcaption("Anomalia mensal Temperatura da Superfície do Mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = paste0("figs/",loc_dir,"/tsm/",loc_dir,"_anomalia_TSM_",yyyy,formatC(mm[1], width=2,flag=0),".png")))
      ),
    
    br(),              
    
    div(
  class = "map-var-main",
  tags$figure(
    class = "fig-var-main",
    tags$figcaption(paste0("Anomalia mensal \n Precipitação (mm/mês) ",mes[1],"/2026")),
    tags$img(
      class = "img-zoom",
      src = paste0("figs/",loc_dir,"/prec/",loc_dir,"_anomalia_prec_mmmes",yyyy,formatC(mm[1], width=2,flag=0),".png")
    )),

  tags$figure(
    class = "fig-var-main",
    tags$figcaption(paste0("Anomalia Percentual mensal \n Precipitação (%) ",mes[1],"/2026"),
    tags$img(
      class = "img-zoom",
      src = paste0("figs/",loc_dir,"/prec/",loc_dir,"_anomalia_prec__",yyyy,formatC(mm[1], width=2,flag=0),".png")
    )),
  
  tags$figure(
    class = "fig-var-main",
    tags$figcaption(paste0("Anomalia mensal \n Temperatura do ar (°C) ",mes[1],"/2026"),
    tags$img(
      class = "img-zoom",
      src = paste0("figs/",loc_dir,"/t2m/",loc_dir,"_anomalia_T2m_C",yyyy,formatC(mm[1], width=2,flag=0),".png")
    ))
))),
  br(),

# Dados sazonais            

    div( class = "mapa-box-main",
      h3("Previsão Sazonal BESM - JAS/2026"),
        div(class = "bloco-mapas",     
  div(
  class = "mapas-sec",

  tags$figure(
    class = "figura-sec-tsm",
    tags$figcaption("Anomalia sazonal Temperatura da Superfície do Mar (°C)(***)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_TSM_C202608.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia mensal Precipitação (mm) Jul/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_mmmes_JAS2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia percentual Precipitação (%) Jul/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec___JAS2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia mensal Temp. do ar (°C) Jul/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_T2m_C_JAS2026.png"
    )
  )
)
)),

  br(),

    div( class = "mapa-box-main",
      h3("Previsão Mensal BESM - Agosto/2026"),
        div( class = "bloco-mapas",
      # Figura TSM
      div( class = "map-tsm-main",
        tags$figure(
        class = "fig-tsm-main",    
          tags$figcaption("Anomalia mensal Temperatura da Superfície do Mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/IC062026_anomalia_TSM_C202607.png"))
      ),
    
    br(),              
    
    div(
  class = "map-var-main",
  tags$figure(
    class = "fig-var-main",
    tags$figcaption(paste0("Anomalia mensal \n Precipitação (mm/mês)",mes[1],"/2026")),
    tags$img(
      class = "img-zoom",
      src = ""
    )),

  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia Percentual \n precipitação (%) Agosto/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec__202608.png"
    )),
  
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia mensal \n Temperatura do ar (°C) Agosto/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_T2m_C202608.png"
    ))
))),
  br(),

# Dados sazonais            

    div(class = "mapa-box-main",
      h3("Previsão Sazonal BESM - ASO/2026"),
        div(class = "bloco-mapas",     
  div(
  class = "mapas-sec",

  tags$figure(
    class = "figura-sec-tsm",
    tags$figcaption("Anomalia sazonal Temperatura da Superfície do Mar (°C)(***)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_TSM_C202609.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia mensal Precipitação (mm) ASO/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_mmmes_ASO2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia percentual Precipitação (%) ASO/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec___ASO2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia mensal Temp. do ar (°C) ASO/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_T2m_C_ASO2026.png"
    )
  )
)
)),

  br(),

    div(class = "mapa-box-main",
      h3("Previsão Mensal BESM - Setembro/2026"),
        div(class = "bloco-mapas",
      # Figura TSM
      div( class = "map-tsm-main",
        tags$figure(
        class = "fig-tsm-main",    
          tags$figcaption("Anomalia mensal Temperatura da Superfície do Mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/IC062026_anomalia_TSM_C202609.png"))
      ),
    
    br(),              
    
    div(
  class = "map-var-main",
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia mensal \n Precipitação (mm/mês) Setembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_mmmes202609.png"
    )),

  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia Percentual \n precipitação (%) Setembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec__202609.png"
    )),
  
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia mensal \n Temperatura do ar (°C) Setembro/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_T2m_C202609.png"
    ))
))),
  br(),

# Dados sazonais            

    div(class = "mapa-box-main",
      h3("Previsão Sazonal BESM - SON/2026"),
        div(class = "bloco-mapas",     
  div(
  class = "mapas-sec",

  tags$figure(
    class = "figura-sec-tsm",
    tags$figcaption("Anomalia sazonal Temperatura da Superfície do Mar (°C)(***)"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_TSM_C202609.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia mensal Precipitação (mm) SON/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_mmmes_SON2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia percentual Precipitação (%) SON/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec___SON2026.png"
    )
  ),

  tags$figure(
    class = "figura-sec",
    tags$figcaption("Anomalia mensal Temp. do ar (°C) SON/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_T2m_C_SON2026.png"
    )
  )
)
)),
    br(),     
    div(class = "mapa-box-main",
      h3("Previsão Mensal BESM - Outubro/2026"),
        div(class = "bloco-mapas",
      # Figura TSM
      div( class = "map-tsm-main",
        tags$figure(
        class = "fig-tsm-main",    
          tags$figcaption("Anomalia mensal Temperatura da Superfície do Mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/IC062026_anomalia_TSM_C202610.png"))
      ),
    
    br(),              
    
    div(
  class = "map-var-main",
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia mensal \n Precipitação (mm/mês) Outubro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_mmmes202610.png"
    )),

  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia Percentual \n precipitação (%) Outubro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec__202610.png"
    )),
  
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia mensal \n Temperatura do ar (°C) Outubro/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_T2m_C202610.png"
    ))
))),
  br(),
  
    div(class = "mapa-box-main",
      h3("Previsão Mensal BESM - Novembro/2026"),
        div(class = "bloco-mapas",
      # Figura TSM
      div( class = "map-tsm-main",
        tags$figure(
        class = "fig-tsm-main",    
          tags$figcaption("Anomalia mensal Temperatura da Superfície do Mar (°C)"),
          tags$img(
            class = "img-zoom",
            src = "figs/IC062026_anomalia_TSM_C202611.png"))
      ),
    
    br(),              
    
    div(
  class = "map-var-main",
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia mensal \n Precipitação (mm/mês) Novembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec_mmmes202611.png"
    )),

  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia Percentual \n precipitação (%) Novembro/2026"),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_prec__202611.png"
    )),
  
  tags$figure(
    class = "fig-var-main",
    tags$figcaption("Anomalia mensal \n Temperatura do ar (°C) Novembro/2026 "),
    tags$img(
      class = "img-zoom",
      src = "figs/IC062026_anomalia_T2m_C202611.png"
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
))))


server <- function(input, output, session) { }

shinyApp(ui, server)