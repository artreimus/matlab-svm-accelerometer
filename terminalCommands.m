%% TERMINAL COMMANDS
%% TERMINAL COMMANDS FOR TRAINING
% load data_name; 
% trainingData = array2table(normalizedHilbertSpectrum);
% trainingData.Group = labels;

%% TERMINAL COMMAND FOR SAVING THE EXPORT MODELS TO A .mat file
% save("svmModelStatus.mat", "svmModelStatus");
% save("svmModelClass.mat", "svmModelClass");

% load svmModelStatus
% load svmModelClass
% save("svmModels.mat", "svmModelStatus", "svmModelClass");