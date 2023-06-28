Algoritmo  COMI4GRUPOE
	Definir opcionSeleccionada, cantidadDeVeterinarias, pedidosPorProducto, indice, opcionSubMenu Como Entero
	Definir precioPorProducto Como Real
	Definir montoAPagarPorVeterinaria Como Real
	Dimension montoAPagarPorVeterinaria[8]
	Dimension precioPorProducto[5]
	Definir datosVeterinarias, productos, veterinariaABuscar Como Caracter
	cantidadDeVeterinarias <- 8
	cantidadDeProductos <- 5
	Dimension datosVeterinarias[cantidadDeVeterinarias,3]
	Dimension productos[cantidadDeProductos]
	Dimension pedidosPorProducto[cantidadDeVeterinarias,cantidadDeProductos]
	Definir estaCargado Como Logico
	estaCagado<-Falso
	Definir esPrimeraVez Como Logico
	esPrimeraVez<-Verdadero
	mensajeBienvenida()
	Repetir
		menu()
		Leer opcionSeleccionada
		Segun opcionSeleccionada Hacer
			1:
				esPrimeraVez<-Falso
				Limpiar Pantalla
				Si !estaCargado Entonces
					cargarBaseDeDatosVeterinarias(datosVeterinarias)
					cargarBaseDeDatosProductos(productos)
					cargarBaseDeDatosPrecios(precioPorProducto)
					//cargarPedidos(datosVeterinarias, pedidosPorProducto, productos, cantidadDeVeterinarias, cantidadDeProductos)
					
					//Esta función solo se ejecutará en el momento en el que se esté testeando el programa, sino estará comentada tanto el llamado como su código.
					cargarModoDesarrollador(pedidosPorProducto)
					
					cargarMontoAPagarPorVeterinaria(montoAPagarPorVeterinaria, cantidadDeVeterinarias, pedidosPorProducto, precioPorProducto)
					estaCargado<-Verdadero
				SiNo
					Escribir "Los pedidos del mes ya han sido cargados, si desea modificar un pedido ingrese en la opción 2."
				FinSi
				Limpiar Pantalla
			2:
				Si esPrimeraVez Entonces
					Escribir "ATENCION! PARA PODER CONTINUAR, DEBE EJECUTAR LA OPCIÓN 1."
				SiNo
					Repetir
						Escribir "Ingrese la opción a ejecutar: "
						Escribir "1. Modificar pedido."
						Escribir "2. Ver pedido."
						Leer opcionSubMenu
					Hasta Que opcionSubMenu = 1 o opcionSubMenu = 2
					Limpiar Pantalla
					
					mostrarNombresVeterinarias(datosVeterinarias, cantidadDeVeterinarias)
					Repetir
						Escribir "Ingrese la veterinaria que desea buscar: "
						Leer veterinariaABuscar
					Hasta Que validarElementoABuscar(veterinariaABuscar, datosVeterinarias, cantidadDeVeterinarias)
					
					
					Limpiar Pantalla
					
					indice<-buscarVeterinaria(cantidadDeVeterinarias, datosVeterinarias, veterinariaABuscar)
					
					Si indice<>-1 Entonces
						Segun opcionSubMenu
							1: 
								cambiarPedidoPorVeterinaria(indice, datosVeterinarias, pedidosPorProducto, productos, cantidadDeProductos)
								cargarMontoAPagarPorVeterinaria(montoAPagarPorVeterinaria, cantidadDeVeterinarias, pedidosPorProducto, precioPorProducto)
							2:
								mostrarPedidoIndividual(indice, datosVeterinarias, productos, pedidosPorProducto, montoAPagarPorVeterinaria)
						FinSegun
					FinSi
				FinSi
				
			3:
				Si esPrimeraVez Entonces
					Escribir "ATENCION! PARA PODER CONTINUAR, DEBE EJECUTAR LA OPCIÓN 1."
				SiNo 
					Limpiar Pantalla
					Repetir
						Escribir "¿Cómo desea ordenar los pedidos?"
						Escribir "1. Por zona de conveniencia."
						Escribir "2. Por monto de pedidos."
						Leer orderBy 
					Hasta Que orderBy = 1 o orderBy = 2
					
					Limpiar Pantalla
					Segun orderBy Hacer
						1: 
							ordenarVeterinariasPorZonas(datosVeterinarias, pedidosPorProducto, cantidadDeVeterinarias, 3, productos, montoAPagarPorVeterinaria)
						2:
							ordenarVeterinariasPorMontos(datosVeterinarias, pedidosPorProducto, cantidadDeVeterinarias, 3, productos, montoAPagarPorVeterinaria)
					FinSegun
					Limpiar Pantalla
					Escribir "Los pedidos han sido ordenados exitosamente, puede verlos en la opcion 4 del menú."
				FinSi
				
			4:
				
				Limpiar Pantalla
				Si esPrimeraVez Entonces
					Escribir "ATENCION! PARA PODER CONTINUAR, DEBE EJECUTAR LA OPCIÓN 1."
				SiNo
					mostrarPedidos(datosVeterinarias, pedidosPorProducto, productos, montoAPagarPorVeterinaria)
				FinSi
				
			5: 
				Limpiar Pantalla
				Si esPrimeraVez Entonces
					Escribir "ATENCION! PARA PODER CONTINUAR, DEBE EJECUTAR LA OPCIÓN 1."
				SiNo
					mostrarResumenMesual(montoAPagarPorVeterinaria, cantidadDeVeterinarias, cantidadDeProductos, productos, pedidosPorProducto)
				FinSi
				
		Fin Segun
	Hasta Que (opcionSeleccionada == 6 o (opcionSeleccionada<1 y opcionSeleccionada>6))
	Limpiar Pantalla
	mensajeDespedida() 
