function example(featureFolder)

% featureFolder = '../' % The folder that contains the files XYZ.txt,
% train.txt, test.txt, vectorNormals.txt
%load the XYZ1 txt file with the format
% X Y Z
XYZ1 = load(fullfile(featureFolder, 'XYZ.txt'));

%returns the different planes with RANSAC segmentation, stores them in the
%folder featureFolder and if they exist loads them from there, otherwise it
%computes them
planesFilename = fullfile(featureFolder, 'planes.mat');
if exist(planesFilename, 'file')
    load planesFilename
else
    planes = ransacSegmentationFun(XYZ1, 0.2);
    save(planesFilename,'planes');
end

for index = 1 : size(planes,2)
    
    planeD = planes{index};

    filename = 'orthoImage';
    indexstr = num2str(index);
    orthofileName = strcat(filename,indexstr);
    fullorthoFilename = fullfile(featureFolder, orthofileName);
    if exist(fullorthoFilename, 'file')
        load fullorthoFilename
    else
        [orthoImage, orthoImageCoordinates, rmat] = orthoFun(planeD, 'D:\hayko-all\ruemonge\undistorted_images_and_camera_matrix\');
        save(fullorthoFilename,'orthoImage','orthoImageCoordinates','rmat');
    end
    %created the orthoImage and the correspondence betweeen orthoImage and
    %3D space (orthoImageCoordinates)
    %[orthoImage, orthoImageCoordinates, rmat] = orthoFun(planeD, index);
    
    filename = 'indexing';
    indexingfileName = strcat(filename,indexstr);
    fullindexingfileName = fullfile(featureFolder, indexingfileName );
    if exist(fullindexingfileName, 'file')
        load fullindexingfileName
    else
        indexOfImage = pointCloudToOrthoFun(planeD, rmat, orthoImageCoordinates);
        save(fullindexingfileName,'indexOfImage');
    end
    
    
    
    %rgb/lab features
    filename = 'RGB_Lab';
    rgblabfileName = strcat(filename,indexstr);
    fullrgblabfileName = fullfile(featureFolder, rgblabfileName );
    if exist(fullrgblabfileName, 'file')
        load fullrgblabfileName
    else
        [RGBvalues, Labvalues] = RGBLABFeaturesFun(indexOfImage, orthoImage, index);
        save(fullindexingfileName,'RGBvalues','Labvalues');
    end
    
    %census features
    filename = 'Census';
    censusfileName = strcat(filename,indexstr);
    fullcensusfileName = fullfile(featureFolder, censusfileName );
    if exist(fullcensusfileName, 'file')
        load fullcensusfileName
    else
        censusFeatures = censusFeaturesFun(indexOfImage, orthoImage, index);
        save(fullcensusfileName,'censusFeatures');
    end
    
    %depth
    filename = 'depth';
    depthfileName = strcat(filename,indexstr);
    fulldepthfileName = fullfile(featureFolder, depthfileName );
    if exist(fulldepthfileName, 'file')
        load fulldepthfileName
    else
        depthFeatures = calculateDepthFun(planeD, rmat);
        save(fulldepthfileName,'depthFeatures');
    end
    
    
    %load the test train/test/vector normal files provided in github
    train = load('../train.txt');
    test = load('../test.txt');
    vectorNormals = load('../vector_normals.txt');
    %vectorNormals
    [train, test, vectorNormals] = computeTrainTestFun(train, test, vectorNormals, planeD);
    %na sumpliriwsw to load vectorNormals kai to write test train kai na
    %lew poia einai poia
    
    
   
    
    clearvars -except planes
    
end


