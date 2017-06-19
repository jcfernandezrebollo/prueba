#! /bin/sh
if test $# -eq 1	#Caso en el que no hay parametros (NO DBEERIA EXISTIR)
then
	echo "Has pasado $# parametros"
	echo "Nombre de grafica -> $1"
 	sudo perf record -F 99 -a -g -- sleep 10  
 	sudo perf script -i perf.data > salida.perf
	echo "ya tengo el perf"
	sleep 5
	./stackcollapse-perf.pl salida.perf > salida.folded
	sleep 5
	echo "ya tengo el folded"
	./flamegraph.pl salida.folded > $1.svg
	exit 0
fi

if test $# -eq 5 #Caso en el que hay parametros, se ejecutan mientras se realizan mediciones
then
	echo "Has pasado $# parametros"
	echo "argumento $1 parametros"
	echo "jobname $2 parametros"
	echo "buildname $3 parametros"
	echo "segundos $4 seconds"
	sudo perf record -F 99 -a -g -- sleep $4 &
	$1
	sleep $5
	sudo perf script -i perf.data | ./src/main/resources/scripts/stackcollapse-perf.pl | ./src/main/resources/scripts/flamegraph.pl  > $2"-"$3.svg
	
	mv perf.data work/jobs/$2/builds/$3
	mv outError.txt work/jobs/$2/builds/$3
	mv outNormal.txt work/jobs/$2/builds/$3
	mv $2"-"$3.svg src/main/webapp
	

fi
exit 0

