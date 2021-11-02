%% 0.- CARGAMOS DATOS DEL PROBLEMA

close all, clear all, clc
load './../../02_A_SegmentacionRojoFresa/02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load './../01_SelecDescriptores/DatosGenerados/modeloVerdeFresa.mat'

addpath( './../../Material_Imagenes/02_MuestrasRojo')
addpath('./../../Funciones')


% caracterizacion del problema
numImagenes = 2;
k = 9;   

%% 1.- ENTRENAMIENTO Y APLICACION DEL KNN

codifOI = 128;
CodifValoresVerdes = CodifValoresColores == codifOI;

% SELECCIONAMOS EL MODELO
datosModelo = ValoresColoresNormalizados(:,modeloVerdeFresa);


for i = 1:numImagenes
    
    % LEEMOS LA IMAGEN
    imagen = imread([ 'EvRojo' num2str(i) '.tif']);

    % APLICAMOS EL CLASIFICADOR KNN
    Ib = aplica_knn(imagen,datosModelo,CodifValoresVerdes,k,modeloVerdeFresa);

    
    % VISUALIZAMOS LOS RESULTADOS SOBRE LA IMAGEN
    VisualizaColores(imagen,Ib,[0 0 255],true);
end


rmpath( './../../Material_Imagenes/02_MuestrasRojo')
rmpath('./../../Funciones')
