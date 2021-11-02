function Ib = aplica_mahalanobis(imagen,modelo,...
                        centroide,mCov,radio)
    
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
end

