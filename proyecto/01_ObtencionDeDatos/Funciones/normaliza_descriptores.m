function ValoresColoresNormalizados = normaliza_descriptores(ValoresColores)

    % R G B
    Rnorm = ValoresColores(:,1)/255;
    Gnorm = ValoresColores(:,2)/255;
    Bnorm = ValoresColores(:,3)/255;
    
    % H S I
    Hnorm = ValoresColores(:,4);
    Snorm = ValoresColores(:,5);
    Inorm = ValoresColores(:,6)/255;
    
    % Y U V
    Ynorm = ValoresColores(:,7);
    Unorm = (ValoresColores(:,8)-(-0.436)) / (0.436 - (-0.436));
    Vnorm = (ValoresColores(:,9)-(-0.615)) / (0.615 - (-0.615));
    
    % L a b
    Lnorm = ValoresColores(:,10)/100;
    anorm = (ValoresColores(:,11)-(-128)) / (127 - (-128));
    bnorm = (ValoresColores(:,12)-(-128)) / (127 - (-128));
    
    
    ValoresColoresNormalizados = [ Rnorm Gnorm Bnorm ...
                                   Hnorm Snorm Inorm ...
                                   Ynorm Unorm Vnorm ...
                                   Lnorm anorm bnorm ];
                                   
end

