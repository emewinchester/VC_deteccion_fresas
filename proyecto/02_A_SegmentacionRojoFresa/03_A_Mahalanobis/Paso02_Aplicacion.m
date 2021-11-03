%% 0.- CARGAMOS DATOS DEL PROBLEMA

clear all, close all, clc
load './DatosGenerados/parametrosMahalanobis.mat';
addpath( './../../Material_Imagenes/02_MuestrasRojo')
addpath('./../../Funciones')

numImagenes = 2; 

%% 

% SELECCIONAR MODELO (escoger entre 1,2,3)
modeloSeleccionado = 1;
% modeloSeleccionado = 2;
% modeloSeleccionado = 3;

% CARGAMOS EL MODELO
modelo = parametrosMahalanobis{modeloSeleccionado,1};
centroide = parametrosMahalanobis{modeloSeleccionado,2};
mCov = parametrosMahalanobis{modeloSeleccionado,3};
radio = parametrosMahalanobis{modeloSeleccionado,4};

for i = 1:numImagenes
    
    % LEEMOS LA IMAGEN
    imagen = imread([ 'EvRojo' num2str(i) '.tif']);

    % APLICAMOS EL CLASIFICADOR DE MAHALANOBIS A LA IMAGEN
    Ib = aplica_mahalanobis(imagen,modelo,...
                        centroide,mCov,radio);

    
    % VISUALIZAMOS LOS RESULTADOS SOBRE LA IMAGEN
    VisualizaColores(imagen,Ib,[0 0 255],true);
end


rmpath( './../../Material_Imagenes/02_MuestrasRojo')
rmpath('./../../Funciones') 