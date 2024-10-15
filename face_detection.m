load('location of labelled images')

DetectFace = selectLabels(gTruth, 'Face');
%From the table, the ROI named Face is detected

if isfolder(fullfile('TrainingData'))
    cd TrainingData
else
    mkdir TrainingData
end
addpath('TrainingData')
%If there is a folder named Training Data then open that
%Else create a folder named Training Data and then add it to the path

Train = objectDetectorTrainingData(DetectFace, 'SamplingFactor', 1, 'writeLocation',  'TrainingData');
%objectDetectorTrainingData is the method used to detect faces in Test
%dataset
%SamplingFactor - Number of example face images (not sure what it means
%though)

Detect = trainACFObjectDetector(Train, 'NumStages', 102, 'NegativeSamplesFactor', 25);
%NumStages is the iterative training process. The higher the value of
%NumStage, the higher the accuracy
%ACF creates negative samples on its own. So there's no need to feed
%negative samples

save('Detected.mat', 'Detect');
%The faces detected in the 'trainACF' method will be stored in the
%Detected.mat file

rmpath('TrainingData');
%Removes the Training Data directory from the given path

%This code has to be run just once%
