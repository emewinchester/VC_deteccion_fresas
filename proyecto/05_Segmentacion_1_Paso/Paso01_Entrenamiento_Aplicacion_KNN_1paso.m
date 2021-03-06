%% 0.- CARGAMOS DATOS DEL PROBLEMA

close all, clear all, clc
load './../02_A_SegmentacionRojoFresa/02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load './../02_A_SegmentacionRojoFresa/01_SelecDescriptores/DatosGenerados/modelos.mat'

addpath( './../Material_Imagenes/02_MuestrasRojo')
addpath('./../Funciones')


% caracterizacion del problema
numImagenes = 2;
k = 4;

%% 1.- ENTRENAMIENTO Y APLICACION DEL KNN

% SELECCIONAR MODELO (escoger entre 1,2,3)
modeloSeleccionado = 1;
% modeloSeleccionado = 2;
% modeloSeleccionado = 3;

modelo = modelosSeleccionados{modeloSeleccionado,1};
datosModelo = ValoresColoresNormalizados(:,modelo);

codifRojo = 255;
codifVerde = 128;
CodifValoresRojos = CodifValoresColores == codifRojo;
CodifValoresVerdes = CodifValoresColores == codifVerde;

CodifValores_RV = CodifValoresColores;
CodifValores_RV(CodifValoresRojos) = 1;
CodifValores_RV(CodifValoresVerdes) = 2;
CodifValores_RV(not(CodifValoresRojos |CodifValoresVerdes)) = 0;

for i = 1:numImagenes
    
    % LEEMOS LA IMAGEN
    imagen = imread([ 'EvRojo' num2str(i) '.tif']);

    % APLICAMOS EL CLASIFICADOR KNN
    Ib = aplica_knn(imagen,datosModelo,CodifValores_RV,k,modelo);

    
    % VISUALIZAMOS LOS RESULTADOS SOBRE LA IMAGEN
    VisualizaColores(imagen,Ib,[0 0 255],true);
end


rmpath( './../Material_Imagenes/02_MuestrasRojo')
rmpath('./../Funciones')