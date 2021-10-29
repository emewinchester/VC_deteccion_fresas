%% añadir descripcion de la funcion

function [ValoresColores, ValoresColoresN]= calcula_descriptores_imagen(imagen,muestra,codigo)

    % CALCULO R G B
    R = double(imagen(:,:,1));
    G = double(imagen(:,:,2));
    B = double(imagen(:,:,3));
    
    % CALCULO R G B normalizada
    Rnorm = R/255;
    Gnorm = G/255;
    Bnorm = B/255;
    
    % CALCULO I 
    I = (R+G+B)/3;
    
    % CALCULO I normalizada
    Inorm = (Rnorm+Gnorm+Bnorm)/3;
    
    % CALCULO H S
    hsv = rgb2hsv(imagen);
    H = hsv(:,:,1);
    S = hsv(:,:,2);
    
    % CALCULO H S normalizado
    Hnorm = H;
    Snorm = S;
    
    
    % CALCULO YUV
    % 1- Normalizamos R G B (ya hecho)
    % 2- Conversion YUV
    Y = 0.299*Rnorm + 0.587*Gnorm + 0.114*Bnorm;
    U = 0.492*(Bnorm-Y);
    V = 0.877*(Rnorm-Y);
    
    % CALCULO YUV normalizada
    Ynorm = Y;
    Unorm = mat2gray(U,[-0.436 0.436]);
    Vnorm = mat2gray(V,[-0.615 0.615]);
    
    
    % CALCULO L a b
    lab = rgb2lab(imagen);
    L = lab(:,:,1);
    a = lab(:,:,2);
    b = lab(:,:,3);
    Lnorm = L/100;
    anorm = (a-(-128)) / (127 - (-128));
    bnorm = (b -(-128)) / (127 - (-128));
    
    
    % POSICIONES DE INTERES
    PoI = muestra == codigo;
    
    ValoresColores = [R(PoI) G(PoI) B(PoI) ...
                      H(PoI) S(PoI) I(PoI) ...
                      Y(PoI) U(PoI) V(PoI) ...
                      L(PoI) a(PoI) b(PoI)];
                  
    ValoresColoresN = [ Rnorm(PoI) Gnorm(PoI) Bnorm(PoI) ...
                        Hnorm(PoI) Snorm(PoI) Inorm(PoI) ...
                        Ynorm(PoI) Unorm(PoI) Vnorm(PoI) ...
                        Lnorm(PoI) anorm(PoI) bnorm(PoI) ];

    
end













