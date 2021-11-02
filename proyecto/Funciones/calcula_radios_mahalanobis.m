% Calculamos radios:
% Radio 1: punto más alejado de la nube de puntos de interes
% Radio 2: excluir el 3% de los puntos rojo fresa + alejados del centroide
% Radio 3: distancia minima de la nube de puntos de la clase de fondo
% Radio 4: distancia que permite la deteccion como pixeles rojo fresa de
% unicamente el 0.05% de pixeles de otros colores

function radios = calcula_radios_mahalanobis(datosModelo,CodifValores,c,mcov)

    datosInteres = datosModelo(CodifValores,:);
    datosFondo = datosModelo(not(CodifValores),:);
   
    dNubeRojo = distanciaM_punto_nube_puntos(c,datosInteres,mcov);
    dNubeFondo = distanciaM_punto_nube_puntos(c,datosFondo,mcov);
    
    % radio 1
    dNubeRojoOrdenada = sort(dNubeRojo,'descend');
    r1 = dNubeRojoOrdenada(1);
    
    % radio 2
    excluidosRojos = ceil(0.03*length(dNubeRojo));
    r2 = dNubeRojoOrdenada(excluidosRojos);
    
    % radio 3
    dNubeFondoOrdeanada = sort(dNubeFondo,'ascend');
    r3 = dNubeFondoOrdeanada(1);
    
    % radio 4
    excluidosFondo = ceil(0.0005*length(dNubeFondo));
    r4 = dNubeFondoOrdeanada(excluidosFondo);
    
    radios = [r1 r2 r3 r4];
    
end

