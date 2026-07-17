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
# ARQUIVOS
# =====================================================

arq_clim = "/mnt/d/sismom/dados/besm-hindcast/ic07/prec_climo_cgcm138_ens.nc"
arq_prev = "/mnt/d/sismom/dados/IC072026/dados/IC072026_prec_mensal_ensemble.nc"

clim = xr.open_dataset(arq_clim)
prev = xr.open_dataset(arq_prev)

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

clim = recorta_area(clim)
prev = recorta_area(prev)

# =====================================================
# CLIMATOLOGIA MENSAL
# =====================================================

clim_mes = clim.prec.groupby("time.month").mean("time")
clim_prev = clim_mes.sel(month=prev.time.dt.month)

# =====================================================
# ANOMALIA MENSAL (mm) — CORRIGIDA COM DIAS DO MÊS
# =====================================================
# prec está em mm/dia; multiplicamos pelos dias de cada mês
# pra virar o total acumulado do mês. O xarray já sabe quantos
# dias tem cada mês (Julho=31, Setembro=30...), então não
# precisamos digitar isso na mão.

dias_no_mes = prev.time.dt.days_in_month
anom = (prev.prec - clim_prev) * dias_no_mes

# =====================================================
# CONFIGURAÇÃO DO MAPA DE CORES (degradê suave)
# =====================================================

niveis = np.array([
    -150,-100, -80, -60, -40, -20, -10,
     10, 20, 40, 60, 80, 100, 150
])

cores = [
    '#662F07',  # -150 a -100
    '#8B4513',  # -100 a -80
    '#A0522D',  # -80 a -60
    '#CD853F',  # -60 a -40
    '#DEB887',  # -40 a -20
    '#F5DEB3',  # -20 a -10
    '#FFFFFF',  # -10 a 10
    '#D8F0D2',  # 10 a 20
    '#A8E08A',  # 20 a 40
    '#73D055',  # 40 a 60
    '#3CB043',  # 60 a 80
    '#008000',  # 80 a 100
    '#035703',  # 100 a 150   
]

cmap = mcolors.ListedColormap(cores)
# menores
cmap.set_under("#301502")
# maiores
cmap.set_over("#013301")
norm = mcolors.BoundaryNorm(niveis, cmap.N)
# =====================================================
# NOMES DOS MESES (só pro título da figura)
# =====================================================

meses_pt = {
    7: "Julho", 8: "Agosto", 9: "Setembro",
    10: "Outubro", 11: "Novembro"
}

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
# GERA UMA FIGURA PARA CADA MÊS
# =====================================================

for t in range(anom.sizes["time"]):

    dado_mes = anom.isel(time=t)

    mes_num = int(prev.time.dt.month[t].values)
    ano_num = int(prev.time.dt.year[t].values)

    # =====================================================
    # CRIA A FIGURA
    # =====================================================

    fig = plt.figure(figsize=(8, 8))
    ax = plt.axes(projection=ccrs.PlateCarree())

    ax.set_extent(
        [lon1 - 360, lon2 - 360, lat1, lat2],
        crs=ccrs.PlateCarree()
    )

    # -----------------------------------------------------
    # PLOT DOS DADOS
    # -----------------------------------------------------

    cf = ax.contourf(
        dado_mes.longitude,
        dado_mes.latitude,
        dado_mes,
        levels=niveis,
        cmap=cmap,
        norm=norm,
        extend='both',
        transform=ccrs.PlateCarree()
    )

    # -----------------------------------------------------
    # FEIÇÕES GEOGRÁFICAS
    # -----------------------------------------------------

    ax.add_feature(cfeature.COASTLINE, linewidth=0.8)
    ax.add_feature(cfeature.BORDERS, linewidth=0.6)
    ax.add_feature(cfeature.STATES, linewidth=0.6, edgecolor='black')

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
    # TÍTULO
    # -----------------------------------------------------

#    ax.set_title(
#       f"Anomalia de Precipitação\n{meses_pt[mes_num]} {ano_num}",
#        fontsize=12
#    )

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
        [-150,-100, -80, -60, -40, -20, -10,
          10, 20, 40, 60, 80, 100, 150]
    )

    cbar.ax.tick_params(labelsize=8)

    # -----------------------------------------------------
    # SALVA
    # -----------------------------------------------------

    nome = f"IC072026_aprec_mmmes_{ano_num}{mes_num:02d}.png"

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

