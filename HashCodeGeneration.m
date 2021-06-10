function result = HashCodeGeneration(dataset, param)
%% training procedure
%trainTime = tic;
trainL = dataset.databaseL;

[HashCodeBook_X, HashCodeBook_Y] = HashCodeBookCoConstruction(trainL, param);

fprintf('...training finishes\n');

XTrain = dataset.XDatabase;
YTrain = dataset.YDatabase;

Gx = (XTrain' * XTrain + param.sita * eye(size(XTrain, 2))) \ ...
    XTrain' * HashCodeBook_X;
Gy = (YTrain' * YTrain + param.sita * eye(size(YTrain, 2))) \ ...
    YTrain' * HashCodeBook_Y;

XTest = dataset.XTest;
YTest = dataset.YTest;
RStestL = dataset.RStestL;
SketestL =dataset.SketestL;
databaseL= dataset.databaseL;
%trainTime1 = tic;
testHashCodeX = compactbit(XTest * Gx > 0);
testHashCodeY = compactbit(YTest * Gy > 0);
dBX = compactbit(HashCodeBook_X > 0);
dBY = compactbit(HashCodeBook_Y > 0);
fprintf('...generating codes for query set and compressing codes finish\n');
fprintf('...encoding finishes\n');
%% evaluation procedure
% hamming ranking
topks=[100];
topk_num=numel(topks);
for num = 1:topk_num
topk=topks(num);
hri2t = calcMapTopkMapTopkPreTopkRecLabel(databaseL, databaseL, dBX, dBY, topk)
trainTime = tic;
MapSke2RS = calcMapTopkMapTopkPreTopkRecLabel(SketestL, RStestL, testHashCodeY, testHashCodeX, topk);
trainTime = toc(trainTime);
fprintf('...searching time: %3.3f\n', trainTime);
PRske2RS = calcPreRecRadiusLabel(SketestL, RStestL, testHashCodeY, testHashCodeX);
result.MapSke2RS = MapSke2RS;
result.PRSke2RS = PRske2RS;
result.topk = topk;
result.RS = HashCodeBook_X;
result.Ske = HashCodeBook_Y;
result.testRS = testHashCodeX;
result.testSke = testHashCodeY;
disp([' topk100mAP(Ske->RS): ' num2str(result.MapSke2RS.topkMap, '%.4f')]);
end 
fprintf('...evaluating finishes\n');
end
