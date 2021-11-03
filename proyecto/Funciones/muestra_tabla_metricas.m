function muestra_tabla_metricas(metricas)

    nombresMetricas = {'Sensibilidad';'Especifidad';'Precision';'FalsosPositivos'};

    % modelo 1
    MAH_1 = metricas(:,1);
    KNN_1 = metricas(:,2);
    SVM_1 = metricas(:,3);
    NN_1 = metricas(:,4);

    % modelo 2
    MAH_2 = metricas(:,5);
    KNN_2 = metricas(:,6);
    SVM_2 = metricas(:,7);
    NN_2 = metricas(:,8);

    % modelo 3
    MAH_3 = metricas(:,9);
    KNN_3 = metricas(:,10);
    SVM_3 = metricas(:,11);
    NN_3 = metricas(:,12);

    T = table(nombresMetricas,MAH_1,KNN_1,SVM_1,NN_1,...
                          MAH_2,KNN_2,SVM_2,NN_2,...
                          MAH_3,KNN_3,SVM_3,NN_3)

end

