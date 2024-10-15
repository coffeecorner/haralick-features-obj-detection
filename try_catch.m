load('detected file');
%This Stored the faces detected in 'trainACF' method

%I = imread('image');
% Have user browse for a file, from a specified "starting folder."
% For convenience in browsing, set a starting folder from which to browse.

%startingFolder = 'folder';
%if ~exist(startingFolder, 'dir')
  % If that folder doesn't exist, just start in the current folder.
 
  % startingFolder = pwd;
%end

% Get the name of the file that the user wants to use.
%defaultFileName = fullfile(startingFolder, '*.*');

%[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');

%if baseFileName == 0
  % User clicked the Cancel button.
  %return;
%end

%imageName = fullfile(folder, baseFileName);
%I = imread(imageName);

%imshow(I);

myFolder = uigetdir();
if myFolder == 0
    % User clicked Cancel
    return;
end

fileType = fullfile(myFolder, '*.jpg');
%Retrieves only .jpg files from the folder

theFiles = dir(fileType);
%Total number of files in said directory

fileNumber = 1;
%Index of first image that's gonna get saved

SaveFolder = uigetdir(); 
if SaveFolder == 0
    % User clicked Cancel
    return;
end


for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    %Name of the file loaded
    
    imageName = fullfile(theFiles(k).folder, baseFileName);
    %fullFileName is the image name
    
    fprintf(1, 'Now reading %s\n', imageName);
    %Will display in cmd window what picture is being read
    
    I = imread(imageName);
    
    [bboxes, scores] = detect(Detect, I);
    %Bounding Box is the box on the image detecting where the face is located
    %Score is to see how sure the Detector is when it is finding the face

    for i = 1:length(scores)
        try 
            Annotation = sprintf('Confidence = %.1f', scores(i));
        %Annotation is the label around the detected face. Will also print the
        %Confidence
        I = insertObjectAnnotation(I, 'rectangle', bboxes(i, :), Annotation);
        
        imshow(I)
        %This shows the image with the bounding box i.e. the "Yellow Box" around
        %the face 

        CroppedImage = imcrop(I, bboxes);
        imshow(CroppedImage);
        drawnow;
    
        baseFileName = sprintf('%d.jpg', fileNumber);
        %The image will be saved as x.jpg where x = 1, 2, 3..
    
        filename = fullfile(SaveFolder, baseFileName);
        %Location of where the image will be saved
    
        imwrite(CroppedImage, filename);
    
        fileNumber = fileNumber + 1;
        %When x.jpg is saved, number is incremented by 1

        catch
            fprintf('Inconsistent data in iteration %s, skipped.\n', i);
        end
    end

    
end
