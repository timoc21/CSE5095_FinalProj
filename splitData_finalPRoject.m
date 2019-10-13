%% Split Data into training, testing, and validation
rng('default') %set random number generator to default for reproducibility
imds_malaria = imageDatastore('C:\Users\TimOC\Documents\UCONN\Fall 19\CSE 5095\FinalProject\cell_images_projectData', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames'); 
[imdsTrain,imdsTest,imdsValidation] = splitEachLabel(imds_malaria,0.8,0.15,0.05);

%% Format data for tree-based model

%% Read in data

TrainingData = cell(length(imdsTrain.Files),2);
for imgNum=1:length(imdsTrain.Files)
    filepath = imdsTrain.Files{imgNum};
    temp = im2double(rgb2gray(imread(filepath)));
    TrainingData{imgNum,1} = temp;
    currLabel =cellstr(imdsTrain.Labels(imgNum));
    TrainingData{imgNum,2} = currLabel;
end

TestingData = cell(length(imdsTest.Files),2);
for imgNum=1:length(imdsTest.Files)
    filepath = imdsTest.Files{imgNum};
    temp = im2double(rgb2gray(imread(filepath)));
    TestingData{imgNum,1} = temp;
    currLabel =cellstr(imdsTest.Labels(imgNum));
    TestingData{imgNum,2} = currLabel;
end

ValidationData = cell(length(imdsValidation.Files),2);
for imgNum=1:length(imdsValidation.Files)
    filepath = imdsValidation.Files{imgNum};
    temp = im2double(rgb2gray(imread(filepath)));
    ValidationData{imgNum,1} = temp;
    currLabel =cellstr(imdsValidation.Labels(imgNum));
    ValidationData{imgNum,2} = currLabel;
end

clearvars -except imds_malaria imdsTest imdsTrain imdsValidation TrainingData TestingData ValidationData
