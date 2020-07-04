#! /bin/bash
#shell que corre en nuestro script
#funciones

green='\e[1;32m'
purple='\e[1;35m'
red='\e[1;31m'
minusred='\e[0;31m'
cyan='\e[1;36m'
minuscyan='\e[0;36m'
black='\e[1;30m'
blue='\e[1;34m'
white='\e[0;39m'
NC='\e[0m' # No Color
colores=($NC $green $purple $red $cyan $minusred $blue $white)


clear
echo "############################################################"
echo "#                     Creative Commons                     #"
echo "#                                                          #"
echo "#                   BY - Atribución (BY)                   #"
echo "#                 NC - No uso Comercial (NC)               #"
echo "#                SA - Compartir Igual (SA)                 #"
echo "############################################################"
echo "############################################################" > informeFCFS.txt
echo "#                     Creative Commons                     #" >> informeFCFS.txt
echo "#                                                          #" >> informeFCFS.txt
echo "#                   BY - Atribución (BY)                   #" >> informeFCFS.txt
echo "#                 NC - No uso Comercial (NC)               #" >> informeFCFS.txt
echo "#                SA - Compartir Igual (SA)                 #" >> informeFCFS.txt
echo "############################################################" >> informeFCFS.txt

echo ""
echo >> informeFCFS.txt

echo "#######################################################################" >> informeFCFS.txt
echo "#                                                                     #" >> informeFCFS.txt
echo "#                         INFORME DE PRÁCTICA                         #" >> informeFCFS.txt
echo "#                         GESTIÓN DE PROCESOS                         #" >> informeFCFS.txt
echo "#             -------------------------------------------             #" >> informeFCFS.txt
echo "#     Nuevos alumnos: Mario Ubierna San Mames, Jorge Navarro González #" >> informeFCFS.txt
echo "#     Alumno original: Marcos Pena Calvar, David Cacho Saiz           #" >> informeFCFS.txt
echo "#     Sistemas Operativos 2º Semestre                                 #" >> informeFCFS.txt
echo "#     Grado en ingeniería informática (2016-2017)                     #" >> informeFCFS.txt
echo "#                                                                     #" >> informeFCFS.txt
echo "#######################################################################" >> informeFCFS.txt
echo "" >> informeFCFS.txt

echo "############################################################" > informeFCFScolor.txt
echo "#                     Creative Commons                     #" >> informeFCFScolor.txt
echo "#                                                          #" >> informeFCFScolor.txt
echo "#                   BY - Atribución (BY)                   #" >> informeFCFScolor.txt
echo "#                 NC - No uso Comercial (NC)               #" >> informeFCFScolor.txt
echo "#                SA - Compartir Igual (SA)                 #" >> informeFCFScolor.txt
echo "############################################################" >> informeFCFScolor.txt

echo >> informeFCFScolor.txt

echo "#######################################################################" >> informeFCFScolor.txt
echo "#                                                                     #" >> informeFCFScolor.txt
echo "#                         INFORME DE PRÁCTICA                         #" >> informeFCFScolor.txt
echo "#                         GESTIÓN DE PROCESOS                         #" >> informeFCFScolor.txt
echo "#             -------------------------------------------             #" >> informeFCFScolor.txt
echo "#     Nuevos alumnos: Mario Ubierna San Mames, Jorge Navarro González #" >> informeFCFScolor.txt
echo "#     Alumno original: Marcos Pena Calvar, David Cacho Saiz           #" >> informeFCFScolor.txt
echo "#     Sistemas Operativos 2º Semestre                                 #" >> informeFCFScolor.txt
echo "#     Grado en ingeniería informática (2016-2017)                     #" >> informeFCFScolor.txt
echo "#                                                                     #" >> informeFCFScolor.txt
echo "#######################################################################" >> informeFCFScolor.txt
echo "" >> informeFCFScolor.txt



#cabecera del algoritmo en el que nos encontramos
echo -e "\e[0;33m_________________________________________________________________________________________________ \e[0m"
echo -e "\e[0;33m*				\e[1;36mAlgoritmo FCFS Fijas y No Iguales, Mejor \e[0m			\e[0;33m*"
echo -e "\e[0;33m*	        	\e[1;36mAntiguo alumno: Marcos Pena Calvar, David Cacho Saiz \e[0m			\e[0;33m*"
echo -e "\e[0;33m*		\e[1;36mNuevos alumnos: Mario Ubierna San Mamés, Jorge Navarro González \e[0m		\e[0;33m*"
echo -e "\e[0;33m*					\e[1;36mVersión Junio 2017 \e[0m					\e[0;33m*"
echo -e "\e[0;33m\_______________________________________________________________________________________________/ \e[0m	"

#función que comprueba que un nombre es correctas
function Comprobarn {
	palabra=`echo $1 $2 | wc -w` #cuento las palabras
	if [ $palabra -ne 1 ]  #si es distinto pido otro nombre para el proceso
	then
		echo "Nombre De Proceso No Valido"
		echo "Introduce un nombre para el proceso sin espacios"
		valido=1;
	else
		valido=0;
	fi
}

