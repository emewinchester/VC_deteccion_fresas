%% 0.- CARGAMOS DATOS DEL PROBLEMA

close all, clear all, clc
load './../02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load './../01_SelecDescriptores/DatosGenerados/modelos.mat'

addpath('./../../Funciones')

%% 1.- ENTRENAMIENTO PARA LOS MODELOS

% VALORES CODIFICACION ORIGINALES
% Pixeles Rojo Fresa: valor 255 ROJO
% Pixeles Verde Fresa: valor 128 VERDE 
% Pixeles Verde Planta: valor 64 AZUL 
% Pixeles Negro Lona: valor 32 NEGRO

codifOI = 255;
CodifValoresRojos = CodifValoresColores == codifOI;


for i = 1:size(modelosSeleccionados,1)
    
    % SELECCIONAMOS EL MODELO
    modelo = modelosSeleccionados{i,1};
    datosModelo = ValoresColoresNormalizados(:,modelo);
    
    % CALCULAMOS LOS PARAMETROS DEL MODELO
    c{i} = mean(datosModelo(CodifValoresRojos,:),1);
    mCov{i} = cov(datosModelo(CodifValoresRojos,:));
    
    % CALCULAMOS LA DISTANCIA DE MAHALANOBIS AL CENTROIDE PARA CADA PUNTO DE LA
    % NUBE DE PUNTOS DE INTERES                          
    distanciaM = distanciaM_punto_nube_puntos(c{i},...
                                          datosModelo(CodifValoresRojos,:),...
                                          mCov{i});
                                
    % CALCULAMOS RADIOS:
    radios{i} = calcula_radios_mahalanobis(...
                            datosModelo,CodifValoresRojos,c{i},mCov{i});
                        
    % REPRESENTAMOS LA SEGMENTACION MEDIANTE DISTANCIA DE MAHALANOBIS
    %representa_radios_segmentacion_mahalanobis(c{i},mCov{i},datosModelo,...
                       % CodifValoresRojos,radios{i},nombresDescriptores,modelo);
        
    
end






%% 2.- GUARDAMOS LA INFORMACION

% seleccion de radios para las graficas
radiosSeleccionados = [4 4 4];


% % guardamos la informacion
for i = 1:size(modelosSeleccionados,1)
    parametrosMahalanobis{i,1} = modelosSeleccionados{i,1};
    parametrosMahalanobis{i,2} = c{i};
    parametrosMahalanobis{i,3} = mCov{i};
    parametrosMahalanobis{i,4} = radios{i}(radiosSeleccionados(i));
end
    



save './DatosGenerados/parametrosMahalanobis.mat' parametrosMahalanobis; 

rmpath('./../../Funciones')

