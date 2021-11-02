

function representa_datos_2D(X,Y,nombres, modelo)
    
    % Clases en las que se clasifican los pixeles de un frame
    valores = unique(Y);
    
    % Obtenemos los nombres de los descriptores
    nd1 = nombres{modelo(1)};
    nd2 = nombres{modelo(2)};

    
    % tantos colores como clases tengamos
    color = {'.k' ; '.b' ; '.g' ; '.r'};
    
    
    % Obtenemos los valores separados por componente
    A = X(:,1); B = X(:,2);
    
    figure, hold on;
    
    % recorremos el vector valores
    for i = 1:size(valores)
        
        % Obtenemos las posiciones de los pixeles de la clase en cuestion
        FoI = Y == valores(i); % filas of interest
        
        plot(A(FoI), B(FoI), color{i});
        
    end
    
    % configuramos los datos de la grafica
    title(['REPRESENTACION DESCRIPTORES ' nd1 nd2]);
    valorMinA = min(A); valorMaxA = max(A);
    valorMinB = min(B); valorMaxB = max(B);
    axis([valorMinA valorMaxA valorMinB valorMaxB]);
    xlabel(['Descriptor ' nd1]);
    ylabel(['Descriptor ' nd2]);
    legend('Datos Color Negro Lona','Datos Color Verde Planta' , ...
        'Datos Color Verde Fresa', 'Datos Color Rojo Fresa');
    
    hold off; % soltamos la grafica
    
end
