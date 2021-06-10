function [BX_opt, BY_opt] = HashCodeBookCoConstruction(trainLabel, param)
bit = param.bit;
maxIter = param.maxIter;
sampleColumn = param.num_samples;
lambda = param.lambda;
labels = param.labels;
beta = param.beta;
numTrain = size(trainLabel, 1);
classnum = param.labels;
S = ones(numTrain, bit);
S(randn(numTrain, bit) < 0) = -1;

R = ones(numTrain, bit);
R(randn(numTrain, bit) < 0) = -1;

for epoch = 1:maxIter
    % sample Sc
    Sc = randperm(numTrain, sampleColumn);
    % update BX
    LX = trainLabel * trainLabel(Sc, :)' > 0;
    S = updateColumnU(S, R, LX, Sc, bit, beta,lambda, labels, sampleColumn,classnum);

    % update BY
    LY = trainLabel(Sc, :) * trainLabel' > 0;
    R = updateColumnV(R, S, LY, Sc, bit, beta,lambda,labels, sampleColumn,classnum);
end

BX_opt = S;
BY_opt = R;

end

function S = updateColumnU(S, R, LX, Sc, bit, beta,lambda,labels, sampleColumn,classnum)
m = sampleColumn;
n = size(S, 1);
for k = 1: bit
    p = LX*classnum+(1-LX)*classnum/(classnum-1);
    M = (lambda/ bit *( S * R(Sc, :)'+(2*LX-1)*beta)); 
   % TX = lambda * U * V(Sc, :)' / bit;
    AX = 1 ./ (1 + exp(-M));
    Rjk = R(Sc, k)';
    %W = S*classnum+(1-S)*classnum/(classnum-1);
    p = lambda * (p.*(LX - AX) .* repmat(Rjk, n, 1)) * ones(m, 1) / bit + m * lambda^2 * S(:, k) / (4 * bit^2);
    S_opt = ones(n, 1);
    S_opt(p < 0) = -1;
    S(:, k) = S_opt;
end
end

function R = updateColumnV(R, S, LY, Sc, bit, beta,lambda, labels,sampleColumn,classnum)
m = sampleColumn;
n = size(S, 1);
for k = 1: bit
    p = LY*classnum+(1-LY)*classnum/(classnum-1);
    M = (lambda/ bit *( S(Sc, :) * R'  +(2*LY-1)*beta));
   % TX = lambda * U(Sc, :) * V' / bit ;
    AX = 1 ./ (1 + exp(-M));
    Sjk = S(Sc, k)';
    
    p = lambda * (p'.*(LY' - AX') .* repmat(Sjk, n, 1)) * ones(m, 1)  / bit + m * lambda^2 * R(:, k) / (4 * bit^2);
    R_opt = ones(n, 1);
    R_opt(p < 0) = -1;
    R(:, k) = R_opt;
end
end

