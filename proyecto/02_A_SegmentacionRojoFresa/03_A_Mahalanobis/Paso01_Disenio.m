%% 0.- CARGAMOS DATOS DEL PROBLEMA

close all, clear all, clc
load './../02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load './../01_SelecDescriptores/DatosGenerados/modelos.mat'

addpath('./../../Funciones')

%% 1.- ENTRENAMIENTO PARA MODELO 1

% VALORES CODIFICACION ORIGINALES
% Pixeles Rojo Fresa: valor 255 ROJO
% Pixeles Verde Fresa: valor 128 VERDE 
% Pixeles Verde Planta: valor 64 AZUL 
% Pixeles Negro Lona: valor 32 NEGRO

codifOI = 255;
CodifValoresRojos = CodifValoresColores == codifOI;

modelo = modelosSeleccionados{3};
datosModelo = ValoresColoresNormalizados(:,modelo);

% CALCULAMOS LOS PARAMETROS DEL MODELO
centroide = mean(datosModelo(CodifValoresRojos,:),1);
mCov = cov(datosModelo(CodifValoresRojos,:));

% representa_datos_RGB(datosModelo,CodifValoresRojos)
% hold on
% plot3(centroide(1),centroide(2),centroide(3),'*r')



% CALCULAMOS LA DISTANCIA DE MAHALANOBIS AL CENTROIDE PARA CADA PUNTO DE LA
% NUBE DE PUNTOS DE INTERES
distanciaM = distanciaM_punto_nube_puntos(centroide,...
                                          datosModelo(CodifValoresRojos,:),...
                                          mCov);


% REPRESENTAMOS LA NUBE
% Calculamos radios:
% Radio 1: punto más alejado de la nube de puntos de interes
% Radio 2: excluir el 3% de los puntos rojo fresa + alejados del centroide
% Radio 3: distancia minima de la nube de puntos de la clase de fondo
% Radio 4: distancia que permite la deteccion como pixeles rojo fresa de
% unicamente el 0.05% de pixeles de otros colores

radios = calcula_radios_mahalanobis(datosModelo,CodifValoresRojos,centroide,mCov);

% Dada la matriz de covarianzas mCOv y el centro Centroide (vector fila) de la nube
% de puntos del color rojo fresa:

[X1,X2,X3] = meshgrid(0:1/40:1);
Valores = [X1(:) X2(:) X3(:)];
[NumValores temp] = size(Valores);
distancia = [];

for j=1:NumValores
    X = Valores(j,:);
    distancia(j,1)=sqrt((X-centroide)*pinv(mCov)*(X-centroide)');
end


% for i = 1:4
%     
%     representa_datos_RGB(datosModelo,CodifValoresRojos)
%     hold on
%     plot3(centroide(1),centroide(2),centroide(3),'*r')
%     PosicionesInteres = distancia < radios(i);
%     datosMahal = Valores(PosicionesInteres,:);
% 
%     % REPRESENTAMOS
%     x = datosMahal(:,1); y = datosMahal(:,2); z = datosMahal(:,3);
%     plot3(x, y, z, '+g')
% end


% guardamos la informacion
parametrosMahalanobis{1,1} = modelo;
parametrosMahalanobis{1,2} = mCov;
parametrosMahalanobis{1,3} = centroide;
parametrosMahalanobis{1,4} = radios;


save './DatosGenerados/parametrosMahalanobis.mat' parametrosMahalanobis; 

rmpath('./../../Funciones')

