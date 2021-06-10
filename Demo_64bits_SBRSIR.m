function Demo_64bits_SBRSIR()
addpath(genpath(fullfile('utils/')));
seed = 0;
rng('default');
rng(seed);
param.seed = seed;
param.labels = 20;
dataname = 'SBRSIR';
%% parameters setting
% basie information
param.dataname = dataname;
param.method = 'HashCodeBook';
param.beta =13*log2(param.labels);

% method parameters
bits = [64];
nb = numel(bits);
param.bits = bits;
param.maxIter = 50; %50  100代的一般，试试80
param.sita = 15;
param.lambda = 3.2;
param.labels = 20;
%% load dataset
dataset = load_data(dataname);
for i = 1: nb
    fprintf('...method: %s\n', param.method);
    fprintf('...bit: %d\n', bits(i));
    param.bit = bits(i);
    param.num_samples = param.bit;
    result = HashCodeGeneration(dataset, param);
    disp([' mAP(Ske->RS): ' num2str(result.MapSke2RS.map, '%.4f')]);
    %save(['./result/DH2W-' dataname '-' num2str(param.bit) 'bits-' num2str(lambda) 'PR.mat'], 'result', 'param');
end
end

