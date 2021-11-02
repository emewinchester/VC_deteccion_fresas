% nD : nombres descriptores
% m: modelo
% datos: datos Modelo
% codif: vector de codificaciones
% r: radios
%
% REPRESENTAMOS LA NUBE
%
% Radio 1: punto más alejado de la nube de puntos de interes
% Radio 2: excluir el 3% de los puntos rojo fresa + alejados del centroide
% Radio 3: distancia minima de la nube de puntos de la clase de fondo
% Radio 4: distancia que permite la deteccion como pixeles rojo fresa de
% unicamente el 0.05% de pixeles de otros colores

function representa_radios_segmentacion_mahalanobis(c,mcov,datos,codif,r,nD,m)

    [X1,X2,X3] = meshgrid(0:1/40:1);
    Valores = [X1(:) X2(:) X3(:)];
    [NumValores temp] = size(Valores);
    distancia = [];

    for j=1:NumValores
        X = Valores(j,:);
        distancia(j,1)=sqrt((X-c)*pinv(mcov)*(X-c)');
    end
    
    figure, hold on
    
    
    for i = 1:4
        
        umbral = r(i);
    
        subplot(2,2,i) 
        t = representa_datos_3D_mod(datos,codif,nD,m);
        title([num2str(i) ' ' t.String ' - radio ' num2str(umbral)]);
 
        plot3(c(1),c(2),c(3),'*r')
        PosicionesInteres = distancia < umbral;
        datosMahal = Valores(PosicionesInteres,:);

        % REPRESENTAMOS
        x = datosMahal(:,1); y = datosMahal(:,2); z = datosMahal(:,3);
        plot3(x, y, z, '+g')
        
        hold off; % soltamos la grafica
    end

end






function t = representa_datos_3D_mod(X,Y,nombres, modelo)
    
    % Clases en las que se clasifican los pixeles de un frame
    valores = unique(Y);
    
    % Obtenemos los nombres de los descriptores
    nd1 = nombres{modelo(1)};
    nd2 = nombres{modelo(2)};
    nd3 = nombres{modelo(3)};
    
    % tantos colores como clases tengamos
    color = {'.k' ; '.b' ; '.g' ; '.r'};
    
    % Obtenemos los valores separados por componente
    A = X(:,1); B = X(:,2); C = X(:,3);
    
    hold on;
    
    % recorremos el vector valores
    for i = 1:size(valores)
        
        % Obtenemos las posiciones de los pixeles de la clase en cuestion
        FoI = Y == valores(i); % filas of interest
        
        plot3(A(FoI), B(FoI), C(FoI), color{i});
        
    end
    
    % configuramos los datos de la grafica
    t = title(['REPRESENTACION DESCRIPTORES ' nd1 nd2 nd3]);
    valorMin = 0; valorMax = 1;
    axis([valorMin valorMax valorMin valorMax valorMin valorMax]);
    xlabel(['Descriptor ' nd1]);
    ylabel(['Descriptor ' nd2]);
    zlabel(['Descriptor ' nd3]);
    legend('Datos Fondo','Datos Color Interes');
    

    
end
