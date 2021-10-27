%% añadir descripcion de la funcion

function ValoresColores = calcula_descriptores_imagen(imagen,muestra,codigo)

    % CALCULO R G B
    R = double(imagen(:,:,1));
    G = double(imagen(:,:,2));
    B = double(imagen(:,:,3));
    
    % CALCULO I 
    I = (R+G+B)/3;
    
    % CALCULO HSV -> H S
    hsv = rgb2hsv(imagen);
    H = hsv(:,:,1);
    S = hsv(:,:,2);
    
    
    % CALCULO YUV
    % 1- Normalizamos R G B
    Rnorm = R/255;
    Gnorm = G/255;
    Bnorm = B/255;
    
    % 2- Conversion YUV
    Y = 0.299*Rnorm + 0.587*Gnorm + 0.114*Bnorm;
    U = 0.492*(Bnorm-Y);
    V = 0.877*(Rnorm-Y);
    
    
    % CALCULO L a b
    lab = rgb2lab(imagen);
    L = lab(:,:,1);
    a = lab(:,:,2);
    b = lab(:,:,3);
    
    
    % POSICIONES DE INTERES
    PoI = muestra == codigo;
    
    ValoresColores = [R(PoI) G(PoI) B(PoI) ...
                      H(PoI) S(PoI) I(PoI) ...
                      Y(PoI) U(PoI) V(PoI) ...
                      L(PoI) a(PoI) b(PoI)];

    
end













