% C: centroide
% P: punto

function distanciaMahalanobis = distanciaM_punto_nube_puntos(P,NP, mCov)

    distanciaMahalanobis = zeros(size(NP,1),1);
    
    numValores = size(NP,1);
    
    for j = 1:numValores
        X = NP(j,:);
        distanciaMahalanobis(j) = sqrt((X-P)*pinv(mCov)*(X-P)');
    end


end

