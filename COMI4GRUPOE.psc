Algoritmo  COMI4GRUPOE
	Definir opcionSeleccionada, cantidadDeVeterinarias, pedidosPorProducto Como Entero
	Definir datosVeterinarias, productos Como Caracter
	cantidadDeVeterinarias <- 8
	cantidadDeProductos <- 5
	Dimension datosVeterinarias[cantidadDeVeterinarias,3]
	Dimension productos[cantidadDeProductos]
	Dimension pedidosPorProducto[cantidadDeVeterinarias,cantidadDeProductos]
	Definir estaCargado Como Logico
	estaCagado<-Falso
	mensajeBienvenida()
	Repetir
		menu()
		Leer opcionSeleccionada
		Segun opcionSeleccionada Hacer
			1:
				Limpiar Pantalla
				Si estaCargado == Falso Entonces
					cargarBaseDeDatosVeterinarias(datosVeterinarias)
					cargarBaseDeDatosProductos(productos)
					//mostrarBaseDeDatos(datosVeterinarias, cantidadDeVeterinarias)
					cargarPedidos(datosVeterinarias, pedidosPorProducto, productos, cantidadDeVeterinarias, cantidadDeProductos)
					estaCargado<-Verdadero
				SiNo
					Escribir "Los pedidos del mes ya han sido cargados, si desea modificar un pedido ingrese en la opción 2."
				FinSi
			2:
				//funcion que busque los pedidos realizados segun la veterinaria seleccionada.
			3:
				Limpiar Pantalla
				ordenarVeterinariasPorZonas(datosVeterinarias, pedidosPorProducto, cantidadDeVeterinarias, 3)
			4:
				//muestra todos los pedidos del mes con sus montos totales.
		Fin Segun
	Hasta Que (opcionSeleccionada == 5 o (opcionSeleccionada<1 y opcionSeleccionada>5))
	Limpiar Pantalla
	mensajeDespedida() 
FinAlgoritmo

SubProceso mensajeBienvenida()
	Escribir "¡Bienvenidos!"
FinSubProceso

SubProceso mensajeDespedida() 
	Escribir "Gracias por utilizar nuestro sistema."
FinSubProceso

//Subproceso menu muestra las opciones disponibles para operar dentro del programa
SubProceso menu()
	Escribir "MENÚ DE OPCIONES"
	Escribir "1. Cargar los pedidos realizados"
	Escribir "2. Buscar un pedido"
	Escribir "3. Ordenar por zona de conveniencia o por montos de pedidos"
	Escribir "4. Mostrar pedidos del mes"
	Escribir "5. Salir"
FinSubProceso

//Subproceso que carga los datos de las veterinarias en las que el distribuidor toma pedidos.
SubProceso cargarBaseDeDatosVeterinarias(array)
	array[0,0]<- "Veterinaria Oeste"
	array[0,1]<- "La república 6168, Rosario"
	array[0,2]<- "B"
	array[1,0]<- "Veterinaria Centro"
	array[1,1]<- "San Luis 968, Rosario"
	array[1,2]<- "A"
	array[2,0]<- "Veterinaria del Abasto"
	array[2,1]<- "Presidente Roca 1971, Rosario"
	array[2,2]<- "A"
	array[3,0]<- "Veterinaria Beto"
	array[3,1]<- "Buenos Aires 2155, Rosario"
	array[3,2]<- "C"
	array[4,0]<- "Veterinaria Peluditos"
	array[4,1]<- "Maipú 1286, Rosario"
	array[4,2]<- "A"
	array[5,0]<- "Veterinaria Norte"
	array[5,1]<- "Varela 3518, Rosario"
	array[5,2]<- "B"
	array[6,0]<- "Veterinaria Emergencias"
	array[6,1]<- "Junin 1256, Rosario"
	array[6,2]<- "B"
	array[7,0]<- "Veterinaria Margarita"
	array[7,1]<- "San Juan 2559, Rosario"
	array[7,2]<- "C"
FinSubProceso

//Subproceso que carga los productos que el distrubuidor ofrece
SubProceso cargarBaseDeDatosProductos(array)
	array[0] <- "Alimento para gatos x 1/2 Kg."
	array[1] <- "Alimento para gatos x 3 Kg."
	array[2] <- "Alimento para gatos x 7 Kg."
	array[3] <- "Alimento para perros x 7 Kg."
	array[4] <- "Alimento para perros x 20 Kg."
FinSubProceso

//Subproceso que permite cargar el arreglo de los pedidos realizados
SubProceso cargarPedidos(arrayBaseDeDatos, arrayACargar, arrayProductos, n, m)
	Para i<-0 Hasta n-1 Hacer
		Limpiar Pantalla
		Para j<-0 Hasta m-1 Hacer
			Escribir "Ingrese la cantidad pedida por: " arrayBaseDeDatos[i,0] " del producto: " arrayProductos[j]
			Leer arrayACargar[i,j]
		FinPara
	FinPara
	Escribir "¡Pedidos cargados exitosamente!"
FinSubProceso

//Ordenar array de vet, 
SubProceso ordenarVeterinariasPorZonas(arrayDeVeterinarias, arrayDePedidos, n, m)
	Definir aux Como Caracter;
	para i<-0 hasta n-2 Hacer 
		para k<-i+1 hasta n-1 Hacer 
			si arrayDeVeterinarias[i,2]>arrayDeVeterinarias[k,2] Entonces
				Para j<-0 Hasta m-1 Hacer 
					//ordenarPedidos()
					//ordenarProductos()
					aux <- arrayDeVeterinarias[i,j];
					arrayDeVeterinarias[i,j] <- arrayDeVeterinarias[k,j]; 
					arrayDeVeterinarias[k,j] <- aux; 
				Fin Para
			FinSi
		FinPara
	FinPara
	mostrarBaseDeDatos(arrayDeVeterinarias, arrayDePedidos)
FinSubProceso

SubProceso mostrarBaseDeDatos(array, arrayDePedidos)
	Para i<-0 Hasta 7 Hacer
		Para j<-0 Hasta 2 Hacer
			Escribir Sin Saltar array[i,j], " "
		FinPara
		Para j<-0 Hasta 4 Hacer
			Escribir Sin Saltar arrayDePedidos[i,j] " "
		FinPara
		Escribir " "
	FinPara
FinSubProceso
	