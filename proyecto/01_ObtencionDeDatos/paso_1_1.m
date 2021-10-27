%% LECTURA AUTOMATIZADA DE LAS IMÁGENES DE ENTRENAMIENTO

clear all, close all, clc
addpath('./Funciones/')

% LECTURA DE AUTOMATIZADA DE IMAGENES
addpath('../Material_Imagenes/01_MuestrasColores')

% nombres{1} = "Pixeles Rojo Fresa";
% nombres{2} = "Pixeles Verde Fresa";
% nombres{3} = "Pixeles Verde Planta";
% nombres{4} = "Pixeles Negro Lona";

% VALORES CODIFICACION
% Pixeles Rojo Fresa: valor 255
% Pixeles Verde Fresa: valor 128
% Pixeles Verde Planta: valor 64
% Pixeles Negro Lona: valor 32

ValoresColores = [];
CodifValoresColores = [];
ValoresColoresNormalizados = [];

% en una misma iteracion leemos la imagen a color y su muestra
numIteraciones = 3; 

for i = 1:numIteraciones
    % leemos la imagen y  la muestra
    
    imagen = imread([ 'Color' num2str(i) '.jpeg']);
    muestra = imread([ 'Color' num2str(i) '_MuestraColores.tif']);
    
    valoresCodif = unique(muestra);
    valoresCodif = double(valoresCodif(valoresCodif>0));
    
    % por cada clase obtenemos los descriptores
    for j = 1:length(valoresCodif)
        cod = valoresCodif(j);
        
        Ximagen = calcula_descriptores_imagen(imagen, muestra, valoresCodif(j));
        Yimagen = valoresCodif(j) * ones(size(Ximagen,1),1);
        
        % concatenamos
        ValoresColores = [ValoresColores ; Ximagen];
        CodifValoresColores = [CodifValoresColores ; Yimagen];
        
    end
    
    
end

% NORMALIZAMOS 
ValoresColoresNormalizados = normaliza_descriptores(ValoresColores);



save './DatosGenerados/conjunto_datos.mat' ValoresColores ...
                                           CodifValoresColores ...
                                           ValoresColoresNormalizados;

rmpath('../Material_Imagenes/01_MuestrasColores')
rmpath('Funciones\')