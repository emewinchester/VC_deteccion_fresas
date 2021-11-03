%% 0.- CARGAMOS LOS DATOS DEL PROBLEMA
clear all, close all, clc


load '..\02_A_SegmentacionRojoFresa\03_A_Mahalanobis\DatosGenerados/parametrosMahalanobis.mat'
load '..\02_A_SegmentacionRojoFresa\02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
load '..\02_A_SegmentacionRojoFresa\01_SelecDescriptores\DatosGenerados/modelos.mat'
load '..\02_A_SegmentacionRojoFresa\03_B_NN\DatosGenerados/redes.mat'

addpath('../Funciones/')
addpath('../Material_Imagenes/02_MuestrasRojo/')



%% CALCULAMOS METRICAS


numImagenes = 2;
numModelos = size(modelosSeleccionados,1);

codifOI = 255; % ROJO FRESA
CodifValoresRojos = CodifValoresColores == codifOI;



for i = 1:numImagenes
    
    % LEEMOS LA IMAGEN
    imagen = imread([ 'EvRojo' num2str(i) '.tif']);
    gold = imread([ 'EvRojo' num2str(i) '_Gold.tif']);
    
    mIb = [];
    
    for j = 1:numModelos
        % APLICAMOS EL CLASIFICADOR DE MAHALANOBIS A LA IMAGEN
        
        modelo = parametrosMahalanobis{j,1};
        centroide = parametrosMahalanobis{j,2};
        mCov = parametrosMahalanobis{j,3};
        radio = parametrosMahalanobis{j,4};
        
        Ib_M = aplica_mahalanobis(imagen,modelo,...
                            centroide,mCov,radio);
                        
        % APLICAMOS CLASIFICADOR KNN
        modelo = modelosSeleccionados{j,1};
        datosModelo = ValoresColoresNormalizados(:,modelo);
        
        Ib_KNN = aplica_knn(imagen,datosModelo,CodifValoresRojos,9,modelo);

        % APLICAMOS CLASIFICADOR SVM
        Ib_SVM = aplica_svm(imagen,datosModelo,CodifValoresRojos,modelo);

        % APLICAMOS CLASIFICADOR NN
        net = redes{j};
        Ib_NN = aplica_nn(imagen,net,modelo);
        
        
        % CONCATENAMOS LOS VALORES
        mIb = cat(3,mIb, Ib_M,Ib_KNN,Ib_SVM,Ib_NN);
        
    end
    
    matricesIb{i} = mIb;
    
    % CALCULAMOS LAS METRICAS
    numClasificadores = 4;
    numMatrices = numModelos * numClasificadores; %
    m = [];
    for j = 1:numMatrices
        [Sens Esp Prec FP] = funcion_metricas(matricesIb{i}(:,:,j) , gold);
        columna = [Sens Esp Prec FP]';
        m = [m columna];
    end
    
    
    metricas{i} = m;
    m = [];


end

% CALCULAMOS EL PROMEDIO DE LAS METRICAS
promedioMetricas = zeros(size(metricas{1}));
for i = 1:numImagenes
    promedioMetricas = promedioMetricas + metricas{i};
end

promedioMetricas = promedioMetricas/numImagenes;


% MOSTRAMOS TABLA 
muestra_tabla_metricas(promedioMetricas)


%% SELECCION DE METRICA

% SELECCIONAR UN MODELO
modelo = 1; % RGB
% modelo = 2; % Lab
% modelo = 3; % RSL

% SELECCIONAR UN CLASIFICADOR
clasificador = 1; % mahalanobis
% clasificador = 2; % knn
% clasificador = 3; % svm
% clasificador = 4; % nn


if clasificador == 1
    
end

if clasificador == 2
end

if clasificador == 3
end

if clasificador == 4
end