FinAlgoritmo

//---------------------------------------------------INICIO------------------------------------------------------
SubProceso mensajeBienvenida()
	Escribir "¡Bienvenidos a PETBIT el sistema de gestión de pedidos para distribuidoras!"
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
	Escribir "5. Resumenes del mes."
	Escribir "6. Salir"
FinSubProceso

//---------------------------------------------------OPCIÓN 1------------------------------------------------------
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

//Subproceso que carga los precios de cada producto
SubProceso cargarBaseDeDatosPrecios(array)
	array[0] <- 1000
	array[1] <- 5500
	array[2] <- 11500
	array[3] <- 11500
	array[4] <- 29900
FinSubProceso

//Subproceso que permite cargar el arreglo de los pedidos realizados
SubProceso cargarPedidos(arrayBaseDeDatos, arrayACargar, arrayProductos, n, m)
	Definir aux Como Real
	Para i<-0 Hasta n-1 Hacer
		Limpiar Pantalla
		Para j<-0 Hasta m-1 Hacer
			Repetir
				Escribir "Ingrese la cantidad pedida por: " arrayBaseDeDatos[i,0] " del producto: " arrayProductos[j]
				Leer aux
				Si aux < 0 o (Longitud(ConvertirATexto(aux)) = 0)
					Escribir "Cantidad inválida."
				SiNo
					ArrayACargar[i,j] <- aux
				FinSi
			Mientras que aux < 0 o (Longitud(ConvertirATexto(aux)) = 0)
		FinPara
	FinPara
	Escribir "¡Pedidos cargados exitosamente!"
FinSubProceso


//Calcula los montos de los pedidos por cada veterinaria y los guarda en el arreglo
SubProceso cargarMontoAPagarPorVeterinaria(arrayMontos, n, arrayPedidos, arrayPrecios)
	Definir acumulador como real
	Para i<-0 Hasta n-1 Hacer
		acumulador<-0
		Para j<-0 Hasta 4 Hacer
			acumulador <- acumulador + (arrayPedidos[i,j] * arrayPrecios[j])
		FinPara
		arrayMontos[i] <- acumulador
	FinPara
FinSubProceso

//---------------------------------------------------OPCIÓN 2------------------------------------------------------
Subproceso mostrarNombresVeterinarias(datosVeterinarias, n)
	Escribir "LISTA DE VETERINARIAS:"
	Para i<-0 Hasta n-1 Hacer
		Escribir datosVeterinarias[i,0] 
	FinPara
FinSubProceso

//Validacion de la cadena de veterinaria a buscar
Funcion return<-validarElementoABuscar(veterinariaABuscar, arrayDescripcion, n)
	Para i<-0 Hasta n-1 Hacer
		Si arrayDescripcion[i,0] = veterinariaABuscar Entonces
			return<-Verdadero
		FinSi
	FinPara
FinFuncion

//Funcion que devuelve el indice en base a la veterinaria ingresada
Funcion return<-buscarVeterinaria(n, arrayDescripcion, veterinariaABuscar)
	Definir i Como Entero;
	Definir elementoEncontrado Como Logico;
	i<-0;
	elementoEncontrado<- Falso;
	Mientras (no elementoEncontrado) y i<n Hacer
		Si arrayDescripcion[i,0] == veterinariaABuscar Entonces
			elementoEncontrado <- Verdadero
		SiNo
			i <- i + 1
		FinSi
	FinMientras
	Si elementoEncontrado Entonces
		return <- i
	SiNo
		return <- -1
	FinSi
FinFuncion

SubProceso mostrarProductosDisponibles(arrayProductos, m)
	Escribir "LISTA DE PRODUCTOS: "
	Para i<-0 Hasta m-1 Hacer
		Escribir arrayProductos[i]
	FinPara
FinSubProceso

