*******************************************************
* BESM_Ensemble.gs
*******************************************************
*
* Autor    : Virginia Silveira
* Auxílio  : ChatGPT
*
* Versão   : 1.0
* Data     : 30/06/2026
*
* Objetivo
*
* Calcula o ensemble médio dos membros do BESM,
* recorta um domínio espacial e grava automaticamente
* os arquivos BIN e CTL.
*
*******************************************************
'reinit'

arquivo='template_atm_072026.ctl'
prefixo='IC072026'
ii=0

var='T2MT'
nome='t2m'

ens1=1
ens2=2

x1=134
x2=192

y1=16
y2=65

tini=31
tfim=183

'open 'arquivo

'set x 'x1' 'x2
'set y 'y1' 'y2
'set z 1'

bin=prefixo'_'nome'_ensemble.bin'

'set gxout fwrite'
'set fwrite 'bin

tt=tini

while(tt<=tfim)

   say 'T='tt

   'set t 'tt
   'd ave('%var%',e='ens1',e='ens2')'
   ii=ii+1
   tt=tt+1

endwhile

'disable fwrite'

say '===================================='
say say   '  ARQUIVO: 'bin
say '===================================='

x=write(prefixo'_'nome'_ensemble.ctl','DSET ^'bin)
x=write(prefixo'_'nome'_ensemble.ctl','OPTIONS LITTLE_ENDIAN')
x=write(prefixo'_'nome'_ensemble.ctl','undef -2.56E+33')
x=write(prefixo'_'nome'_ensemble.ctl','xdef   59 linear    249.375   1.8750000000')
x=write(prefixo'_'nome'_ensemble.ctl','ydef   50 levels -60.62040  -58.75521 -56.89001 -55.02481 -53.15960 -51.29438 -49.42915') 
x=write(prefixo'_'nome'_ensemble.ctl','  -47.56393 -45.69869 -43.83346 -41.96822 -40.10298 -38.23774 -36.37249 -34.50724 -32.64199')
x=write(prefixo'_'nome'_ensemble.ctl','  -30.77674 -28.91149 -27.04624 -25.18099 -23.31573 -21.45048 -19.58522 -17.71996 -15.85470')
x=write(prefixo'_'nome'_ensemble.ctl','  -13.98945 -12.12419 -10.25893  -8.39367  -6.52841  -4.66315  -2.79789  -0.93263 0.93263')
x=write(prefixo'_'nome'_ensemble.ctl','   2.79789   4.66315   6.52841   8.39367  10.25893  12.12419  13.98945 15.85470  17.71996')
x=write(prefixo'_'nome'_ensemble.ctl','   19.58522  21.45048  23.31573  25.18099  27.04624  28.91149 30.77674')
x=write(prefixo'_'nome'_ensemble.ctl','ZDEF 1   LEVELS  1000')
x=write(prefixo'_'nome'_ensemble.ctl','TDEF 'ii'  LINEAR 00Z01AUG2026 1DY')
x=write(prefixo'_'nome'_ensemble.ctl','VARS 1')
x=write(prefixo'_'nome'_ensemble.ctl',nome' 0 99 TIME MEAN TEMP AT 2-M FROM SFC          (K)')
x=write(prefixo'_'nome'_ensemble.ctl','ENDVARS')
say 'FIM MESMO'
