# -*- coding: utf-8 -*-
"""
Created on Tue Sep 25 17:42:41 2018

@author: Jorge
"""

import numpy as np
import copy

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
            """
    vecper = [4,1,6,5,7,8,2,3] doc5 
    """
    return vecper
                   
#Inicializar matrizf a 0
def matrizf_cero(matrizd,matrizf):
    matrizf = np.zeros(matrizd.shape, dtype=int)
    return matrizf

#Funcion aleatorios
def f(vecper,nmaq,matrizf,matrizd):
    matrizf = matrizf_cero(matrizd,matrizf)
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

def f_max(matrizf,vecper,nmaq):
    return matrizf[vecper[len(vecper)-1]-1][nmaq-1]

def genera_vecinos(vecper):
    copia = copy.deepcopy(vecper)  
    for i in np.arange(len(vecper)):
        for j in np.arange(len(vecper)):
            if i != j:
                copia[i], copia[j] = copia[j], copia[i]
                yield copia
                copia = copy.deepcopy(vecper)

def encontrar_primer_mejor(vecper,matrizf,matrizd,nmaq):
    matrizfinal = f(vecper,nmaq,matrizf,matrizd)
    inicial = f_max(matrizfinal,vecper,nmaq)
    for per in genera_vecinos(vecper):
        matrizf2 = f(per, nmaq, [], matrizd)
        actual = f_max(matrizf2,per,nmaq)
        if actual<inicial:
            matrizfmax = matrizf2
            matrizf, inicial, vecper = encontrar_primer_mejor(per, matrizfmax, matrizd,nmaq)
    return matrizf, inicial, vecper

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
        
    vecper = vec_permutacion(vecper,ntarea)
    

    #calculo maximo
    matrizfmax, maximo, permuta = encontrar_primer_mejor(vecper,matrizf,matrizd,nmaq)
  
    print("")
    print("FMáxima:")
    print(matrizfmax)
    print("Valor máximo:")
    print(maximo)
    print("Vector permutación: ")
    print(permuta)
