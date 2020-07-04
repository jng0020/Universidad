# -*- coding: utf-8 -*-
"""
Created on Tue Sep 25 17:42:41 2018

@author: Jorge
"""

# T0 temperatura inicial: fmax del primer mejor
# alfpha: enfrimiento mirar diapositivas final
# L: Repeticiones
# TF temperatura final: la devolvemos

import numpy as np
import math
import random
import PrimeroMejor_NavarroJorge_UbiernaMario as primermejor

import warnings
warnings.filterwarnings("ignore")

def leer_fichero():
    print("¿Cómo se llama el fichero?")
    nombre = input()
    ObjArchivo = open(nombre,'r')
    
    linea = ObjArchivo.readline() #lee la primera linea
    aux = linea.split(" ") 
    ntarea = int(aux[0]) #me quedo con el primer elemento
    nmaq = int(aux[1]) #me quedo con el segundo
    
    matrizd = np.genfromtxt(nombre,int,skip_header=1) #Pasar de sting a int esa linea
    matrizd = np.delete(matrizd,np.s_[::2],1)
    ObjArchivo.close  # Cierra archivo
    return ntarea,nmaq,matrizd

#Generación del vector permutación
def vec_permutacion(vecper,ntarea):
    while not len(vecper)==ntarea:
        valorA = np.random.randint(1,ntarea+1)
        if not valorA in vecper:
            vecper.append(valorA)
    #│vecper = [4, 1, 3, 5, 2] 
    return vecper
                   
#Inicializar matrizf a 0
def matrizf_cero(matrizd,matrizf):
    matrizf = np.zeros(matrizd.shape, dtype=int)
    return matrizf

#Funcion aleatorios
def f(vecper,nmaq,matrizf,matrizd):
    for i in range(len(vecper)):
        for j in range(nmaq):
            if i == 0 and j==0:
                matrizf[vecper[i]-1][j] = matrizd[vecper[i]-1][j]
            elif i == 0 and j==1:
                matrizf[vecper[i]-1][j] = matrizd[vecper[i]-1][j]+matrizd[vecper[i]-1][j-1]
            else:
                if j==0:
                    matrizf[vecper[i]-1][j] = matrizf[vecper[i-1]-1][j]+matrizd[vecper[i]-1][j]
                else:
                    matrizf[vecper[i]-1][j] = np.maximum(matrizf[vecper[i]-1][j-1],matrizf[vecper[i-1]-1][j])+matrizd[vecper[i]-1][j]
    return matrizf 

#Funcion Recocido
def f_recocido(ntarea, nmaq, matrizd, t_incial = 100, alfa = 0.9, intentos = 20, t_final = 0.1):
    t_actual = t_incial
    sol_actual = vec_permutacion([], ntarea)
    f_actual = matrizf_cero(matrizd,[])
    while t_actual >= t_final:
        for i in range(intentos):
            sol_candidata = random.choice(np.array([x for x in primermejor.genera_vecinos(sol_actual)]))
            deltha = f_max(f_actual, sol_candidata, nmaq) - f_max(f_actual, sol_actual, nmaq)
            if (random.uniform(0,1) < math.e**(-deltha/t_actual)) or (deltha<0):
                sol_actual = sol_candidata
                f_actual = f(sol_actual, nmaq, f_actual, matrizd)
                fmax_actual = f_max(f_actual, sol_actual, nmaq)
        t_actual = alfa * t_actual
    
    #Hacer la búsqueda local pasandole sol_actual y f_actual
    matrizfmax, fmax_actual, sol_actual = primermejor.encontrar_primer_mejor(sol_actual, f_actual, matrizd, nmaq)

    return matrizfmax, fmax_actual, sol_actual


def f_max(matrizf,vecper,nmaq):
    return matrizf[vecper[len(vecper)-1]-1][nmaq-1]


if __name__=="__main__":
    ntarea = 0 #numero de tareas
    nmaq = 0 #numero de maquinas
    matrizd = [] #matriz dij
    matrizf = [] #matriz fij
    vecper = [] #vector permutación
    
    ntarea, nmaq, matrizd = leer_fichero()
    
    print("")
    print("Matriz Inicial: ")
    for i in matrizd:
        print(i)
    
    #calculo maximo
    matrizfmax, maximo, permuta = f_recocido(ntarea, nmaq, matrizd)
  
    print("")
    print("FMáxima:")
    print(matrizfmax)
    print("Valor máximo:")
    print(maximo)
    print("Vector permutación: ")
    print(permuta)