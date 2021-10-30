%% 0.- CARGAMOS DATOS DEL PROBLEMA

close all, clear all, clc
load './../02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load './../01_SelecDescriptores/DatosGenerados/modelos.mat'

addpath('./Funciones/')

%% 1.- ENTRENAMIENTO PARA MODELO 1

% VALORES CODIFICACION ORIGINALES
% Pixeles Rojo Fresa: valor 255 ROJO
% Pixeles Verde Fresa: valor 128 VERDE 
% Pixeles Verde Planta: valor 64 AZUL 
% Pixeles Negro Lona: valor 32 NEGRO

codifOI = 255;
CodifValoresRojos = CodifValoresColores == codifOI;

modelo = modelosSeleccionados{1};

datosModelo = ValoresColoresNormalizados(:,modelo);

centroide = mean(datosModelo(CodifValoresRojos,:),1);

representa_datos_RGB(datosModelo,CodifValoresRojos)
hold on
plot3(centroide(1),centroide(2),centroide(3),'*r')


% matriz de covarianza de los datos de entrenamiento
mCov = cov(datosModelo(CodifValoresRojos,:));

% caracterizamos cada punto de la nube de puntos
distanciaM = zeros(sum(CodifValoresRojos),1);

valores = datosModelo(CodifValoresRojos,:);
numValores = size(valores,1);
for j = 1:numValores
    X = valores(j,:);
    distanciaM(j) = sqrt((X-centroide)*pinv(mCov)*(X-centroide)');
end

distanciaM_punto_nube_puntos(centroide,datosModelo(CodifValoresRojos,:),mCov)





%% 2.- ENTRENAMIENTO PARA MODELO 2



%% 3.- ENTRENAMIENTO PARA MODELO 3