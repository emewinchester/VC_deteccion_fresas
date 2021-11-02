function Ib = aplica_knn(imagen,datosModelo,codifValores,k,modelo)
    
    % IDENTIFICAMOS LOS VALORES PARA EL FIT
    inputs_ent = datosModelo;
    outputs_ent = codifValores;

    % HACEMOS EL FIT DEL MODELO
    KNN_model = fitcknn(inputs_ent, outputs_ent,'NumNeighbors',k);
    
    % REDUCIMOS LA IMAGEN
    imagenR = imresize(imagen,0.5);
    
    % OBTNEMOS LOS DESCRIPTORES DE INTERES NORMALIZADOS
    [d1 d2 d3] = calcula_descriptores_interes(imagenR, modelo);
    
    % INICIALIZAMOS MATRIZ RESULTADO
    [N M dim] = size(imagenR);
    resultado = zeros(N,M);
    
    % RECORREMOS LAS COLUMNAS DE LA IMAGEN PARA CREAR UN SOLO INPUT
    input = [];
    for j = 1:M
        input_temp = [d1(:,j) d2(:,j) d3(:,j)];
        input = [input ; input_temp];
    end
    
    Codificacion_input = predict(KNN_model,input);
    
    
    % REOCSTRUIMOS LA SALIDA
    ind = 1;
    for j = 1:M
        resultado(:,j) = Codificacion_input(ind:ind+N-1);
        ind = ind+N;
    end
    
    
    
    
    % REESCALAMOS LA MATRIZ CODIFICADA
    [F C dim] = size(imagen);
    codifImagen = round(imresize(resultado,[F C], 'nearest'));
    Ib = codifImagen == 1;
end