Funcion return<-validarProductoIngresado(arrayProductos, productoIngresado, m)
	Para i<-0 Hasta m-1 Hacer
		Si arrayProductos[i] == productoIngresado Entonces
			return<-Verdadero
		FinSi
	FinPara
FinFuncion

Funcion return<-buscarProductoAModificar(arrayProductos, m)
	Definir productoAModificar Como Caracter
	mostrarProductosDisponibles(arrayProductos, m) 
	Repetir
		Escribir Sin Saltar "Ingrese el producto al que desea modificar el stock: "
		Leer productoAModificar
	Hasta Que validarProductoIngresado(arrayProductos, productoAModificar, m)
	
	Para i<-0 Hasta m-1 Hacer
		Si arrayProductos[i] == productoAModificar Entonces
			return<-i
		FinSi
	FinPara
FinFuncion

SubProceso cambiarPedidoPorVeterinaria(i, arrayBaseDeDatos, pedidosPorProducto, arrayProductos, m)
	Definir indice como Entero
	indice<-buscarProductoAModificar(arrayProductos, m)
	
	Limpiar Pantalla
	
	Repetir
		Escribir "Ingrese la cantidad pedida por: " arrayBaseDeDatos[i,0] " del producto: " arrayProductos[indice]
		Leer pedidosPorProducto[i,indice]
	Hasta Que pedidosPorProducto[i,indice] >= 0 
	
	Escribir "El pedido se actualizó correctamente."
FinSubProceso

Subproceso mostrarPedidoIndividual(i, arrayDescripcion, arrayDeProductos, arrayDePedidos, arrayMontos)
	Para j<-0 Hasta 2 Hacer //Recorre las columnas del arreglo de base de datos de veterinarias
		Si j==2 Entonces
			Escribir Sin Saltar "| Zona:" 
		FinSi
		Escribir Sin Saltar arrayDescripcion[i,j], " "
	FinPara
	Escribir  " "
	Para k<-0 Hasta 4 Hacer //Recorre las columnas del arreglo de pedidos por producto, muestra la base de datos y la cantidad pedida por producto
		Escribir arrayDeProductos[k] " Cantidad: " arrayDePedidos[i,k] " "
	FinPara
	//Muestre el total de dinero que debe abonar la veterinaria.
	Escribir "El monto a abonar por la veterinaria es: $" arrayMontos[i]
	Escribir " "
FinSubProceso

//---------------------------------------------------OPCIÓN 3------------------------------------------------------

//Ordenar array de vet por zona. 
SubProceso ordenarVeterinariasPorZonas(arrayDeVeterinarias, arrayDePedidos, n, m, arrayDeProductos, arrayMontos)
	Definir aux Como Caracter
	Definir auxPedidos Como Entero
	Definir auxMontos como real
	para i<-0 hasta n-2 Hacer 
		para k<-i+1 hasta n-1 Hacer 
			si arrayDeVeterinarias[i,2]>arrayDeVeterinarias[k,2] Entonces
				//Ordena base de datos de veterinarias
				Para j<-0 Hasta m-1 Hacer 
					aux <- arrayDeVeterinarias[i,j];
					arrayDeVeterinarias[i,j] <- arrayDeVeterinarias[k,j]; 
					arrayDeVeterinarias[k,j] <- aux; 
				FinPara
				
				Para j<-0 Hasta 4 Hacer
					//Ordena los productos
					auxPedidos <- arrayDePedidos[i,j];
					arrayDePedidos[i,j] <- arrayDePedidos[k,j]; 
					arrayDePedidos[k,j] <- auxPedidos; 
					//Ordena los precios
					auxMontos <- arrayMontos[i]
					arrayMontos[i] <- arrayMontos[k]
					arrayMontos[k] <- auxMontos
				FinPara
			FinSi
		FinPara
	FinPara
FinSubProceso

//Ordenamiento de las veterinarias por montos 
SubProceso ordenarVeterinariasPorMontos(arrayDeVeterinarias, arrayDePedidos, n, m, arrayDeProductos, arrayMontos)
	Definir aux Como Caracter
	Definir auxPedidos Como Entero
	Definir auxMontos como real
	para i<-0 hasta n-2 Hacer 
		para k<-i+1 hasta n-1 Hacer 
			si arrayMontos[i]<arrayMontos[k] Entonces
				//Ordena base de datos de veterinarias
				Para j<-0 Hasta m-1 Hacer 
					aux <- arrayDeVeterinarias[i,j];
					arrayDeVeterinarias[i,j] <- arrayDeVeterinarias[k,j]; 
					arrayDeVeterinarias[k,j] <- aux; 
				FinPara
				
				Para j<-0 Hasta 4 Hacer
					//Ordena los productos
					auxPedidos <- arrayDePedidos[i,j];
					arrayDePedidos[i,j] <- arrayDePedidos[k,j]; 
					arrayDePedidos[k,j] <- auxPedidos; 
					//Ordena los precios
					auxMontos <- arrayMontos[i]
					arrayMontos[i] <- arrayMontos[k]
					arrayMontos[k] <- auxMontos
				FinPara
			FinSi
		FinPara
	FinPara
