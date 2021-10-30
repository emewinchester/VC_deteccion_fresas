

function representa_datos_RGB(X,Y)
    
    % Clases en las que se clasifican los pixeles de un frame
    valores = unique(Y);
    
    % tantos colores como clases tengamos
    color = {'.k' ; '.b' ; '.g' ; '.r'};
    
    % Obtenemos los valores separados por componente
    R = X(:,1); G = X(:,2); B = X(:,3);
    
    figure, hold on;
    
    % recorremos el vector valores
    for i = 1:size(valores)
        
        % Obtenemos las posiciones de los pixeles de la clase en cuestion
        FoI = Y == valores(i); % filas of interest
        
        plot3(R(FoI), G(FoI), B(FoI), color{i});
        
    end
    
    % configuramos los datos de la grafica
%     title('REPRESENTACION EN RGB DE DATOS COLOR Y DATOS FONDO');
    valorMin = 0; valorMax = 1;
    axis([valorMin valorMax valorMin valorMax valorMin valorMax]);
%     xlabel('Valores Componente Roja'); ylabel('Valores Componente Verde'); zlabel('Valores Componente Azul');
%     legend('Datos Color Fondo Escena','Datos Color Seguimiento');
    
    hold off; % soltamos la grafica
    
end

