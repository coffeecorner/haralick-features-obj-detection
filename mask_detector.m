load('SamDetected.mat');

startingFolder = 'E:\Engineering Exploration Semester IV\Application\Raw data';
if ~exist(startingFolder, 'dir')
  % If that folder doesn't exist, just start in the current folder.
  startingFolder = pwd;
end

% Get the name of the file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.jpg');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');
if baseFileName == 0
  % User clicked the Cancel button.
  return;
end
fullFileName = fullfile(folder, baseFileName);

I = imread(fullFileName);
    
[bboxes, scores] = detect(Detect, I);
%Bounding Box is the box on the image detecting where the face is located
%Score is to see how sure the Detector is when it is finding the face

for i = 1:length(scores)
     try 
        Annotation = sprintf('Confidence = %.1f', scores(i));
        %Annotation is the label around the detected face. Will also print the
        %Confidence
        I = insertObjectAnnotation(I, 'rectangle', bboxes(i, :), Annotation);
        
        %imshow(I)
        %This shows the image with the bounding box i.e. the "Yellow Box" around
        %the face 

        CroppedImage = imcrop(I, bboxes);
        %imshow(CroppedImage);
        drawnow;

    catch
            fprintf('Inconsistent data in iteration %s, skipped.\n', i);
    end
end 

I = CroppedImage;
[rows, cols, numOfColorChannels] = size(I);
	
if numOfColorChannels > 1
	I = rgb2gray(I);
end

glcm = graycomatrix(I, 'offset', [0 1], "Symmetric", true);
    
x = HaralickTexturalFeatures(glcm, 1:14);
%Bhagwaan jaane yeh kaisa chala
iFeatures = transpose(x);
%disp(C);

% // MODEL CREATION //
load('dataset1.mat')    %your Training dataset
%dataset1 chebychev 6
%dataset2 cosine 15
%dataset3 correlation 25
X = H;
Y = C;
%Test = load('haralickTestRound.mat');
%TestData = Test.H;

Mdl = fitcknn(X,Y);

%Optimzed values for the particular model
Mdl.NumNeighbors = 6;        
Mdl.Distance = 'chebychev';


Predict = predict(Mdl, iFeatures);
disp(Predict)
 