%% 0.- CARGAMOS DATOS DEL PROBLEMA

close all, clear all, clc
load './../02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load './../01_SelecDescriptores/DatosGenerados/modelos.mat'

addpath('./../../Funciones')

%% 1.- ENTRENAMIENTO DEL KNN

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
    
    % IDENTIFICAMOS LOS VALORES PARA EL FIT
    inputs_ent = datosModelo;
    outputs_ent = CodifValoresRojos;
    k = 9;
    
    % HACEMOS EL FIT DEL MODELO
    KNN_model = fitcknn(inputs_ent, outputs_ent,'NumNeighbors',k);
    
    
    % APLICAMOS EL PREDICT PIXEL A PIXEL
    


        
    
end



KNN_model = fitcknn(inputs_ent, outputs_ent,'NumNeighbors',k);
Codificacion_input = predict(KNN_model,input);