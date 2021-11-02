%% 0.- CARGAMOS DATOS DEL PROBLEMA

close all, clear all, clc
load './../02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load './../01_SelecDescriptores/DatosGenerados/modelos.mat'

addpath( './../../Material_Imagenes/02_MuestrasRojo')
addpath('./../../Funciones')


% caracterizacion del problema
numImagenes = 2;
k = 9;   

%% 1.- ENTRENAMIENTO Y APLICACION DEL KNN

% SELECCIONAR MODELO (escoger entre 1,2,3)
modeloSeleccionado = 1;
% modeloSeleccionado = 2;
% modeloSeleccionado = 3;

codifOI = 255;
CodifValoresRojos = CodifValoresColores == codifOI;

% SELECCIONAMOS EL MODELO
modelo = modelosSeleccionados{modeloSeleccionado,1};
datosModelo = ValoresColoresNormalizados(:,modelo);




for i = 1:numImagenes
    
    % LEEMOS LA IMAGEN
    imagen = imread([ 'EvRojo' num2str(i) '.tif']);

    % APLICAMOS EL CLASIFICADOR KNN
    Ib = aplica_knn(imagen,datosModelo,CodifValoresRojos,k,modelo);

    
    % VISUALIZAMOS LOS RESULTADOS SOBRE LA IMAGEN
    VisualizaColores(imagen,Ib,[0 0 255],true);
end


rmpath( './../../Material_Imagenes/02_MuestrasRojo')
rmpath('./../../Funciones')
