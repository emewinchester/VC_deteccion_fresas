%% 0.- CARGAMOS LOS DATOS DEL PROBLEMA
clear all, close all, clc

load '..\02_A_SegmentacionRojoFresa\03_A_Mahalanobis\DatosGenerados/parametrosMahalanobis.mat'
load '..\02_A_SegmentacionRojoFresa\02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load '..\02_A_SegmentacionRojoFresa\01_SelecDescriptores\DatosGenerados/modelos.mat'
load '..\02_A_SegmentacionRojoFresa\03_B_NN\DatosGenerados/redes.mat'
load '..\02_B_RendimientoSegmentacionRojoFresa\DatosGenerado/clasificador_rojo_fresa.mat'


addpath('../Funciones/')
addpath('../Material_Imagenes/03_MuestrasFresas/')


%% CALCULAMOS METRICAS METODO 2 PASOS


numImagenes = 3;
metricas2pasos = [];
metricas1paso = [];



modelo1paso = [1 2 3]; % RGB
datosModelo = ValoresColoresNormalizados(:,modelo1paso);

codifRojo = 255;
codifVerde = 128;
CodifValoresRojos = CodifValoresColores == codifRojo;
CodifValoresVerdes = CodifValoresColores == codifVerde;

CodifValores_RV = CodifValoresColores;
CodifValores_RV(CodifValoresRojos) = 1;
CodifValores_RV(CodifValoresVerdes) = 2;
CodifValores_RV(not(CodifValoresRojos |CodifValoresVerdes)) = 0;


for i = 1:numImagenes
    
    % LEEMOS IMAGEN Y GOLD
    imagen = imread([ 'SegFresas' num2str(i) '.tif']);
    gold = imread([ 'SegFresas' num2str(i) '_Gold.tif']);
    
    % APLICAMOS LA SEGMENTACION EN 2 PASOS
    [Ib_RF,Ib_VF] = aplica_segmentacion_2pasos(imagen,clasificadorRojoFresa);
    
    % SEGMENTAR FRESAS ROJAS PRESENTES
    % juntamos las matrices
    Ib = Ib_RF | Ib_VF;
    
    % ELIMINAMOS AGRUPACIONES DE RUIDO DE PIXELES
    [N M] = size(imagen);
    filtro = round(0.001*N*M);
    Ib_filtrada = bwareaopen(Ib,filtro);
    
    % ETIQUETAMOS LA IMAGEN
    [Ib2pasos, m]= bwlabel(Ib_filtrada);
    
    
    % APLICAMOS EL CLASIFICADOR KNN 1 PASO
    Ib1paso = aplica_knn(imagen,datosModelo,CodifValores_RV,4,modelo1paso);
    
    % CALCULAMOS LAS METRICAS
    [Sens Esp Prec FP] = funcion_metricas(Ib2pasos , gold);
    columna = [Sens Esp Prec FP]';
    metricas2pasos = [metricas2pasos columna];
    
    [Sens Esp Prec FP] = funcion_metricas(Ib1paso , gold);
    columna = [Sens Esp Prec FP]';
    metricas1paso = [metricas1paso columna];
    


end

pm2pasos = sum(metricas2pasos,2)/numImagenes;
pm1paso = sum(metricas1paso,2)/numImagenes;

nombresMetricas = {'Sensibilidad';'Especifidad';'Precision';'FalsosPositivos'};
table(nombresMetricas,pm2pasos,pm1paso)