function ordenar {
	for ((i=1;i<=${#llegada[@]};i++)){   # esto me indica ${#tiempo[@]} el tiempo de llegada
	a=${llegada[$i]};
	j=$i
	let j++
	b=${llegada[$j]};    #asigno a unas variables
	if [[ $i -ne ${#llegada[@]} ]]
	then
		if [[ $a -gt $b ]];
		then
			aux=${llegada[$i]};
			llegada[$i]=${llegada[$j]};   #para ordenar por menor tiempo de llegada
			llegada[$j]=$aux;

			aux2=${tiempo[$i]};
			tiempo[$i]=${tiempo[$j]};  #para ordenar los tiempos de ejecucion con sus tiempos de respuesta
			tiempo[$j]=$aux2;

			aux3=${proceso[$i]};
			proceso[$i]=${proceso[$j]};  #para ordenar los nombres con sus mismos valores
			proceso[$j]=$aux3;

			aux4=${memoria[$i]};
			memoria[$i]=${memoria[$j]};  #para ordenar la memoria con sus mismos valores
			memoria[$j]=$aux4;
			if [ $i -gt 1 ];then
				let i--
				let i--
			fi
		fi
	fi
}

}

function cambios {
	cambio=0
	local i
	for((i=1;i<${#estado[@]};i++)){
		if [[ ${estado[$i]} != ${estadoAnterior[$i]} ]];then
			estadoAnterior[$i]=${estado[$i]}
			cambio=1
		fi
	}
}

function arreglar {
	local i
	local j
	for((i=1;i<${#estado[@]};i++)){
		j=${llegada[$i]}
		if [ $j -gt $reloj ]
		then
			estado[$i]="No ha llegado"
		fi
	}
}

function Procesoejecutado {
	local int=-1
	for((i=${#estado[@]};i>=0; i--)){
		if [[ ${estado[$i]} == "En ejecución" ]]
		then
			int=$i
		fi
	}
	return $int
}


# Nos permite saber si el parámetro pasado es entero positivo.
es_entero() {
	[ "$1" -eq "$1" -a "$1" -ge "0" ] > /dev/null 2>&1  # En caso de error, sentencia falsa (Compara variables como enteros)
	return $?                           				# Retorna si la sentencia anterior fue verdadera
}

#función que comprueba que los nombres introducidos para los procesos no sean iguales
function CompruebaNombre {
	correcto=0;
	for(( i=0 ; i <= ${#proceso[@]} ; i++ )){
		contador=0;
		valor=${proceso[$i]};
		for(( j=0 ; j<= ${#proceso[@]} ; j++ )){
			valor2=${proceso[$j]};
			if [ "$valor" == "$valor2" ] #si los valores del vector coinciden
			then
				contador=`expr $contador + 1`;
			fi
			if [ $contador -gt 1 ] #si el contador es mayor que uno
			then
				echo "Nombres para procesos no válidos"
				echo "Introduzca nombres distintos a los procesos"
				echo " "
				correcto=1; #Valor de la variable a 1 para un valor mal introducido
			else
				correcto=0; #Valor de la variable a 0 para un valor introducido
			fi
		}
	}
	return $correcto
}

#funcion para contar el numero de caracteres que tiene el nombre de un determinado proceso
function longitud {
	declare -a caracteress
	local salida=0
	local posicion=0
	local contador=1
	while [ $salida -eq 0 ]
	do
		valor=$(echo $1 | cut -c$contador )
		if [[ $valor = "" ]]
		then
			salida=1
		else
			caracteress[$posicion]=$valor
		fi
		let contador++
		let posicion++
	done
	return ${#caracteress[@]}
}

#función que comprueba que los nombres introducidos para los procesos no sean iguales
#pido cantidad de procesos que quiere ejecutar



#variables
p=1;              #contador
pp=2;             #contador para cortar datos del fichero
suma_espera=0;
suma_respuesta=0;
espera=0;
respuesta=0;
suma_ejecucion=0;
tinicio=0;  # variable que se guarda el tiempo de inicio del proceso
part1=0
part2=0
part3=0
masprocesos=s
error=0
cambio=1
#vectores
proceso=();
llegada=();
tiempo=();
memoria=();
particion=();
partiti=();
particiontiene=();
ejecutados=();
estadoAnterior=("Soy el 1");



echo "¿Qué quieres hacer?"
echo "1. Nueva ejecución"
echo "2. Última ejecución"

read -p "Introduce 1 o 2: " ultimaonueva

until [[ $ultimaonueva -eq 1 || $ultimaonueva -eq 2 ]]
do
	echo "No te equivoques, uno o dos"
	read -p "Introduce 1 o 2: " ultimaonueva
done



if [[ $ultimaonueva -eq 2 ]]
then
	op=3
else
	#Para particiones
	echo "¿Cómo quieres introducir las particiones?"
	echo "1. Por teclado"
	echo "2. Por fichero"
	read -p "Introduce 1 o 2: " oppart
	until [[ $oppart -eq 1 || $oppart -eq 2 ]]
	do
		echo "Escribe uno o dos"
		read -p "Introduce 1 o 2: " oppart
	done

	masparticion=s
	npart=1;
	memoriamax=(`cat ./particiones.txt | cut -f 5 -d " "`)

	if [[ $oppart -eq 1 ]]
	then
		memoriamax=5000000
		memlibre=$memoriamax
		memtot=$memoriamax
		while [[ "$masparticion" = "s" ]]
		do
			if [[ $memlibre -gt 0 ]]
			then
				echo "Introduce el tamaño de la partición_$npart"
				read particiones[$npart]
				until [[ ${particiones[$npart]} -gt 0 && ${particiones[$npart]} -le $memlibre ]]
				do
					echo "Error"
					read particiones[$npart]
				done
				if [[ $npart -eq 1 ]]
				then
					echo "Particion $npart ${particiones[$npart]}" > ultimasparticiones.txt
				else
					echo "Particion $npart ${particiones[$npart]}" >> ultimasparticiones.txt
				fi
				let memlibre=$memlibre-${particiones[$npart]}
				echo "¿Quieres otra partición? s/n"
				read masparticion
				until [[ $masparticion = "s" || $masparticion = "n" ]]
				do
					echo -n "Escribe s o n: "
					read masparticion
				done
				let npart=$npart+1
			else
				echo "Memoria llena"
				masparticion=n;
			fi
		done
	else
		memoriamax=(`cat ./particiones.txt | cut -f 5 -d " "`)
		lineaspart=(`wc -l particiones.txt | cut -f 1 -d " "`)
		for (( i = 0; i < $lineaspart; i++ ))
		do
			a=(`cat ./particiones.txt | cut -f 2 -d " "`)
			npart=${a[$i]}
			nparti=(`cat ./particiones.txt | cut -f 3 -d " "`)
			particiones[$npart]=${nparti[$i]}
			echo

			if [[ $npart -eq 1 ]]
			then
				echo "Particion $npart ${particiones[$npart]}" > ultimasparticiones.txt
			else
				echo "Particion $npart ${particiones[$npart]}" >> ultimasparticiones.txt
			fi
		done

	fi
	for (( b = 1; b <= ${#particiones[@]}; b++ ))
	do
		echo "Particion $b ${particiones[$b]}"
	done
	#Para procesos
	echo "Tipo de ejecución:"
	echo "1. Manual"
	echo "2. Por archivo"
	read "op"
	until [ $op -eq 1 -o $op -eq 2 ]
	do
		echo "Respuesta introducida no válida"
		echo -n "Introduce una respuesta del menú: "
		read "op"
	done
fi


echo "" >> informeFCFS.txt
echo "" >> informeFCFScolor.txt
while [ $masprocesos == "s" ] #mientras que contador sea menor que cantidad de procesos
do

	if [ $op = "2" ]
	then
		proceso2=(`cat ./entradaFCFS.txt | cut -f 2 -d" "`)
		llegada2=(`cat ./entradaFCFS.txt | cut -f 4 -d" "`)
		tiempo2=(`cat ./entradaFCFS.txt | cut -f 6 -d" "`)
		memoria2=(`cat ./entradaFCFS.txt | cut -f 8 -d" "`)
		npro=20
		until [[ npro -gt 0 ]]
		do
			profich=`wc -l entradaFCFS.txt | cut -f 1 -d " "`
			echo -n "Tiene que ser mayor que cero y menor que $profich : "
			read  npro
		done
		clear
		# cogemos solo los procesos que vamos a ejecutar y los guardamos en nuestro vector
		for (( p = 1; p <= $npro; p++ ))
		do
			nombre=${proceso2[$[$p-1]]}
			Comprobarn $nombre
			proceso[$p]=$nombre;
			#echo "Introduzca el nombre del proceso	$p:${proceso[$p]}"
			llegada[$p]=${llegada2[$[$p-1]]};
			#						echo "Tiempo De llegada del proceso		$p: ${llegada[$p]}"
			tiempo[$p]=${tiempo2[$[$p-1]]}
			#						echo "Tiempo De ejecución del proceso		$p: ${tiempo[$p]}"
			memoria[$p]=${memoria2[$[$p-1]]}
			for ((i=1;i<=${#particiones[@]};i++)){

				for ((j=i;j<=${#particiones[@]};j++)){
					a=${particiones[$i]};
					b=${particiones[$j]};
					if [ $a -lt $b ];
					then
						aux=${particiones[$i]};
						particiones[$i]=${particiones[$j]};
						particiones[$j]=$aux;
					fi
				}
			}

			ax2=${#particiones[@]}+1
			axi2=${#particiones[@]}
			a=$axi2-$ax2
			if [[ ${memoria[$p]} -gt ${particiones[$a]} ]]
			then
				echo "Error"
				echo "La memoria tiene mayor tamaño que la partición más grande"
				exit
			fi

			#echo "Tamaño de memoria del proceso		$p: ${memoria[$p]}
			if [ $p == 1 ]
			then
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}  > ./imprimir.imp
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}  > ./ultimacopia.txt
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}   >> ./informeFCFS.txt
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}   >> ./informeFCFScolor.txt

				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}

			else
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}  >> ./imprimir.imp
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}   >> ./ultimacopia.txt
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}   >> ./informeFCFS.txt
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}   >> ./informeFCFScolor.txt

				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}
			fi
		done
		masprocesos=n
		#algoritmo de ordenacion de los procesos que llegan antes hasta los que llegan mas tarde
		ordenar
	elif [ $op = "3" ]
	then
		npro=0
		proceso2=(`cat ./ultimacopia.txt | cut -f 2 -d" "`)
		llegada2=(`cat ./ultimacopia.txt | cut -f 4 -d" "`)
		tiempo2=(`cat ./ultimacopia.txt | cut -f 6 -d" "`)
		memoria2=(`cat ./ultimacopia.txt | cut -f 8 -d" "`)
		lineaspart=(`wc -l ultimasparticiones.txt | cut -f 1 -d " "`)
		memoriamax=(`cat ./ultimasparticiones.txt | cut -f 5 -d " "`)
		for (( i = 0; i < $lineaspart; i++ ))
		do
			a=(`cat ./ultimasparticiones.txt | cut -f 2 -d " "`)
			npart=a[$i]
			nparti=(`cat ./ultimasparticiones.txt | cut -f 3 -d " "`)
			particiones[$npart]=${nparti[$i]}
		done
		profich=`wc -l ultimacopia.txt | cut -f 1 -d " "`
		for (( p = 1; p <= $profich; p++ ))
		do
			nombre=${proceso2[$[$p-1]]}
			Comprobarn $nombre
			proceso[$p]=$nombre;
			echo "Introduzca el nombre del proceso	$p: ${proceso[$p]}"
			llegada[$p]=${llegada2[$[$p-1]]};
			echo "Tiempo De llegada del proceso		$p: ${llegada[$p]}"
			tiempo[$p]=${tiempo2[$[$p-1]]}
			echo "Tiempo De ejecución del proceso		$p: ${tiempo[$p]}"
			memoria[$p]=${memoria2[$[$p-1]]}
			echo "Tamaño de memoria del proceso		$p: ${memoria[$p]}"
			npro=$npro+1
			if [ $p == 1 ]
			then
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}  > ./imprimir.imp
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}   >> ./informeFCFS.txt
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}   >> ./informeFCFScolor.txt


			else
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}  >> ./imprimir.imp
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}   >> ./informeFCFS.txt
				echo Proceso ${proceso[$p]} Llegada ${llegada[$p]} Ejecucion ${tiempo[$p]} Memoria ${memoria[$p]}   >> ./informeFCFScolor.txt

			fi
		done
		masprocesos=n

		#algoritmo de ordenacion de los procesos que llegan antes hasta los que llegan mas tarde
		ordenar

	elif [ $op = "1" ]
	then
		npro=0
		#algoritmo de ordenacion de particiones
		for ((i=1;i<=${#particiones[@]};i++)){

			for ((j=i;j<=${#particiones[@]};j++)){
				a=${particiones[$i]};
				b=${particiones[$j]};
				if [ $a -lt $b ];
				then
					aux=${particiones[$i]};
					particiones[$i]=${particiones[$j]};
					particiones[$j]=$aux;
				fi

			}
		}

		#algoritmo de ordenacion de los procesos que llegan antes hasta los que llegan mas tarde
		ordenar

		clear
		echo -e "\e[0;35m|\e[0m     Proceso	\e[0;35m|\e[0m    T. Llegada	\e[0;35m|\e[0m   T.Ejecución	\e[0;35m|\e[0m     Memoria	\e[0;35m|\e[0m  "
		echo -e "\e[0;35m_________________________________________________________________\e[0m"
		echo ""
		for (( i = 1; i <= ${#proceso[@]}; i++ ))
		do
			echo -ne "\e[0;35m|\e[0m 	${proceso[$i]}	 \e[0;35m|\e[0m 	${llegada[$i]}	\e[0;35m|\e[0m 	${tiempo[$i]}	\e[0;35m|\e[0m 	${memoria[$i]}	\e[0;35m|\e[0m "
			echo ""
		done
		echo ""


		echo "Introduzca el nombre del proceso_$p:"
		read nombre
		Comprobarn $nombre  #envio nombre a comprobar por la funcion
		while [ $valido -eq 1 ];
		do
			read nombre;
			Comprobarn $nombre  #envio nombre a comprobar por la funcion
		done
		proceso[$p]=$nombre; #añado a el vector ese nombre
		CompruebaNombre $nombre #comprueba que los nombres son distintos
		while [ $correcto -eq 1 ];
		do
			if [ -z $nombre ]
			then
				clear
				read -p "Entrada vacía no válida. Introduce un nombre:" nombre
			else
				read nombre
				Comprobarn $nombre  #envio nombre a comprobar por la funcion
				proceso[$p]=$nombre; #añado a el vector ese nombre
				CompruebaNombre $nombre #comprueba que los nombres son distintos
			fi
		done

		echo ""
		echo "Tiempo De llegada:"
		read llegad
		until [ $llegad -ge 0 ];
		do
			echo "No se pueden introducir tiempos de llegada negativos"
			echo "Introduce un nuevo tiempo de llegada"
			read llegad
		done

		llegada[$p]=$llegad;   #añado al vector ese numero

		echo ""
		echo "Tiempo De Ejecución_$p"
		read tiemp
		until [ $tiemp -ge 0 ];
		do
			echo "No se pueden introducir tiempos de ejecución negativos"
			echo "Introduce un nuevo tiempo de ejecución"
			read tiemp
		done

		tiempo[$p]=$tiemp;   #añado al vector ese numero

		echo ""
		echo "Memoria de proceso_$p"
		read memo
		ax=${#particiones[@]}+1
		axi=${#particiones[@]}
		ultraxiliar=$axi-$ax
		until [ $memo -gt 0 -a $memo -le ${particiones[$ultraxiliar]} ]
		do
			echo "No se pueden introducir memoria negativa o superior a la partición máxima (${particiones[$ultraxiliar]})"
			echo "Introduce un nuevo tamaño de memoria"
			read memo
		done

		memoria[$p]=$memo;   #añado al vector ese numero

		echo ""
		echo Proceso $nombre Llegada $llegad Ejecucion $tiemp Memoria $memo >> informeFCFS.txt
		echo Proceso $nombre Llegada $llegad Ejecucion $tiemp Memoria $memo >> informeFCFScolor.txt
		if [[ $p -eq 1 ]]
		then
			echo Proceso $nombre Llegada $llegad Ejecucion $tiemp Memoria $memo > ultimacopia.txt
			echo Proceso $nombre Llegada $llegad Ejecucion $tiemp Memoria $memo > imprimir.imp
		else
			echo Proceso $nombre Llegada $llegad Ejecucion $tiemp Memoria $memo >> ultimacopia.txt
			echo Proceso $nombre Llegada $llegad Ejecucion $tiemp Memoria $memo >> imprimir.imp
		fi

		#algoritmo de ordenacion de los procesos que llegan antes hasta los que llegan mas tarde
		ordenar
		npro=$npro+1
	clear
	echo -e "\e[0;35m|\e[0m     Proceso	\e[0;35m|\e[0m    T. Llegada	\e[0;35m|\e[0m   T.Ejecución	\e[0;35m|\e[0m     Memoria	\e[0;35m|\e[0m  "
	echo -e "\e[0;35m_________________________________________________________________\e[0m"
	echo ""
	for (( i = 1; i <= ${#proceso[@]}; i++ ))
	do
		echo -ne "\e[0;35m|\e[0m 	${proceso[$i]}	 \e[0;35m|\e[0m 	${llegada[$i]}	\e[0;35m|\e[0m 	${tiempo[$i]}	\e[0;35m|\e[0m 	${memoria[$i]}	\e[0;35m|\e[0m "
		echo ""
	done

	echo ""

	echo "¿Quieres más procesos? s/n"
	read masprocesos
	until [[ $masprocesos == "s" || $masprocesos == "n" ]]
	do
		echo "Escoge s/n"
		read masprocesos
	done

fi

p=`expr $p + 1` #incremento el contador
pp=`expr $pp + 1` #incremento el contador

done

#algoritmo de ordenacion de particiones
for ((i=1;i<=${#particiones[@]};i++)){

	for ((j=i;j<=${#particiones[@]};j++)){
		a=${particiones[$i]};
		b=${particiones[$j]};
		if [ $a -lt $b ];
		then
			aux=${particiones[$i]};
			particiones[$i]=${particiones[$j]};
			particiones[$j]=$aux;
		fi

	}
}

echo ""
echo ""
for (( i = 1; i <= ${#particiones[@]}; i++ ))
do
	echo "Esta es la memoria de la particion $i ${particiones[$i]}"
done
echo ""
echo ""


read -p "Pulse intro para continuar "
echo "" >> informeFCFS.txt
echo "" >> informeFCFScolor.txt
echo "" >> imprimir.imp

echo -e "\e[0;33m     Proceso         Llegada        Ejecución         Espera        Respuesta        Memoria        Partición  \e[0m" >> ./imprimir.imp

for (( i = 1; i <= ${#particiones[@]}; i++ ))
do
	pocupadas[$i]=0
	procupadas[$i]=0
	ocupadas[$i]=0
	sal[$i]=0
	particiontiene[$i]=-1
done
for (( p = 0; p <= ${#memoria[@]}; p++ ))
do
	espera[$p]=0
	entrada[$p]=0
	esperando[$p]=0
	respondo[$p]=0
	estado[$p]="Esperando"
done

salida=x;

hasalido=0;
i=1;
reloj=${llegada[1]};
xelux=${llegada[1]};
saliente=0;
salidaAnterior=0
clear
declare -a historial
declare -a historialExtra
while [[ $salida != "s" ]]
do
	for (( i = 1; i <= ${#llegada[@]}; i++ ))
	do
		boleano=1;
		prohaentrado[0]=1
		if [[ prohaentrado[`expr $i - 1`] -ne 1 ]] #comprobamos que el anterior haya entrado
		then
			boleano=0;
		fi
		if [[ sal[$i] -ne 1 && procupadas[$i] -ne 1 && $boleano -eq 1 ]]
		then
			contador=0
			if [[ ${llegada[$i]} -le $reloj ]]
			then
				for (( j = ${#particiones[@]}; j > 0; j-- ))
				do
					if [[ ${memoria[$i]} -le ${particiones[$j]} && ${pocupadas[$j]} -eq 0 ]]
					then
						pocupadas[$j]=1
						procupadas[$i]=1
						prohaentrado[$i]=1
						ocupadas[$j]=$i
						entrada[$i]=$reloj
						partiti[$i]=$j
						particiontiene[$j]=$i
						estado[$i]="En memoria"
						j=0
					else
						if [[ ${pocupadas[$j]} -eq 0 ]]
						then
							((contador++))
						fi
					fi
				done
			fi
		fi
		if [[ ${estado[$i]} == "En memoria" && ${estado[`expr $i - 1`]} == "Finalizado" ]]
		then
			estado[$i]="En ejecución"
			ejecutados[${#ejecutados[@]}]=$i
		elif [[ $i -eq 1 ]]
		then
			estado[$i]="En ejecución"
			ejecutados[${#ejecutados[@]}]=$i
		fi
		#${#particiones[@]};
		if [[ ${esperando[$i]} -lt 0 && ${llegada[$i]} -gt $reloj ]]
		then
			estado[$i]="No ha llegado"
		else
			if [[ ${procupadas[$i]} -ne 1 && ${llegada[$i]} -lt $reloj && ${estado[$i]} != "Finalizado" ]]
			then
				estado[$i]="Esperando"
			fi
		fi

		if [[ $reloj -ge 0 ]]
		then
			if [[ ${estado[$i]} = "No ha llegado" || ${estado[$i]} = "Esperando" || ${estado[$i]} = "En memoria" ]]
			then
				let entrada[$i]=${entrada[$i]}+1
			fi
		fi

		
		saltartelo=0;
		if [[ $contador -eq ${#particiones[@]} && ${procupadas[$i]} -eq 0 ]]
		then
			saltartelo=1
		fi
		if [[ $saltartelo -eq 1 ]]
		then
			echo "El proceso no entra en ninguna partición"
		fi

		if [[ $saltartelo -eq 0 ]]
		then
			for (( x = 1; x <= ${#particiones[@]}; x++ ))
			do
				if [[ ${pocupadas[$x]} -eq 1 ]]
				then
					dentro=${ocupadas[$x]}
					if [[ ${estado[$dentro]} == "En ejecución" ]]
					then
						let out=${entrada[$dentro]}+${tiempo[$dentro]}
						let aups=$reloj-$out
						if [[ $aups -ge 0 ]]
						then
							pocupadas[$x]=0
							procupadas[$dentro]=0
							ocupadas[$x]=0
							sal[$dentro]=1
							particiontiene[$x]=-1
						fi
					fi
				fi
			done

			hasalido=0
			for (( f = 1; f <= ${#memoria[@]}; f++ ))
			do
				if [[ ${sal[$f]} -eq 1 ]]
				then
					((hasalido++))
					estado[$f]="Finalizado"
				fi
			#	salidaAnterior=$hasalido
			done
			if [[ $hasalido -ge ${#memoria[@]} ]]
			then
				salida=s
			fi
		fi
	done
	for (( j=1;j<${#estado[@]};j++ )) {
		if [[ ${estado[$j]} != "Finalizado" && ${estado[$j]} != "En ejecución" ]];then
			let esperando[$j]=$reloj-${llegada[$j]}
		elif [[ ${estado[$j]} = "En ejecución" ]];then
			if [[ $salidaAnterior -ne $hasalido ]];then
				let esperando[$j]++
			fi
		fi	
	}
	salidaAnterior=$hasalido



	cambios
	arreglar
	if [ $cambio -eq 1 ]
	then
		for((i=1;i<=${#proceso[@]};i++)){
			indice=$i
			while [ $indice -ge ${#colores[@]} ]
			do
				indice=$(expr  $indice - ${#colores[@]})
			done
			color=${colores[$indice]}
			if [ $indice -eq 0 ];then
				color='\e[1;33m'
			fi
			arreglar

			esp=${esperando[$i]}
			res=${respondo[$i]}
			tie=${tiempo[$i]}
			res1=`expr $esp + $tie`
			if [[ $npro -ge 1 ]];then
				if [[ ${llegada[$i]} -ne $xelux ]]
				then
					if [[ ${estado[$i]} = "En memoria" || ${estado[$i]} = "En ejecución" ]];then
						res=$esp
					else
						let res++
					fi
				fi
			fi
			if [[ ${estado[$i]} = "No ha llegado" ]];then
				esp="-"
				res="-"
			fi
			if [[ ${estado[$i]} = "Esperando" ]];then
				if [[ $esp -lt 0 ]]; then
					esp=0
				fi
			fi
			if [[ $i -eq 1 ]]
			then
				echo -e "\e[0;33m     Proceso         Llegada        Ejecución         Espera        Respuesta        Memoria        Partición            Estado  \e[0m"
				echo "     Proceso         Llegada        Ejecución         Espera        Respuesta        Memoria        Partición            Estado  " >> ./informeFCFS.txt
				echo -e "\e[0;33m     Proceso         Llegada        Ejecución         Espera        Respuesta        Memoria        Partición            Estado  \e[0m" >> ./informeFCFScolor.txt

			fi
			if [[ ${estado[$i]} = "En ejecución" || ${estado[$i]} = "En memoria" || ${estado[$i]} = "No ha llegado" || ${estado[$i]} = "Esperando" ]];then
			echo -e "\e[0;35m |\e[0m\t$color${proceso[$i]}\t\e[0;35m |\e[0m\t$color${llegada[$i]}\t\e[0;35m |\e[0m\t$color${tiempo[$i]}\t\e[0;35m |\e[0m\t$color$esp\t\e[0;35m |\e[0m\t$color$res\t\e[0;35m |\e[0m\t$color${memoria[$i]}\t\e[0;35m |\e[0m\t$color${partiti[$i]}\t\e[0;35m |\e[0m\t${estado[$i]}\t\e[0;35m |\e[0m\t"
			echo -e "|\t${proceso[$i]}\t|\t${llegada[$i]}\t|\t${tiempo[$i]}\t|\t$esp\t|\t$res\t|\t${memoria[$i]}\t|\t${partiti[$i]}\t|\t${estado[$i]}\t|\t" >> ./informeFCFS.txt
			echo -e "\e[0;35m |\e[0m\t$color${proceso[$i]}\t\e[0;35m |\e[0m\t$color${llegada[$i]}\t\e[0;35m |\e[0m\t$color${tiempo[$i]}\t\e[0;35m |\e[0m\t$color$esp\t\e[0;35m |\e[0m\t$color$res\t\e[0;35m |\e[0m\t$color${memoria[$i]}\t\e[0;35m |\e[0m\t$color${partiti[$i]}\t\e[0;35m |\e[0m\t${estado[$i]}\t\e[0;35m |\e[0m\t" >> ./informeFCFScolor.txt
			fi
			if [[ ${estado[$i]} = "Finalizado" ]];then
			echo -e "\e[0;35m |\e[0m\t$color${proceso[$i]}\t\e[0;35m |\e[0m\t$color${llegada[$i]}\t\e[0;35m |\e[0m\t$color${tiempo[$i]}\t\e[0;35m |\e[0m\t$color$esp\t\e[0;35m |\e[0m\t$color$res1\t\e[0;35m |\e[0m\t$color${memoria[$i]}\t\e[0;35m |\e[0m\t$color${partiti[$i]}\t\e[0;35m |\e[0m\t${estado[$i]}\t\e[0;35m |\e[0m\t"
			echo -e "|\t${proceso[$i]}\t|\t${llegada[$i]}\t|\t${tiempo[$i]}\t|\t$esp\t|\t$res1\t|\t${memoria[$i]}\t|\t${partiti[$i]}\t|\t${estado[$i]}\t|\t" >> ./informeFCFS.txt
			echo -e "\e[0;35m |\e[0m\t$color${proceso[$i]}\t\e[0;35m |\e[0m\t$color${llegada[$i]}\t\e[0;35m |\e[0m\t$color${tiempo[$i]}\t\e[0;35m |\e[0m\t$color$esp\t\e[0;35m |\e[0m\t$color$res1\t\e[0;35m |\e[0m\t$color${memoria[$i]}\t\e[0;35m |\e[0m\t$color${partiti[$i]}\t\e[0;35m |\e[0m\t${estado[$i]}\t\e[0;35m |\e[0m\t" >> ./informeFCFScolor.txt

			fi

		}
		echo
		echo >> ./informeFCFS.txt
		echo >> ./informeFCFScolor.txt
		echo -e "\e[0;36m		     Tiempo: $reloj \e[0m"
		echo "		Tiempo: $reloj" >> ./informeFCFS.txt
		echo -e "\e[0;36m		     Tiempo: $reloj \e[0m" >> ./informeFCFScolor.txt
		echo ""
		echo "" >> ./informeFCFS.txt
		echo "" >> ./informeFCFScolor.txt
		echo ""
		echo "" >> ./informeFCFS.txt
		echo "" >> ./informeFCFScolor.txt
		echo -n " "
		echo -n " " >> ./informeFCFS.txt
		echo -n " " >> ./informeFCFScolor.txt

		for (( i=1 ; i <= ${#particiones[@]} ; i++ ))
		do
			if [[ ${particiontiene[$i]} -eq -1 ]]
			then
				declare -i caracteres=0
				echo -n " "
				for (( j=0 ; j < ${particiones[$i]}-$caracteres ; j++ ))
				do
					echo -n " "
					echo -n " " >> ./informeFCFS.txt
					echo -n " " >> ./informeFCFScolor.txt

				done
			else
				longitud ${proceso[${particiontiene[$i]}]}
				caracteres=$?
				echo -n "${proceso[${particiontiene[$i]}]}"
				echo -n "${proceso[${particiontiene[$i]}]}" >> ./informeFCFS.txt
				echo -n "${proceso[${particiontiene[$i]}]}" >> ./informeFCFScolor.txt
				echo -n " "
				echo -n " " >> ./informeFCFS.txt
				echo -n " " >> ./informeFCFScolor.txt
				for (( j=0 ; j < ${particiones[$i]}-$caracteres ; j++ ))
				do
					echo -n " "
					echo -n " " >> ./informeFCFS.txt
					echo -n " " >> ./informeFCFScolor.txt

				done
				echo -n ""
				echo -n "" >> ./informeFCFS.txt
				echo -n "" >> ./informeFCFScolor.txt

			fi
		done

		echo ""
		echo "" >> ./informeFCFS.txt
		echo "" >> ./informeFCFScolor.txt
		echo -n " "
		echo -n " " >> ./informeFCFS.txt
		echo -n " " >> ./informeFCFScolor.txt

		for ((i=1 ; i <= ${#particiones[@]} ; i++ ))
		do
			declare -i caracteres=1
			if [[ ${particiones[$i]} -gt 99 ]]
			then
				caracteres=15
			elif [[ ${particiones[$i]} -gt 9 ]]
			then
				caracteres=14
			fi

			echo -n "Particion$i: ${particiones[$i]}"
			echo -n "Particion$i: ${particiones[$i]}" >> ./informeFCFS.txt
			echo -n "Particion$i: ${particiones[$i]}" >> ./informeFCFScolor.txt
			if [[ $caracteres -eq 1 || $caracteres -eq 3 ]]
			then
				echo -n " "
				echo -n " " >> ./informeFCFS.txt
				echo -n " " >> ./informeFCFScolor.txt
			else
				echo -n " "
				echo -n " " >> ./informeFCFS.txt
				echo -n " " >> ./informeFCFScolor.txt
			fi
			for (( j=0 ; j < ${particiones[$i]}-$caracteres ; j++ ))
			do
				echo -n " "
				echo -n " " >> ./informeFCFS.txt
				echo -n " " >> ./informeFCFScolor.txt

			done
			echo -n ""
			echo -n "" >> ./informeFCFS.txt
			echo -n "" >> ./informeFCFScolor.txt
		done
		echo ""
		echo "" >> ./informeFCFS.txt
		echo "" >> ./informeFCFScolor.txt
		for (( i=1 ; i<= ${#particiones[@]} ; i++ ))
		do
			echo -ne "\e[0;32m+\e[0m"
			echo -n "+" >> ./informeFCFS.txt
			echo -ne "\e[0;32m+\e[0m" >> ./informeFCFScolor.txt
			for ((j=1 ; j<=${particiones[$i]} ;j++ ))
			do
				echo -ne "\e[0;32m-\e[0m"
				echo -n "-" >> ./informeFCFS.txt
				echo -ne "\e[0;32m-\e[0m" >> ./informeFCFScolor.txt
			done
		done
		echo -ne "\e[0;32m+\e[0m"
		echo -n "+" >> ./informeFCFS.txt
		echo -ne "\e[0;32m+\e[0m" >> ./informeFCFScolor.txt
		echo ""
		echo "" >> ./informeFCFS.txt
		echo "" >> ./informeFCFScolor.txt
		echo -ne "\e[0;32m|\e[0m"
		echo -n "|" >> ./informeFCFS.txt
		echo -ne "\e[0;32m|\e[0m" >> ./informeFCFScolor.txt
		for ((i=1 ; i<= ${#particiones[@]} ; i++ ))
		do
			declare -i ocupadodibujo
			declare -i libredibujo

			if [[ ${particiontiene[$i]} -eq -1 ]]
			then
				ocupadodibujo=0
				libredibujo=${particiones[$i]}
			else
				actualdibujo=${particiontiene[$i]}
				ocupadodibujo=${memoria[$actualdibujo]}
				let libredibujo=${particiones[$i]}-$ocupadodibujo
			fi
			for (( j=0; j<$ocupadodibujo ; j++))
			do
				indice=$actualdibujo
				while [ $indice -ge ${#colores[@]} ]
				do
					indice=$(expr  $indice - ${#colores[@]})
				done
				color=${colores[$indice]}
				if [ $indice -eq 0 ];then
					color='\e[1;33m'
				fi
				echo -ne "$color#\e[0m"
				echo -n "#" >> ./informeFCFS.txt
				echo -ne "$color#\e[0m" >> ./informeFCFScolor.txt
			done
			for (( j=0; j<$libredibujo ; j++))
			do
				echo -ne "\e[0;37m·\e[0m"
				echo -n "·" >> ./informeFCFS.txt
				echo -ne "\e[0;37m·\e[0m" >> ./informeFCFScolor.txt
			done
			echo -ne "\e[0;32m|\e[0m"
			echo -n "|" >> ./informeFCFS.txt
			echo -ne "\e[0;32m|\e[0m" >> ./informeFCFScolor.txt
		done
		echo ""
		echo "" >> ./informeFCFS.txt
		echo "" >> ./informeFCFScolor.txt
		for (( i=1 ; i<= ${#particiones[@]} ; i++ ))
		do
			echo -ne "\e[0;32m+\e[0m"
			echo -n "+" >> ./informeFCFS.txt
			echo -ne "\e[0;32m+\e[0m" >> ./informeFCFScolor.txt
			for ((j=1 ; j<=${particiones[$i]} ;j++ ))
			do
				echo -ne "\e[0;32m-\e[0m"
				echo -n "-" >> ./informeFCFS.txt
				echo -ne "\e[0;32m-\e[0m" >> ./informeFCFScolor.txt
			done
		done
		echo -ne "\e[0;32m+\e[0m"
		echo -n "+" >> ./informeFCFS.txt
		echo -ne "\e[0;32m+\e[0m" >> ./informeFCFScolor.txt
		echo
		echo
		echo
		echo >> ./informeFCFS.txt
		echo >> ./informeFCFS.txt
		echo >> ./informeFCFS.txt
		echo >> ./informeFCFScolor.txt
		echo >> ./informeFCFScolor.txt
		echo >> ./informeFCFScolor.txt
		if [ ${#historial[@]} -ne 0 ]
		then
			echo -e "\e[0;33mHistorial de Procesos\e[0m"
			echo -e "\e[0;33mHistorial de Procesos\e[0m" >> ./informeFCFScolor.txt
			echo "Historial de Procesos" >> ./informeFCFS.txt

			for((i=0;i<${#historial[@]}; ++i)){
				if [ $i -gt 0 -a ${historial[`expr $i - 1`]} != ${historial[$i]} ]
				then
					echo -n " |  "
					echo -n " |  " >> ./informeFCFS.txt
					echo -n " |  " >> ./informeFCFScolor.txt

				fi
				indice=${historialExtra[$i]}
				while [ $indice -ge ${#colores[@]} ]
				do
					indice=$(expr  $indice - ${#colores[@]})
				done
				color=${colores[$indice]}
				if [ $indice -eq 0 ];then
					color='\e[1;33m'
				fi
				echo -ne "$color ${historial[$i]} ${colores[0]}"
				echo -ne "$color ${historial[$i]} ${colores[0]}">> ./informeFCFScolor.txt
				echo -n " ${historial[$i]} " >>./informeFCFS.txt
			}
		fi
		echo
		echo
		echo
		echo >> ./informeFCFS.txt
		echo >> ./informeFCFS.txt
		echo >> ./informeFCFS.txt
		echo >> ./informeFCFScolor.txt
		echo >> ./informeFCFScolor.txt
		echo >> ./informeFCFScolor.txt


		read -p "Pulse intro para continuar"

		clear
	fi
	for((i=1;i<=${#proceso[@]};i++)){
		if [[ ${estado[$i]} != "Finalizado" && ${estado[$i]} != "No ha llegado" ]]
		then
			let respondo[$i]++
		fi
	}

	let reloj=$reloj+1
	Procesoejecutado
	procesoaux=$?
	if [ $procesoaux -ne 255 ]
	then
		historial[${#historial[@]}]=${proceso[$procesoaux]}
		historialExtra[${#historialExtra[@]}]=$procesoaux
	fi

done
echo -e "     Proceso         Llegada        Ejecución         Espera        Respuesta        Memoria        Partición  " >> ./informeFCFS.txt
echo -e "     Proceso         Llegada        Ejecución         Espera        Respuesta        Memoria        Partición  " >> ./informeFCFScolor.txt




for ((i=1;i<=${#tiempo[@]};i++))
do


	for (( j = ${#particiones[@]}; j > 0; j-- ))
	do

		if [[ ${memoria[$j]} -le ${particiones[$j]} && ${pocupadas[$j]} -eq 0 ]]
		then
			pocupadas[$j]=1
			estado[$i]="En memoria"
		fi
	done

	if [ ${tiempo[$i]} -eq 0 ]    #Si la posición es 0, QUE NO EXISTE, pasa al siguiente sin hacer nada entonces T.ejecucion = 0
	then
		espera=0;
		respuesta=${tiempo[0]};
	else





		if [ $i -eq 1 ]
		then
			tinicio=${llegada[$i]};
			espera=0;
			respuesta=${tiempo[$i]};
			suma_ejecucion=`expr $respuesta + $tinicio`
		else
			espera=`expr $suma_ejecucion - ${llegada[$i]}`          #el tiempo de espera del proceso es la suma de los tiempos de ejecucion hasta el proceso anterior menos el tiempo que tarda en llegar el proceso
			suma_ejecucion=`expr $suma_ejecucion + ${tiempo[$i]}` #sumatorio de los tiempos de ejecucion
			respuesta=`expr $suma_ejecucion - ${llegada[$i]}`  #el tiempo de respuesta (finalizacion) es el sumatorio de los tiempos de ejecucion menos el tiempo de llegada del proceso
		fi

	fi
	let respondo[$i]=${esperando[$i]}+${tiempo[$i]}
	suma_espera=`expr $suma_espera + ${esperando[$i]}`
	promedio_espera=`expr $suma_espera / ${#tiempo[@]}`

	suma_respuesta=`expr $suma_respuesta + ${respondo[$i]}`
	promedio_respuesta=`expr $suma_respuesta / ${#tiempo[@]}`


	indice=$i
	while [ $indice -ge ${#colores[@]} ]
	do
		indice=$(expr  $indice - ${#colores[@]})
	done
	color=${colores[$indice]}
	if [ $indice -eq 0 ];then
		color='\e[1;33m'
	fi


	echo -e "\e[0;35m |\e[0m\t$color${proceso[$i]}\t\e[0;35m |\e[0m\t$color${llegada[$i]}\t\e[0;35m |\e[0m\t$color${tiempo[$i]}\t\e[0;35m |\e[0m\t$color${esperando[$i]}\t\e[0;35m |\e[0m\t$color${respondo[$i]}\t\e[0;35m |\e[0m\t$color${memoria[$i]}\t\e[0;35m |\e[0m\t$color${partiti[$i]}\t\e[0;35m |\e[0m\t \e[0m" >> ./imprimir.imp



	echo -e " |\t${proceso[$i]}\t|\t${llegada[$i]}\t|\t${tiempo[$i]}\t|\t${esperando[$i]}\t|\t${respondo[$i]}\t|\t${memoria[$i]}\t|\t${partiti[$i]}\t|\t   " >> ./informeFCFS.txt



	echo -e "\e[0;35m |\e[0m\t$color${proceso[$i]}\t\e[0;35m |\e[0m\t$color${llegada[$i]}\t\e[0;35m |\e[0m\t$color${tiempo[$i]}\t\e[0;35m |\e[0m\t$color${esperando[$i]}\t\e[0;35m |\e[0m\t$color${respondo[$i]}\t\e[0;35m |\e[0m\t$color${memoria[$i]}\t\e[0;35m |\e[0m\t$color${partiti[$i]}\t\e[0;35m |\e[0m\t \e[0m" >> ./informeFCFScolor.txt

	echo ""
done


#promedios
echo "" >> imprimir.imp
echo "" >> informeFCFS.txt
echo "" >> informeFCFScolor.txt
echo -e "\e[0;31m | T.espera medio:\e[0m $promedio_espera  \e[0;31m   | T.retorno medio:\e[0m $promedio_respuesta " >> ./imprimir.imp
echo " * T.espera medio: $promedio_espera  -  * T.retorno medio: $promedio_respuesta  " >> ./informeFCFS.txt
echo -e "\e[0;31m | T.espera medio:\e[0m $promedio_espera  \e[0;31m   | T.retorno medio:\e[0m $promedio_respuesta " >> ./informeFCFScolor.txt



cat ./imprimir.imp
read -p "¿Quieres abrir el informe? ([s],n): " datos
if [ -z "${datos}" ]
then
	datos="s"
fi
while [ "${datos}" != "s" -a "${datos}" != "n" ]
do
	read -p "Entrada no válida, vuelve a intentarlo. ¿Quieres abrir el informe? ([s],n): " datos
	if [ -z "${datos}" ]
	then
		datos="s"
	fi
done
if [ $datos = "s" ]
then
	read -p "Con color o sin color ([c],s): " datos
	if [ -z "${datos}" ]
	then
		datos="s"
	fi
	while [ "${datos}" != "c" -a "${datos}" != "s" ]
	do
		read -p "Entrada no válida, vuelve a intentarlo. Con color o sin color ([c],s): " datos
		if [ -z "${datos}" ]
		then
			datos="c"
		fi
	done
	if [ $datos = "c" ]
	then
		cat informeFCFScolor.txt
	else
		cat informeFCFS.txt
	fi
fi
