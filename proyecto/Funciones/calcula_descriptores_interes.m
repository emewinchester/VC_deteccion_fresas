function [d1 d2 d3] = calcula_descriptores_interes(imagen, modelo)
    
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
    
    % CONCATENAMOS LAS MATRICES
    descriptores = cat(3,Rnorm,Gnorm,Bnorm,...
                        Hnorm, Snorm,Inorm,...
                        Ynorm,Unorm,Vnorm,...
                        Lnorm,anorm,bnorm);
                    
    d1 = descriptores(:,:,modelo(1));
    d2 = descriptores(:,:,modelo(2));
    d3 = descriptores(:,:,modelo(3));
    
end

