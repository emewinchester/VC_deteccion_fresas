% Funcion VisualizaColores
% Objetivo: mostrar de un color pasado por parámetro determinados pixeles
% de una imagen

% Parametros:
%   Ii: imagen entrada, puede ser a color o en escala de grises
%   Ib: Matriz binaria de mismas dimensiones que Ii, tipo logical/double
%   Color: vector con 3 valores, 0-255, codificacion RGB
%   flagRepresenta: variable opcional, true para mostrar la imagen, figure
%   Io: imagen EN COLOR de salida, que representa la informacion de Ib (1s
%   binarios) en el color especificado en Color, sobre la imagen de entrada
%   Ii




function Io = VisualizaColores(Ii, Ib, Color, flagRepresenta, varargin)
    
    [numF, numC, numComp] = size(Ii);
    
    I = Ii;
    
    % si tenemos una imagen en escala de grises, la pasamos a color
    if numComp == 1
        I = cat(3,Ii,Ii,Ii);
    end
    
    % Separamos por componentes
    R = I(:,:,1);
    G = I(:,:,2);
    B = I(:,:,3);
    
    % modificamos los valores
    R(Ib) = Color(1);
    G(Ib) = Color(2);
    B(Ib) = Color(3);
    
    % creamos imagen de salida
    Io = cat(3,R,G,B);
    
    % Mostramos la imagen si es necesario
    if nargin == 4 && flagRepresenta
        figure, imshow(Io);
    end
    
end


% varargin indica que puedo pasar un numero indeterminado de argumentos a
% la funcion (argumentos de entrada variables)

% narargin: numero de argumentos de entrada

