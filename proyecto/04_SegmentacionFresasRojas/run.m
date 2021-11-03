%% 0.- CARGAMOS LOS DATOS DEL PROBLEMA
clear all, close all, clc

load '../02_B_RendimientoSegmentacionRojoFresa/DatosGenerado/clasificador_rojo_fresa.mat'

addpath('../Funciones/')
addpath('../Material_Imagenes/03_MuestrasFresas/')



%% 

% VALORES DE LOS MODELOS
% modelo = 1; % RGB
% modelo = 2; % Lab
% modelo = 3; % RSL

% VALORES PARA LOS CLASIFICADORES
% clasificador = 1; % mahalanobis
% clasificador = 2; % knn
% clasificador = 3; % svm
% clasificador = 4; % nn

numImagenes = 3;

% LEEMOS IMAGEN
for j = 1:numImagenes
    
    % LEEMOS IMAGEN Y GOLD
    imagen = imread([ 'SegFresas' num2str(j) '.tif']);
    gold = imread([ 'SegFresas' num2str(j) '_Gold.tif']);
    
    % APLICAMOS LA SEGMENTACION EN 2 PASOS
    [Ib_RF,Ib_VF] = aplica_segmentacion_2pasos(imagen,clasificadorRojoFresa);
    
    % VISUALIZAR SOBRE LA IMAGEN LOS RESULTADOS OBTENIDOS
    imagenRF = VisualizaColores(imagen,Ib_RF,[255 0 0]);
    imagenRF_VF = VisualizaColores(imagenRF,Ib_VF,[255 255 0],true);
    hold on, title(['IMAGEN ' num2str(j)]); hold off
    
    % SEGMENTAR FRESAS ROJAS PRESENTES
    % juntamos las matrices
    Ib = Ib_RF | Ib_VF;
    
    % ELIMINAMOS AGRUPACIONES DE RUIDO DE PIXELES
    [N M] = size(imagen);
    filtro = round(0.001*N*M);
    Ib_filtrada = bwareaopen(Ib,filtro);
    
    % ETIQUETAMOS LA IMAGEN
    [Ietiq, m]= bwlabel(Ib_filtrada);
    
    % MOSTRAMOS LAS FRESAS ROJAS
    for i = 1:m
        Iaux = Ietiq == i;
        VisualizaColores(imagen,Iaux,[255 0 0],true);
        hold on
        title(['IMAGEN ' num2str(j) ' - FRESA ' num2str(i) ]); hold off
    end
    
    
end



