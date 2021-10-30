%% SELECCÓN DE DESCRIPTORES

%% 0.- CARGAMOS LOS DATOS

clear all, close all, clc
load '../../01_ObtencionDeDatos/DatosGenerados/conjunto_datos.mat'

addpath('./Funciones/')

% variables del problema
[numMuestras, numDescriptores] = size(ValoresColores);


%% 1.- SELECCION 2 MODELOS DE COLOR CON MAYOR SEPARABILIDAD

% VALORES CODIFICACION ORIGINALES
% Pixeles Rojo Fresa: valor 255 ROJO
% Pixeles Verde Fresa: valor 128 VERDE 
% Pixeles Verde Planta: valor 64 AZUL 
% Pixeles Negro Lona: valor 32 NEGRO

% VALORES NUEVA CODIFICACION
% Pixeles Rojo Fresa: valor 1
% Pixeles Resto: valor 

% codificacion de la clase de interes
codifOI = 255;

% creamos el nuevo vector de codificaciones
CodifValoresRojo = CodifValoresColores == codifOI;
YoI = CodifValoresRojo; % output


modelosColor = [1  2  3 ; ... RGB
                4  5  6 ; ... HSI
                7  8  9 ; ... YUV
                10 11 12]; %  Lab
            
separabilidadModelosColor = zeros(size(modelosColor,1),1);


% calculamos separabilidades
for i = 1:size(modelosColor,1)

    XoI = ValoresColoresNormalizados(:,modelosColor(i,:));

    separabilidadModelosColor(i) = indiceJ(XoI',YoI');
    % representa_datos_RGB(XoI,YoI)
end




%% 2.- SELECCIONAR CONJUNTO DE 3 DESCRIPTORES CON MAYOR SEPARABILIDAD


combinaciones = combnk(1:numDescriptores,3); 
separabilidad_3_dtor = 0;


YoI = CodifValoresRojo;
for i = 1:size(combinaciones,1)
    espacio = combinaciones(i,:);
    XoI = ValoresColoresNormalizados(:,espacio);
    
    J = indiceJ(XoI',YoI');
    
    if separabilidad_3_dtor < J
        posicion = i;
        separabilidad_3_dtor = J;
    end
    
end


modelo_mejor_3_dtor = combinaciones(posicion,:); % debe salir R S L 




%% 3.- SELECCIONAR CONJUNTO DE 4 DESCRIPTORES CON MAYOR SEPARABILIDAD




resto = find(not(ismember([1:12],modelo_mejor_3_dtor))); 
separabilidad_4_dtor = 0;


for i = 1:length(resto)
    espacio = [modelo_mejor_3_dtor resto(i)];
    XoI = ValoresColoresNormalizados(:,espacio);
    
    J = indiceJ(XoI',YoI');
    
    if separabilidad_4_dtor < J
        posicion = i;
        separabilidad_4_dtor = J;
    end
    
end


modelo_mejor_4_dtor = [ modelo_mejor_3_dtor resto(posicion)]

    


%% 4.- SELECCIONAR CONJUNTO DE 5 DESCRIPTORES CON MAYOR SEPARABILIDAD
    
    
resto = find(not(ismember([1:12],modelo_mejor_4_dtor))); 
separabilidad_5_dtor = 0;


for i = 1:length(resto)
    espacio = [modelo_mejor_4_dtor resto(i)];
    XoI = ValoresColoresNormalizados(:,espacio);
    
    J = indiceJ(XoI',YoI');
    
    if separabilidad_5_dtor < J
        posicion = i;
        separabilidad_5_dtor = J;
    end
    
end


modelo_mejor_5_dtor = [ modelo_mejor_4_dtor resto(posicion)]





%% 4.- SELECCIONAR CONJUNTO DE 5 DESCRIPTORES CON MAYOR SEPARABILIDAD
    
    
resto = find(not(ismember([1:12],modelo_mejor_5_dtor))); 
separabilidad_6_dtor = 0;


for i = 1:length(resto)
    espacio = [modelo_mejor_5_dtor resto(i)];
    XoI = ValoresColoresNormalizados(:,espacio);
    
    J = indiceJ(XoI',YoI');
    
    if separabilidad_6_dtor < J
        posicion = i;
        separabilidad_6_dtor = J;
    end
    
end


modelo_mejor_6_dtor = [ modelo_mejor_5_dtor resto(posicion)]



%% 5.- SELECCION VECTORES DE CARACTERISTICAS PARA ETAPA DE CLASIFICACION

% MODELOS DE COLOR
[modelosColor separabilidadModelosColor] 

[ modelo_mejor_3_dtor separabilidad_3_dtor]
[ modelo_mejor_4_dtor separabilidad_4_dtor]
[ modelo_mejor_5_dtor separabilidad_5_dtor]
[ modelo_mejor_6_dtor separabilidad_6_dtor]

% SELECCION MANUAL:
modelosSeleccionados{1} = modelosColor(1,:); % RGB
modelosSeleccionados{2} = modelosColor(4,:); % Lab
modelosSeleccionados{3} = modelo_mejor_3_dtor; 
modelosSeleccionados{4} = modelo_mejor_4_dtor;


save './DatosGenerados/modelos.mat' modelosSeleccionados; 

rmpath('Funciones\')
clear all, clc, close all
