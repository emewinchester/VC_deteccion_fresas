function [Ib_RF,Ib_VF] = aplica_segmentacion_2pasos(imagen,clasificadorRojoFresa)


    load '..\02_A_SegmentacionRojoFresa\03_A_Mahalanobis\DatosGenerados/parametrosMahalanobis.mat'
    load '..\02_A_SegmentacionRojoFresa\02_EliminaOutliers/DatosGenerados/datos_limpios.mat'
    load '..\02_A_SegmentacionRojoFresa\01_SelecDescriptores\DatosGenerados/modelos.mat'
    load '..\02_A_SegmentacionRojoFresa\03_B_NN\DatosGenerados/redes.mat'
    load '..\03_SegmentacionVerdeFresa\01_SelecDescriptores/DatosGenerados/modeloVerdeFresa.mat'
    
    
    % DETECTAMOS PIXELES ROJO FRESA
    codifOI = 255; % ROJO FRESA
    CodifValoresRojos = CodifValoresColores == codifOI;

    modelo = modelosSeleccionados{clasificadorRojoFresa(1),1};
    datosModelo = ValoresColoresNormalizados(:,modelo);

    clasificadorRFvsF = clasificadorRojoFresa(2);

    % mahalanobis
    if clasificadorRFvsF == 1

        centroide = parametrosMahalanobis{clasificadorRojoFresa(1),2};
        mCov = parametrosMahalanobis{clasificadorRojoFresa(1),3};
        radio = parametrosMahalanobis{clasificadorRojoFresa(1),4};

        Ib_RF = aplica_mahalanobis(imagen,modelo,...
                                centroide,mCov,radio);
    end

    % knn
    if clasificadorRFvsF == 2
        Ib_RF = aplica_knn(imagen,datosModelo,CodifValoresRojos,9,modelo);
    end

    %svm
    if clasificadorRFvsF == 3
        Ib_RF = aplica_svm(imagen,datosModelo,CodifValoresRojos,modelo);
    end

    % nn
    if clasificadorRFvsF == 4
        net = redes{clasificadorRojoFresa(1)};
        Ib_RF = aplica_nn(imagen,net,modelo);
    end

    % DETECTAMOS PIXELES VERDE FRESA
    codifOI = 128; % ROJO FRESA
    CodifValoresVerdes = CodifValoresColores == codifOI;

    modelo = modeloVerdeFresa;
    datosModelo = ValoresColoresNormalizados(:,modelo);

    Ib_VF = aplica_knn(imagen,datosModelo,CodifValoresVerdes,9,modelo);
end

