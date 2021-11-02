%% CARACTERIZAMOS EL PROBLEMA

clear all, close all, clc
addpath('./../Funciones/')

% LECTURA DE AUTOMATIZADA DE IMAGENES
addpath('../Material_Imagenes/01_MuestrasColores')

% NOMBRES DE LOS DESCRIPTORES
nombresDescriptores{1} = 'R';
nombresDescriptores{2} = 'G';
nombresDescriptores{3} = 'B';
nombresDescriptores{4} = 'H';
nombresDescriptores{5} = 'S';
nombresDescriptores{6} = 'I';
nombresDescriptores{7} = 'Y';
nombresDescriptores{8} = 'U';
nombresDescriptores{9} = 'V';
nombresDescriptores{10} = 'L';
nombresDescriptores{11} = 'a';
nombresDescriptores{12} = 'b';

% VALORES CODIFICACION
% Pixeles Rojo Fresa: valor 255 ROJO
% Pixeles Verde Fresa: valor 128 VERDE 
% Pixeles Verde Planta: valor 64 AZUL NEGRO
% Pixeles Negro Lona: valor 32


%% 1.- OBTENCION DE DATOS

ValoresColores = [];
CodifValoresColores = [];
ValoresColoresNormalizados = [];

% tantas iteraciones como imagenes .jpeg en la carpeta de lectura
numIteraciones = 3; 

% LEEMOS LAS IMAGENES Y RELLENAMOS LAS MATRICES NECESARIAS
for i = 1:numIteraciones
    

    imagen = imread([ 'Color' num2str(i) '.jpeg']);
    muestra = imread([ 'Color' num2str(i) '_MuestraColores.tif']);
    
    valoresCodif = unique(muestra);
    valoresCodif = double(valoresCodif(valoresCodif>0));
    
    
    % por cada clase obtenemos los descriptores
    for j = 1:length(valoresCodif)
        
        [Ximagen,XimagenN] = calcula_descriptores_imagen(imagen, muestra, valoresCodif(j));
        Yimagen = valoresCodif(j) * ones(size(Ximagen,1),1);
        
        % concatenamos
        ValoresColores = [ValoresColores ; Ximagen];
        ValoresColoresNormalizados = [ValoresColoresNormalizados ; XimagenN];
        CodifValoresColores = [CodifValoresColores ; Yimagen];
        
    end
    
end


rmpath('../Material_Imagenes/01_MuestrasColores')


% ALMACENAMOS LOS DATOS
save './DatosGenerados/conjunto_datos_original.mat' ValoresColores ...
                                                    CodifValoresColores ...
                                                    ValoresColoresNormalizados...
                                                    nombresDescriptores;

                                       
%% 2.- REPRESENTACION DE MODELOS DE COLOR

% Pixeles Rojo Fresa: valor 255 ROJO
% Pixeles Verde Fresa: valor 128 VERDE 
% Pixeles Verde Planta: valor 64 AZUL NEGRO
% Pixeles Negro Lona: valor 32

% CARGAMOS LOS DATOS
clear all, clc
load DatosGenerados\conjunto_datos_original.mat
nM = nombresDescriptores;



% REPRESENTAMOS LOS DATOS SIN NORMALIZAR
% 1.- grafica RGB
modelo = 1:3;
RGB = ValoresColores(:,modelo);
representa_datos_3D_sin_normalizar(RGB,CodifValoresColores,nM,modelo);
hold on


% 2.- grafica HS
modelo = [4 5];
HS = ValoresColores(:,modelo);
representa_datos_2D(HS,CodifValoresColores,nM,modelo);

% 3.- grafica UV
modelo = [8 9];
UV = ValoresColores(:,modelo);
representa_datos_2D(UV,CodifValoresColores,nM,modelo);

% 4.- grafica ab
modelo = [11 12];
ab = ValoresColores(:,modelo);
representa_datos_2D(ab,CodifValoresColores,nM,modelo);

% interpretracion de las graficas: 
% problema con H : no es discriminiante con los valores rojos

% RECALCULAMOS LOS VALORES DE H
H = ValoresColores(:,4);
Hrec = ones(size(H));
Hrec(H<=0.5)=1-2*H(H<=0.5);
Hrec(H>0.5)=2*(H(H>0.5)-0.5);

HSmod = [ Hrec ValoresColores(:,5)];
representa_datos_2D(HSmod,CodifValoresColores,nM,[4 5]);

ValoresColores(:,4) = Hrec;
ValoresColoresNormalizados(:,4) = Hrec;



save './DatosGenerados/conjunto_datos.mat' nombresDescriptores ...
                                           CodifValoresColores ...
                                           ValoresColoresNormalizados;

rmpath('./../Funciones\')

