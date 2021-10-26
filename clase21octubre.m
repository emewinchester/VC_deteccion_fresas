% me debe salir RGB, LAB Y RSL


% eliminamos los outliers
% OJO: nos cargamos los outliers tanto en valoresColores como en
% codifColores para que casen el numero de filas (numero total de pixeles)

% clasificador basado en distancia de mahalanobis

% solo modelamos la nube de puntos rojos: calculamos matriz de covarianzas
% y esa nube de punto quedaria caracterizada por un punto (centroide de la
% nube) y la matriz de covarianzas. Un punto pertenece a la nube de puntos
% rojos segun el valor de su distancia de mahalanobis 


[ centrosRadios MatrizCovarianzas idxMuestras] = funcion_Mahalanobis(nubePuntosInteres, nubePuntosFondo)
% calcula la matriz de covarianzas 

% centros radios: media de la nube de puntos
% criterios de radios

% OJO que todo se hace con distancia de mahalanobis 

% redimensionar la imagenes a la hora de aplicar los clasificadores 

% hola