# =====================================================
# BIBLIOTECAS
# =====================================================

import xarray as xr
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import matplotlib.colors as mcolors
import cartopy.crs as ccrs
import cartopy.feature as cfeature

# =====================================================
# FORMATAÇÃO DOS EIXOS
# =====================================================

def fmt_lon(x):
    if x < 0:
        return f"{int(abs(x))}W"
    else:
        return f"{int(x)}E"


def fmt_lat(y):
    if y < 0:
        return f"{int(abs(y))}S"
    else:
        return f"{int(y)}N"

# =====================================================
# ÁREA DE INTERESSE
# =====================================================

lon1 = 270
lon2 = 330
lat1 = -60
lat2 = 20


def recorta_area(ds):
    if ds.latitude[0] < ds.latitude[-1]:
        lat_slice = slice(lat1, lat2)
    else:
        lat_slice = slice(lat2, lat1)
    return ds.sel(longitude=slice(lon1, lon2), latitude=lat_slice)
    
# =====================================================
# ARQUIVOS
# =====================================================

arq_clim = "/mnt/d/sismom/dados/besm-hindcast/ic07/prec_climo_cgcm138_ens.nc"
arq_prev = "/mnt/d/sismom/dados/IC072026/dados/IC072026_prec_mensal_ensemble.nc"

clim = xr.open_dataset(arq_clim)
prev = xr.open_dataset(arq_prev)

clim = recorta_area(clim)
prev = recorta_area(prev)

# =====================================================
# DEFINIÇÃO DOS TRIMESTRES
# =====================================================

trimestres = {
    "ASO": slice(0, 3),
    "SON": slice(1, 4),
    "OND": slice(2, 5),
}

nomes_tri_extenso = {
    "ASO": "Agosto-Setembro-Outubro",
    "SON": "Setembro-Outubro-Novembro",
    "OND": "Outubro-Novembro-Dezembro",
}

# =====================================================
# CONFIGURAÇÃO DO MAPA DE CORES (anomalia em %)
# =====================================================
# Escala percentual: -100% (seca total) até valores bem
# acima de 100% (excesso de chuva). Ajuste os níveis
# conforme a distribuição dos seus dados, se necessário.

niveis = np.array([
    -100, -75, -50, -25, -10,
     10, 25, 50, 75, 100, 125, 150
])

cores = [
 
    '#A0522D',  # -100 a -75
    '#CD853F',  # -75 a -50
    '#DEB887',  # -50 a -25
    '#F5DEB3',  # -25 a -10
    "#FFFFFF9B", # -10 a 10
    '#D8F0D2',  # 10 a 25
    '#A8E08A',  # 25 a 50
    '#73D055',  # 50 a 75
    '#3CB043',  # 75 a 100
    "#056605",  # 100 a 125   
    '#035703',  # 125 a 150 
]

cmap = mcolors.ListedColormap(cores)
# menores
cmap.set_under("#662F07")
# maiores
cmap.set_over("#013301")
norm = mcolors.BoundaryNorm(niveis, cmap.N)

# =====================================================
# GERA UMA FIGURA PARA CADA TRIMESTRE
# =====================================================

# assume que todos os meses de "prev" são do mesmo ano
ano_num = int(prev.time.dt.year[0].values)

for nome_tri, periodo in trimestres.items():

    # média trimestral da previsão (mm/dia)
    prev_tri = prev.prec.isel(
        time=periodo
    ).mean("time")

    # média trimestral da climatologia (mm/dia)
    clim_tri = clim.prec.isel(
        time=periodo
    ).mean("time")

    # -----------------------------------------------------
    # ANOMALIA PERCENTUAL
    # -----------------------------------------------------
    # (prev - clim) / clim * 100
    # onde clim_tri for zero (ou muito próximo de zero),
    # o resultado vira inf/NaN — mascaramos esses pontos.

    dado_tri = ((prev_tri - clim_tri) / clim_tri) * 100
   
    # Mascara: só mantém % onde |anomalia em mm| > 10
    dado_tri = dado_tri.where(np.abs(dado_tri) > 10)
    # -----------------------------------------------------
    # CRIA A FIGURA
    # -----------------------------------------------------

    fig = plt.figure(figsize=(8, 8))
    ax = plt.axes(projection=ccrs.PlateCarree())

    ax.set_extent(
        [lon1 - 360, lon2 - 360, lat1, lat2],
        crs=ccrs.PlateCarree()
    )

     # -----------------------------------------------------
    # PLOT DOS DADOS
    # -----------------------------------------------------

    ax.set_facecolor('white')   # <-- adicionar esta linha, antes ou depois do pcolormesh

    cf = ax.pcolormesh(
    dado_tri.longitude,
    dado_tri.latitude,
    dado_tri,
    cmap=cmap,
    norm=norm,
    transform=ccrs.PlateCarree()
    )

    ax.add_feature(cfeature.COASTLINE, linewidth=0.8)
    ax.add_feature(cfeature.BORDERS, linewidth=0.6)
    ax.add_feature(cfeature.STATES, linewidth=0.6, edgecolor='black')
    ax.add_feature(cfeature.LAND, facecolor='white')   # <-- tirar o zorder=0

    # -----------------------------------------------------
    # TICKS
    # -----------------------------------------------------

    xticks = np.arange(-90, -29, 10)
    yticks = np.arange(-60, 21, 10)

    ax.set_xticks(xticks, crs=ccrs.PlateCarree())
    ax.set_yticks(yticks, crs=ccrs.PlateCarree())

    ax.xaxis.set_major_formatter(
        mticker.FuncFormatter(lambda x, _: fmt_lon(x))
    )

    ax.yaxis.set_major_formatter(
        mticker.FuncFormatter(lambda y, _: fmt_lat(y))
    )

    ax.gridlines(
        draw_labels=False,
        linewidth=0.3,
        color='gray',
        alpha=0.5,
        linestyle='--'
    )

    # -----------------------------------------------------
    # TÍTULO (desligado, igual ao script original)
    # -----------------------------------------------------

    # ax.set_title(
    #     f"Anomalia de Precipitação (%)\n{nomes_tri_extenso[nome_tri]} {ano_num}",
    #     fontsize=12
    # )

    # -----------------------------------------------------
    # COLORBAR
    # -----------------------------------------------------
    pos = ax.get_position()

    cax = fig.add_axes([
        pos.x0 - 0.02,
        pos.y0 - 0.075,
        pos.width + 0.04,
        0.02
    ])

    cbar = fig.colorbar(
        cf,
        cax=cax,
        orientation='horizontal',
        extend='both'
    )

    cbar.set_ticks(
        [-100, -75, -50, -25, -10,
     10, 25, 50, 75, 100, 125, 150]
    )

    cbar.ax.tick_params(labelsize=8)

    # -----------------------------------------------------
    # SALVA
    # -----------------------------------------------------

    nome = f"IC072026_aprec_porcentagem_{nome_tri}{ano_num}.png"

    plt.savefig(
        nome,
        dpi=150,
        bbox_inches='tight',
        transparent=True
    )

    plt.close(fig)

    print(f"Figura salva: {nome}")

clim.close()
prev.close()

