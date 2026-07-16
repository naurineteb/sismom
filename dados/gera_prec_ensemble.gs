'reinit'
'open template_atm_072026.ctl'

'set x 134 192'
'set y 16 65'
'set z 1'

'set gxout fwrite'
'set fwrite IC072026_prec_ensemble.bin'

tt=31
while (tt <= 183)
  'set t 'tt
  'd ave(PREC,e=1,e=2)'
tt=tt+1
endwhile

'disable fwrite'

say FIM
