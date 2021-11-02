%% SELECCION DE DESCRIPTORES

%% 0.- CARGAMOS LOS DATOS

clear all, close all, clc
load '../../01_ObtencionDeDatos/DatosGenerados/conjunto_datos.mat'

addpath('./Funciones/')

% variables del problema
[numMuestras, numDescriptores] = size(ValoresColores);


%% 1.- SELECCION CONJUNTO DE 3 DESCRIPTORES CON MAYOR SEPARABILIDAD

% VALORES CODIFICACION ORIGINALES
% Pixeles Rojo Fresa: valor 255 ROJO
% Pixeles Verde Fresa: valor 128 VERDE 
% Pixeles Verde Planta: valor 64 AZUL 
% Pixeles Negro Lona: valor 32 NEGRO

% VALORES NUEVA CODIFICACION
% Pixeles Verde Fresa: valor 1
% Pixeles Resto: valor 0

% codificacion de la clase de interes
codifOI = 128;

% creamos el nuevo vector de codificaciones
CodifValoresVerde = CodifValoresColores == codifOI;
YoI = CodifValoresVerde; % output


combinaciones = combnk(1:numDescriptores,3); 
separabilidad = 0;

vector = zeros(size(combinaciones,1),1);

YoI = CodifValoresVerde;
for i = 1:size(combinaciones,1)
    espacio = combinaciones(i,:);
    XoI = ValoresColoresNormalizados(:,espacio);
    
    J = indiceJ(XoI',YoI');
    
    vector(i) = J;
    
    if separabilidad < J
        posicion = i;
        separabilidad = J;
    end
    
end


modeloVerdeFresa = combinaciones(posicion,:); % H I a
[ modeloVerdeFresa separabilidad]


save './DatosGenerados/modeloVerdeFresa.mat' modeloVerdeFresa; 

rmpath('Funciones\')
clear all, clc, close all
