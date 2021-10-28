%% LECTURA AUTOMATIZADA DE LAS IMÁGENES DE ENTRENAMIENTO

clear all, close all, clc
addpath('./Funciones/')

% LECTURA DE AUTOMATIZADA DE IMAGENES
addpath('../Material_Imagenes/01_MuestrasColores')

% nombres{1} = "Pixeles Rojo Fresa"; ROJO
% nombres{2} = "Pixeles Verde Fresa"; VERDE
% nombres{3} = "Pixeles Verde Planta";
% nombres{4} = "Pixeles Negro Lona";

% VALORES CODIFICACION
% Pixeles Rojo Fresa: valor 255 ROJO
% Pixeles Verde Fresa: valor 128 VERDE 
% Pixeles Verde Planta: valor 64 AZUL NEGRO
% Pixeles Negro Lona: valor 32


%% 1.- OBTENCIÓN DE DATOS

ValoresColores = [];
CodifValoresColores = [];
ValoresColoresNormalizados = [];

% tantas iteraciones como imagenes .jpeg en la carpeta de lectura
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


rmpath('../Material_Imagenes/01_MuestrasColores')


%% 2.- NORMALIZACIÓN DE DATOS 


ValoresColoresNormalizados = normaliza_descriptores(ValoresColores);



save './DatosGenerados/conjunto_datos_original.mat' ValoresColores ...
                                           CodifValoresColores ...
                                           ValoresColoresNormalizados;

                                       
%% 3.- REPRESENTACION DE MUESTRAS DE COLOR



% CARGAMOS LOS DATOS
close all, clear all, clc
load DatosGenerados\conjunto_datos_original.mat


% REPRESENTAMOS LOS DATOS SIN NORMALIZAR
% 1.- grafica RGB
RGB = ValoresColores(:,1:3);
representa_datos_RGB(RGB,CodifValoresColores);



% 2.- grafica HS
HS = ValoresColores(:,[4 5]);
representa_datos_2D(HS,CodifValoresColores);

% 3.- grafica UV
UV = ValoresColores(:,[8 9]);
representa_datos_2D(UV,CodifValoresColores);

% 4.- grafica ab
ab = ValoresColores(:,[11 12]);
representa_datos_2D(ab,CodifValoresColores);

% interpretracion de las graficas: bla bla bla 
% problema con H : no es discriminiante con los valores

% RECALCULAMOS LOS VALORES DE H
H = ValoresColores(:,4);
H(H>0.5) = 2*(H(H>0.5)-0.5);
H(not(H>0.5)) = 1 - 2*H(not(H>0.5));

HSmod = [ H ValoresColores(:,5)];
representa_datos_2D(HSmod,CodifValoresColores);

ValoresColores(:,4) = H;
ValoresColoresNormalizados(:,4) = H;



save './DatosGenerados/conjunto_datos.mat' ValoresColores ...
                                           CodifValoresColores ...
                                           ValoresColoresNormalizados;

rmpath('Funciones\')