%% LECTURA AUTOMATIZADA DE LAS IMÁGENES DE ENTRENAMIENTO

clear all, close all, clc

% LECTURA DE AUTOMATIZADA DE IMAGENES
addpath('../Material_Imagenes/01_MuestrasColores')

nombres{1} = "Pixeles Rojo Fresa";
nombres{2} = "Pixeles Verde Fresa";
nombres{3} = "Pixeles Verde Planta";
nombres{4} = "Pixeles Negro Lona";

valoresCodif = [255 128 64 32];

% en una misma iteracion leemos la imagen a color y su muestra
numIteraciones = 3; 

for i = 1:numIteraciones
    % leemos la imagen y  la muestra
    
    imagen = imread([ 'Color' num2str(i) '.jpeg']);
    muestra = imread([ 'Color' num2str(i) '_MuestraColores.tif']);
    
    % por cada clase obtenemos las matrices 
    for j = 1:length(valoresCodif)
        codigo = valoresCodif(j);
        PoI = muestra == codigo;
        
        R = imagen(:,:,1);
        G = imagen(:,:,2);
        B = imagen(:,:,3);
        
        R = R(PoI);
        G = G(PoI);
        B = B(PoI);
        
        imagenhsv = rgb2hsv(imagen);
        
        
        
    end
    
    
    % obtenemos las matrices  R G B
    
    
    
    % obtenemos H y S
    
    % obtenemos lo que quede
    
    % concatenamos
end