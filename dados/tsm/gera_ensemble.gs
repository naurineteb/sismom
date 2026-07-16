etapas
'lats4d -i atemp_stdcor_01.ctl -o atemp_stdcor_01 -v'
'lats4d -i atemp_stdcor_02.ctl -o atemp_stdcor_02 -v'
cdo ensmean atemp_stdcor_01.nc atemp_stdcor_02.nc atemp_stdcor_ens.nc