FinSubProceso

//---------------------------------------------------OPCIÓN 4------------------------------------------------------

SubProceso mostrarPedidos(array, arrayDePedidos, arrayDeProductos, arrayMontos)
	Para i<-0 Hasta 7 Hacer //Recorre todas las filas, es decir, las veterinarias
		Para j<-0 Hasta 2 Hacer //Recorre las columnas del arreglo de base de datos de veterinarias
			Si j==2 Entonces
				Escribir Sin Saltar "| Zona:" 
			FinSi
			Escribir Sin Saltar array[i,j], " "
		FinPara
		Escribir  " "
		Para k<-0 Hasta 4 Hacer //Recorre las columnas del arreglo de pedidos por producto, muestra la base de datos y la cantidad pedida por producto
			Escribir arrayDeProductos[k] " Cantidad: " arrayDePedidos[i,k] " "
		FinPara
		//Muestre el total de dinero que debe abonar la veterinaria.
		Escribir "El monto a abonar por la veterinaria es: $" arrayMontos[i]
		Escribir " "
	FinPara
FinSubProceso

//---------------------------------------------------OPCIÓN 5------------------------------------------------------

SubProceso mostrarResumenMesual(arrayMontos, n, m, arrayProductos, arrayPedidos)
	Definir montoTotal Como Real
	montoTotal <- calcularMontoTotal(arrayMontos, n)
	Escribir "RESUMEN MENSUAL: "
	Escribir "TOTAL A RECAUDAR: $" montoTotal
	Escribir "CANTIDAD POR PRODUCTO: "	
	mostrarCantidadPorProducto( m, arrayProductos, arrayPedidos, n)
FinSubProceso

Funcion return<-calcularMontoTotal(arrayMontos, n)
	Definir acumulador Como Real
	acumulador<-0
	Para i<-0 Hasta n-1 Hacer
		acumulador <- acumulador + arrayMontos[i]
	FinPara
	return<-acumulador
FinFuncion

SubProceso mostrarCantidadPorProducto( m, arrayProductos, arrayPedidos, n)
	Definir cantidadTotalPorProducto Como Entero
	Para i<-0 Hasta m-1 Hacer //Itera columnas de cada producto
		cantidadTotalPorProducto<-0
		Para j<-0 Hasta n-1 Hacer //itera filas de cada veterinaria
			cantidadTotalPorProducto <- cantidadTotalPorProducto + arrayPedidos[j,i]
		FinPara
		Escribir "Cantidad pedida de: " arrayProductos[i] " es: " cantidadTotalPorProducto
	FinPara
	Escribir "---------------------------------------------------------"
FinSubProceso

//---------------------------------------------------SOLO PARA TESTEO DEL PROGRAMA------------------------------------------------------

SubProceso cargarModoDesarrollador(arrayACargar)
	arrayACargar[0,0] <- 1 
	arrayACargar[0,1] <- 1
	arrayACargar[0,2] <- 1
	arrayACargar[0,3] <- 1
	arrayACargar[0,4] <- 1
	arrayACargar[1,0] <- 2
	arrayACargar[1,1] <- 2
	arrayACargar[1,2] <- 2
	arrayACargar[1,3] <- 2
	arrayACargar[1,4] <- 2
	arrayACargar[2,0] <- 3
	arrayACargar[2,1] <- 3
	arrayACargar[2,2] <- 3
	arrayACargar[2,3] <- 3
	arrayACargar[2,4] <- 3
	arrayACargar[3,0] <- 4
	arrayACargar[3,1] <- 4
	arrayACargar[3,2] <- 4
	arrayACargar[3,3] <- 4
	arrayACargar[3,4] <- 4
	arrayACargar[4,0] <- 5
	arrayACargar[4,1] <- 5
	arrayACargar[4,2] <- 5
	arrayACargar[4,3] <- 5
	arrayACargar[4,4] <- 5
	arrayACargar[5,0] <- 6
	arrayACargar[5,1] <- 6
	arrayACargar[5,2] <- 6
	arrayACargar[5,3] <- 6
	arrayACargar[5,4] <- 6
	arrayACargar[6,0] <- 7
	arrayACargar[6,1] <- 7
	arrayACargar[6,2] <- 7
	arrayACargar[6,3] <- 7
	arrayACargar[6,4] <- 7
	arrayACargar[7,0] <- 8
	arrayACargar[7,1] <- 8
	arrayACargar[7,2] <- 8
	arrayACargar[7,3] <- 8
	arrayACargar[7,4] <- 8
FinSubProceso
	