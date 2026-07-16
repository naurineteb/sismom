'reinit'
#nome = 't2m'
#prefixo='IC072026'
#titulo= 'TIME MEAN TEMP AT 2-M FROM SFC (K)'

nome = 'prec'
prefixo='IC072026'
titulo= 'TOTAL PRECIPITATION (Kg M**-2 Day**-1)'


'open 'prefixo'_'nome'_ensemble.ctl'
tt=0
'set gxout fwrite'
'set fwrite 'prefixo'_'nome'_mensal_ensemble.bin'

* agosto
'd ave('nome',t=1,t=31)'
tt=tt+1
* setembro
'd ave('nome',t=32,t=61)'
tt=tt+1
* outubro
'd ave('nome',t=62,t=92)'
tt=tt+1
* novembr
'd ave('nome',t=93,t=122)'
tt=tt+1
* dezembro
'd ave('nome',t=123,t=153)'
tt=tt+1
'disable fwrite'

say '===================================='
say say   '  ARQUIVO: 'bin
say '===================================='

x=write(prefixo'_'nome'_mensal_ensemble.ctl','DSET ^'prefixo'_'nome'_mensal_ensemble.bin')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','OPTIONS LITTLE_ENDIAN')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','undef -2.56E+33')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','xdef   59 linear    249.375   1.8750000000')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','ydef   50 levels -60.62040  -58.75521 -56.89001 -55.02481 -53.15960 -51.29438 -49.42915') 
x=write(prefixo'_'nome'_mensal_ensemble.ctl','  -47.56393 -45.69869 -43.83346 -41.96822 -40.10298 -38.23774 -36.37249 -34.50724 -32.64199')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','  -30.77674 -28.91149 -27.04624 -25.18099 -23.31573 -21.45048 -19.58522 -17.71996 -15.85470')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','  -13.98945 -12.12419 -10.25893  -8.39367  -6.52841  -4.66315  -2.79789  -0.93263 0.93263')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','   2.79789   4.66315   6.52841   8.39367  10.25893  12.12419  13.98945 15.85470  17.71996')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','   19.58522  21.45048  23.31573  25.18099  27.04624  28.91149 30.77674')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','ZDEF 1   LEVELS  1000')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','TDEF 'tt'  LINEAR 00Z01AUG2026 1MO')
x=write(prefixo'_'nome'_mensal_ensemble.ctl','VARS 1')
x=write(prefixo'_'nome'_mensal_ensemble.ctl',nome ' 0 99 'titulo)
x=write(prefixo'_'nome'_mensal_ensemble.ctl','ENDVARS')
say 'FIM MESMO'


