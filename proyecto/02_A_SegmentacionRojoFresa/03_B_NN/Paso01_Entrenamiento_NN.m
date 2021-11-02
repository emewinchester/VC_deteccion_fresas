%% 0.- CARGAMOS DATOS DEL PROBLEMA

close all, clear all, clc
load './../02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load './../01_SelecDescriptores/DatosGenerados/modelos.mat'

addpath('./../../Funciones')


%%

% SE ASUME QUE SE TRABAJA CON UN CONJUNTO DE DATOS ENTRADA-SALIDA YA CREADOS (HABR�A QUE CARGARLOS): 
% inputs-outputs. 

% inputs: en cada columna los 
% descriptores de cada muestra de entrenamiento.
% dimensiones de inputs: tantas filas como descriptores tenga y tantas
% columnas como muestras de entrenamiento haya.

% en conclusion, se traspone la matriz de los descriptores

% outputs = codificaci�n binaria de las clases asociada a cada columna de inputs.
% dimensiones outputs: tantas filas como digitos en la codificaci�n tenga y
% tantas columnas como muestras de entrenamiento haya

% la nueva versi�n de matlab admite cualquier valor para representar las
% clases.

% CREACI�N DE ESTRUCTURA DE RED

codifOI = 255;
CodifValoresRojos = CodifValoresColores == codifOI;

for i = 1:size(modelosSeleccionados,1)
    
    modelo = modelosSeleccionados{i,1};
    datosModelo = ValoresColoresNormalizados(:,modelo);
    inputs = datosModelo';
    outputs = CodifValoresRojos';
    
    [NeuronasCapaEntrada temp] = size(inputs);

    NeuronasCapaOculta1=15;
    NeuronasCapaOculta2=15;

    CapasRed = [NeuronasCapaEntrada NeuronasCapaOculta1 NeuronasCapaOculta2];
    
    % Con esta configuraci�n se crea una RN de cuatro capas:

    net=feedforwardnet(CapasRed); % Estructura de la red. 
    
    % view(net) % PARA VER LA ESTRUCTURA DE RED
    
    % ENTRENAMIENTO CON TRAIN
    net.trainParam.epochs=500; % numero maximo de epocas - normalmente para antes
    % cuando el gradiente descendiente es m�nimo o cuando el error en la muestra de validaci�n que el
    % se coge por defecto no disminuye en 6 �pocas.

    net=train(net,inputs,outputs);
    
    redes{i} = net;
    
end



save './DatosGenerados/redes.mat'  redes % PARA SALVAR LA RED ENTRENADA












