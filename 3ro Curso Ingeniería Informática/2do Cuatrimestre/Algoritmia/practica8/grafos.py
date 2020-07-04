
# coding: utf-8

# ## Algoritmia
# ### Práctica 2
# El objetivo de esta práctica es definir clases y realizar implementaciones básicas del tipo grafo.

# Se pide la implementación de las clases y/o funciones que aparecen a continuación. 
# 
# Las instrucción "pass" que aparecen en el cuerdo de las clases o funciones, se debe sustituir por la implementación adecuada. 
# 
# Para cada clase o función que se pide se proporciona una o más funciones con algunos tests. 
# 
# Al llamar a las funciones de test no debería saltar ninguna aserción.

# ### Autores:  Jorge Navarro González, Mario Ubierna San Mamés
#                 

# ### Clase abstracta para Grafos

# In[24]:


from abc import ABCMeta, abstractmethod

class GrafoAbstracto(metaclass=ABCMeta):
    """Clase abstracta para trabajar con Grafos."""
    
    def __init__(self, dirigido = False):
        """Constructor. El argumento indica si el grafo es dirigido"""
        self._dirigido = dirigido

    def dirigido(self):
        """Indica si el grafo es o no dirigido"""
        return self._dirigido

    @abstractmethod
    def __len__( self ):
        """Número de nodos del grafo."""

    @abstractmethod
    def num_arcos(self):
        """Devuelve el número de arcos"""

    @abstractmethod       
    def inserta(self, nodo, destino = None, etiqueta = 1):
        """
        Inserta un nodo al grafo (si destino es None) o un arco.
        Si el arco ya existía se actualiza su etiqueta.
        Si alguno de los nodos del arco no está en el grafo, se inserta.
        Se supone que None no es una etiqueta válida.
        """
    @abstractmethod       
    def __contains__(self, nodo):
        """Indica si el nodo está en el grafo."""      
        
    @abstractmethod        
    def __getitem__(self, arco):
        """Dado un arco (un par de nodos) devuelve la etiqueta si el arco está
        en el grafo, en caso contrario devuelve None"""

    @abstractmethod        
    def __iter__(self):
        """Iterador sobre los nodos del grafo"""

    @abstractmethod
    def vecinos(self, origen):
        """Devuelve un iterable de los pares (destino,etiqueta) para un nodo 
        origen dado"""


# ### Implementación basada en matrices de adyacencia
# Realizamos una implementación basada en [matrices de adyacencia](https://youtu.be/t-FHxHnUEoc)

# In[29]:


class GrafoMatriz(GrafoAbstracto):
    """
    Implementación del tipo Grafo utilizando una matriz de adyacencia para 
    almacenar la información de los arcos.
    La matriz podría ser una lista de lista.
    """
    def __init__(self, dirigido=False):
        """Constructor. El argumento indica si el grafo es dirigido"""
        super().__init__(dirigido)
        self.numero_nodos = 0
        self.numero_arcos = 0
        self.grafo = []

    def __len__( self ):
        """Número de nodos del grafo."""
        return self.numero_nodos

    def num_arcos(self):
        """Devuelve el número de arcos"""
        return self.numero_arcos
    
    def _crea(self,nodo):
        if not nodo in self:
            self.grafo.append([nodo,[]])
            self.numero_nodos+=1
            for i in range(self.numero_nodos):
                self.grafo[self.numero_nodos-1][1].append(None)
            for i in self.grafo:
                if i[0] != nodo:
                    i[1].append(None)

    
    def inserta(self,nodo,destino=None, etiqueta=1):
        """
        Inserta un nodo al grafo (si destino es None) o un arco.
        Si el arco ya existía se actualiza su etiqueta.
        Si alguno de los nodos del arco no está en el grafo, se inserta.
        Se supone que None no es una etiqueta válida.
        """

        indice2=0
        self._crea(nodo)
        if destino != None:
            self._crea(destino)
            for i in range(self.numero_nodos):
                if self.grafo[i][0] == destino:
                    indice=i
                if self.grafo[i][0] == nodo:
                    indice2=i
            self.grafo[indice2][1][indice] = etiqueta
            if not self.dirigido():
                self.grafo[indice][1][indice2] = etiqueta
            self.numero_arcos+=1
     
    """
    def inserta2(self, nodo, destino=None, etiqueta=1):
    
        if destino == None:
            if not self.__contains__(nodo):
                self.grafo.append([nodo,[[None,None]]])
                self.numero_nodos+=1
        else:
            if not self.__contains__(nodo):
                self.grafo.append([nodo,[[None,None]]])
                self.numero_nodos+=1
            elif not self.__contains__(destino):
                self.grafo.append([destino,[[None,None]]])
                self.numero_nodos+=1
            if super().dirigido() == True:
                if self.__getitem__([nodo,destino]) == None:
                    for i in self.grafo:
                        if nodo in i:
                            indice=i.index(nodo)
                            self.grafo[indice][1].append([destino,True])
                            self.numero_arcos+=1
                            break
                else:
                    for i in self.grafo:
                        if nodo in i:
                            indice=i.index(nodo)
                            if self.__getitem__([nodo,destino]) != etiqueta:
                                self.grafo[indice][1].append([destino,etiqueta])
                                break
            elif super().dirigido() == False:
                if self.__getitem__([nodo,etiqueta]) == None:
                    for i in self.grafo:
                        if nodo in i:
                            indice=i.index(nodo)
                            self.grafo[indice][1].append([destino,True])
                        if destino in i:
                            indice=i.index(destino)
                            self.grafo[indice][1].append([nodo,True])
                            self.numero_arcos+=1
                else:
                    for i in self.grafo:
                        if nodo in i:
                            indice=i.index(nodo)
                            if self.__getitem__([nodo,destino]) != etiqueta:
                                self.grafo[indice][1].append([destino,etiqueta])
                        elif destino in i:
                            indice=i.index(destino)
                            if self.__getitem__([destino,nodo]) != etiqueta:
                                self.grafo[indice][1].append([nodo,etiqueta])
    """                  

    
    def __contains__(self, nodo):
        """Indica si el nodo está en el grafo."""
        for i in self.grafo:
            if nodo == i[0]:
                return True
        return False
        
                
    def __getitem__(self, arco):
        """Dado un arco (un par de nodos) devuelve la etiqueta si el arco está
        en el grafo, en caso contrario devuelve None"""
        lista_vecinos=self.vecinos(arco[0])
        for i in lista_vecinos:
            if i[0] == arco[1]:
                return i[1]
        return None
        
    def __iter__(self):
        """Iterador sobre los nodos del grafo"""
        for i in self.grafo:
            yield i[0]

    def vecinos(self, origen):
        """Devuelve un iterable de los pares (destino,etiqueta) para un nodo 
        origen dado, devuelve None en caso contrario"""
        mis_vecinos=[]
        if not origen in self:
            return []
        for pares in self.grafo:
            if origen == pares[0]:
                etiquetas=pares[1]
                break;
        for i in range(self.numero_nodos):
            if etiquetas[i] != None:
                mis_vecinos.append([self.grafo[i][0],etiquetas[i]])
        return mis_vecinos


# ### Implementación basada en listas de adyacencia
# Realizamos una implementación basada en [listas de adyacencia](https://youtu.be/7cXY3ztIGjs)

# In[30]:


