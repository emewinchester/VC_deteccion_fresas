%% 0.- CARGAMOS DATOS DEL PROBLEMA

close all, clear all, clc
load '../../01_ObtencionDeDatos/DatosGenerados/conjunto_datos.mat';


%% 1.-  ELIMINACION OUTLIERS

% Criterio de eliminacion: eliminar del conjunto de datos todas las
% muestras de pixeles rojo fresa cuya componente roja sea menor a 0.95

% VALORES CODIFICACION ORIGINALES
% Pixeles Rojo Fresa: valor 255 ROJO
% Pixeles Verde Fresa: valor 128 VERDE 
% Pixeles Verde Planta: valor 64 AZUL 
% Pixeles Negro Lona: valor 32 NEGRO

umbral = 0.95;
codifOI = 255; 

CodifValoresRojo = CodifValoresColores == codifOI;

condicionUmbral = ValoresColoresNormalizados(:,1) < 0.95 ;


ValoresColoresNormalizados(condicionUmbral & CodifValoresRojo,:) = [];
CodifValoresColores(condicionUmbral & CodifValoresRojo,:) = [];

% comprobacion
% CodifValoresRojo = CodifValoresColores == codifOI;
% min(ValoresColoresNormalizados(CodifValoresRojo,1));



%% 2.- SALIDA DE DATOS

save './DatosGenerados/datos_limpios.mat' ValoresColoresNormalizados...
                                          CodifValoresColores ...
                                          nombresDescriptores;
                                      

                                      