

function t = representa_datos_3D(X,Y,nombres, modelo)
    
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
    
    figure, hold on;
    
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
    
    hold off; % soltamos la grafica
    
end