class GrafoListas(GrafoAbstracto):
    """
    Implementación del tipo Grafo utilizando listas de adyacencia.
    Cada nodo tiene asociada una 'lista' con la información de los arcos que
    salen del nodo. 
    Dicha lista no tinene que ser necesariamente del tipo 'list' de Python.
    """
    
    def __init__(self, dirigido=False):
        """Constructor. El argumento indica si el grafo es dirigido"""
        super().__init__(dirigido)
        self.numero_nodos = 0
        self.numero_arcos = 0
        self.grafo = {}

    def __len__( self ):
        """Número de nodos del grafo."""
        return self.numero_nodos

    def num_arcos(self):
        """Devuelve el número de arcos"""
        return self.numero_arcos
    
    def _crea(self,nodo):
        if not nodo in self.grafo.keys():
            self.grafo[nodo]=[]
            self.numero_nodos+=1

    
    def inserta(self,nodo,destino=None, etiqueta=1):
        """
        Inserta un nodo al grafo (si destino es None) o un arco.
        Si el arco ya existía se actualiza su etiqueta.
        Si alguno de los nodos del arco no está en el grafo, se inserta.
        Se supone que None no es una etiqueta válida.
        """
        self._crea(nodo)
        if destino != None:
            self._crea(destino)
            if not nodo in self:
                self.grafo[nodo]=[]
            if not destino in self:
                self.grafo[destino]=[]
            self.grafo[nodo].append([destino,etiqueta])
            if not self.dirigido():
                self.grafo[destino].append([nodo,etiqueta])
            self.numero_arcos+=1
    
    def __contains__(self, nodo):
        """Indica si el nodo está en el grafo."""
        if nodo in self.grafo.keys():
            return True
        return False
        
                
    def __getitem__(self, arco):
        """Dado un arco (un par de nodos) devuelve la etiqueta si el arco está
        en el grafo, en caso contrario devuelve None"""
        lista_vecinos=self.vecinos(arco[0])
        if lista_vecinos != None:
            for vecino in lista_vecinos:
                if arco[1] in vecino:
                    return vecino[1]
            return None
        return None
        
    def __iter__(self):
        """Iterador sobre los nodos del grafo"""
        return iter(self.grafo.keys())

    def vecinos(self, origen):
        """Devuelve un iterable de los pares (destino,etiqueta) para un nodo 
        origen dado, devuelve None en caso contrario"""
        if origen in self.grafo.keys():
            return self.grafo.get(origen)
        return None


# ### Casos de prueba

# In[31]:


def test_grafo(grafo):
    """Función que prueba las funciones sobre grafos. Espera un grafo vacío."""

    num_final = 10  # número de nodos del grafo final
    num_arcos = 0
    conjunto_nodos = set()  # nodos que debería tener el grafo
    conjunto_arcos = set()  # arcos que debería tener el grafo
    
    # Insertamos nodos y arcos en el grafo, comprobando que la información es 
    # coherente con lo que tenemos en conjunto_nodos y conjunto_arcos
    for n in range(num_final):
        assert len(grafo) == n
        nodo_n = "n" + str(n)
        grafo.inserta(nodo_n)
        conjunto_nodos.add(nodo_n)
        assert nodo_n in grafo 
        assert n not in grafo
        for m in range(n):
            nodo_m = "n" + str(m)
            etiqueta = num_final * n + m
            grafo.inserta(nodo_m, nodo_n, etiqueta)
            conjunto_arcos.add((nodo_m, nodo_n, etiqueta))
            num_arcos += 1
            assert num_arcos == grafo.num_arcos()
            assert grafo[nodo_m, nodo_n] == etiqueta
            if grafo.dirigido():
                assert grafo[nodo_n, nodo_m] == None
            else:
                assert grafo[nodo_n, nodo_m] == etiqueta
                conjunto_arcos.add((nodo_n, nodo_m, etiqueta))
    
    # Recorremos comproabando los nodos y para cada nodo sus vecinos
    for nodo_n in grafo:
        assert nodo_n in conjunto_nodos
        conjunto_nodos.remove(nodo_n)
        for nodo_m, etiqueta in grafo.vecinos(nodo_n):
            assert (nodo_n, nodo_m, etiqueta) in conjunto_arcos
            conjunto_arcos.remove((nodo_n, nodo_m, etiqueta))
            
    # Comprobamos que hemos recorrido todos los nodos y arcos
    assert len(conjunto_nodos) == 0
    assert len(conjunto_arcos) == 0


# In[32]:


if __name__ == "__main__":     
    test_grafo(GrafoMatriz(False))
    test_grafo(GrafoMatriz(True))
    print("OK")


# In[33]:


if __name__ == "__main__":     
    test_grafo(GrafoListas(False))
    test_grafo(GrafoListas(True))
    print("OK")


# In[ ]:


"""
Con %timeit podemos ver el tiempo necesario para ejecutar una línea.
Puede ejecutarla múltiples veces para tener una mejor estimación.
Con %%timeit obtenemos el tiempo de ejecución de una celda.
"""
if __name__ == "__main__":  
    get_ipython().magic('timeit test_grafo(GrafoMatriz(False))')
    get_ipython().magic('timeit test_grafo(GrafoMatriz(True))')
    get_ipython().magic('timeit test_grafo(GrafoListas(False))')
    get_ipython().magic('timeit test_grafo(GrafoListas(True))')

