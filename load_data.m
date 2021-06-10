function dataset = load_data(dataname)
switch dataname
   case 'EoC'
        load \Dataset\EoC.mat ...
           label_test label_train  RS_train ske_test ske_train RS_test
        dataset.XTest = RS_test;
        %i为RS
        dataset.YTest = ske_test;
        dataset.XDatabase = RS_train;
        dataset.YDatabase = ske_train;
        dataset.SketestL = label_test;
        dataset.RStestL = label_test;
        dataset.databaseL = label_train;
    case 'SBRSIR-A'
        load \Dataset\SBRSIR-A.mat ...
        RS_feature_test    RS_feature_train   RS_label_test RS_label_train Ske_feature_test Ske_feature_train ...
        Ske_label_test 
        dataset.XTest = RS_feature_test;
        %i为RS
        dataset.YTest = Ske_feature_test;
        dataset.XDatabase = RS_feature_train;
        dataset.YDatabase = Ske_feature_train;
        dataset.SketestL = Ske_label_test;
        dataset.RStestL = RS_label_test;
        dataset.databaseL = RS_label_train;
        
    case 'SBRSIR'
        load Dataset\SBRSIR.mat ...
        RS_feature_test    RS_feature_train   RS_label_test RS_label_train Ske_feature_test Ske_feature_train ...
        Ske_label_test 
    
        dataset.XTest = RS_feature_test;
        %i为RS
        dataset.YTest = Ske_feature_test;
        dataset.XDatabase = RS_feature_train;
        dataset.YDatabase = Ske_feature_train;
        dataset.SketestL = Ske_label_test;
        dataset.RStestL = RS_label_test;
        dataset.databaseL = RS_label_train;
end
end

