

function representa_datos_2D(X,Y)
    
    % Clases en las que se clasifican los pixeles de un frame
    valores = unique(Y);
    
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
%     title('REPRESENTACION EN RGB DE DATOS COLOR Y DATOS FONDO');
    valorMinA = min(A); valorMaxA = max(A);
    valorMinB = min(B); valorMaxB = max(B);
    axis([valorMinA valorMaxA valorMinB valorMaxB]);
%     xlabel('Valores Componente Roja'); ylabel('Valores Componente Verde'); zlabel('Valores Componente Azul');
%     legend('Datos Color Fondo Escena','Datos Color Seguimiento');
    
    hold off; % soltamos la grafica
    
end

