%% 0.- CARGAMOS DATOS DEL PROBLEMA

clear all, close all, clc
load './DatosGenerados/parametrosMahalanobis.mat';
addpath( './../../Material_Imagenes/02_MuestrasRojo')
addpath('./../../Funciones')

numImagenes = 2; 

%% 

% SELECCIONAR MODELO (escoger entre 1,2,3)
modeloSeleccionado = 1;


% CARGAMOS EL MODELO
modelo = parametrosMahalanobis{modeloSeleccionado,1};
centroide = parametrosMahalanobis{1,2};
mCov = parametrosMahalanobis{1,3};
radio = parametrosMahalanobis{1,4};

for i = 1:numImagenes
    
    % LEEMOS LA IMAGEN
    imagen = imread([ 'EvRojo' num2str(i) '.tif']);


    % REDUCIMOS LA IMAGEN
    imagenR = imresize(imagen,0.5);

    % OBTNEMOS LOS DESCRIPTORES DE INTERES NORMALIZADOS
    [d1 d2 d3] = calcula_descriptores_interes(imagenR, modelo);


    % recorremos cada pixel de la imagen
    D = zeros(size(d1)); % matriz de detecciones
    pixel = zeros(1,3);


    for f = 1:size(imagenR,1)
        for c = 1:size(imagenR,2)

            % caracterizamos cada pixel
            pixel(1,1) = d1(f,c);
            pixel(1,2) = d2(f,c);
            pixel(1,3) = d3(f,c);

            % calculamos la distancia Mahalanobis de pixel a centroide
            distPixelCentroide = distanciaM_punto_a_punto(pixel, centroide,mCov);

            if distPixelCentroide <= radio
                D(f,c) = 1;
            else
                D(f,c) = 0;
            end

        end
    end


    % Reescalamos la matriz codifImagen para que coincida con las de imagen
    [F C dim] = size(imagen);
    codifImagen = round(imresize(D,[F C], 'nearest'));
    Ib = codifImagen == 1;

    VisualizaColores(imagen,Ib,[0 0 255],true);
end



rmpath('./../../Funciones') 