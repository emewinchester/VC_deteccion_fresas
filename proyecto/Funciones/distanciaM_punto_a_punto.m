function dM = distanciaM_punto_a_punto(P1,P2,mCov)

        dM = sqrt((P1-P2)*pinv(mCov)*(P1-P2)');
end

