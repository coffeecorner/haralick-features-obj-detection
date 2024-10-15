cropFolder = uigetdir('', 'Select a folder to load images from'); 
if cropFolder == 0
    % User clicked Cancel
    return;
end

fileType = fullfile(cropFolder, '*.jpg');
%Retrieves only .jpg files from the folder

fileCount = dir(fileType);
%Total number of files in said directory

i = 1;
%This is for looping through the columns of matrix B

B = zeros(5, 14);

for k = 1 : length(fileCount)
	baseFileName = fileCount(k).name;
    %Name of the file loaded
    
	fullFileName = fullfile(fileCount(k).folder, baseFileName);
    %fullFileName is the image name
    
	fprintf(1, 'Now reading %s\n', fullFileName);
    %Will display in cmd window what picture is being read
    
	I = imread(fullFileName);
	
	[~, ~, numOfColorChannels] = size(I);
	
	if numOfColorChannels > 1
		I = rgb2gray(I);
	end

	glcm = graycomatrix(I, 'offset', [0 1], "Symmetric", true);
    
    x = HaralickTexturalFeatures(glcm, 1:14);
    %disp(x);
    
    C = transpose(x);
    %disp(C);
    
    C = round(C, 1);
    
    B(i, :) = C;
    i = i + 1;
    
    %disp(B);
    %Displays the matrix
end

disp(B);
%Displays the matrix

cropFolder = uigetdir('', 'Select a folder to load images from');
if cropFolder == 0
    % User clicked Cancel
    return;
end

fileType = fullfile(cropFolder, '*.jpg');
%Retrieves only .jpg files from the folder

fileCount = dir(fileType);
%Total number of files in said directory

i = 1;
%This is for looping through the columns of matrix B

D = zeros(5, 14);

for k = 1 : length(fileCount)
	baseFileName = fileCount(k).name;
    %Name of the file loaded
    
	fullFileName = fullfile(fileCount(k).folder, baseFileName);
    %fullFileName is the image name
    
	fprintf(1, 'Now reading %s\n', fullFileName);
    %Will display in cmd window what picture is being read
    
	I = imread(fullFileName);
	
	[~, ~, numOfColorChannels] = size(I);
	
	if numOfColorChannels > 1
		I = rgb2gray(I);
	end

	glcm = graycomatrix(I, 'offset', [0 1], "Symmetric", true);
    
    x = HaralickTexturalFeatures(glcm, 1:14);
    
    C = transpose(x);
    %disp(C);
    
    C = round(C, 1);
    
    D(i, :) = C;
    i = i + 1;
    
    %disp(D);
    %Displays the matrix
end

disp(D);

ConcatMat = cat(1, B, D);

%disp(ConcatMat);

% PredictKNN = array2table(ConcatMat);
% %Converts matrix to a table;
% 
% PredictKNN.Properties.VariableNames(1:14) = {'VarName1','VarName2', 'VarName3', 'VarName4', 'VarName5', 'VarName6', 'VarName7', 'VarName8', 'VarName9', 'VarName10', 'VarName11', 'VarName12', 'VarName13', 'VarName14',};
% %The column are renamed like the ones in WeightedKNN
% 
% save('PredictKNN.mat', 'PredictKNN');
%Saves the variable
