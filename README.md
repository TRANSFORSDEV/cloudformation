# cloudformation


#elb nv alcaldias
#elb2 oregon alcaldias
#elb3 nv ips 

### Comando a ejecutar (sin los corchetes)
.\deploy.ps1 elb[1,2,3] dev 



si voy a hacer un ajuste en algun servidor debo escoger en environments el #ELB y cambiarle el API_DOMAIN al que corresponda...


Si necesito agregar puertos voy a lib/templates/ec2/ y escojo el elb  que corresponda segun el servidor -> Adentro tengo qeu copiar un "TargetGroup" y un "HTTPSListener" y remplazar todo en su bloque de codigo (Recordar qeu es por identacion)
luego si se puede a proceder a ejecutar el cmd y validar cualquier cosa dentro del balanceador de carga