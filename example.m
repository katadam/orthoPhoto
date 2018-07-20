%load the XYZ1 txt file with the format 
% X Y Z 
%returns the different planes with RANSAC segmentation
planes = ransacSegmentationFun(XYZ1, 0.2);
 
 for index = 1 : size(planes,2)
    
    planeD = planes{index};
    
    
    %created the orthoImage and the correspondence betweeen orthoImage and
    %3D space (orthoImageCoordinates)
    [orthoImage, orthoImageCoordinates, rmat] = orthoFun(planeD, index);
    indexOfImage = pointCloudToOrthoFun(cloudFinal, rmat, orthoImageCoordinates);
    
    
    %rgb/lab features
    RGBLABFeaturesFun(indexOfImage, orthoImage, index);
    
    %census features
    censusFeaturesFun(indexOfImage, orthoImage, index)
    
    
    %load the test train/test/vector normal files provided in github
    train = load('D:\hayko-all\ruemonge\pcl_lowres_cvpr15\train.txt');
    test = load('D:\hayko-all\ruemonge\pcl_lowres_cvpr15\test.txt');
    vectorNormals = load('D:\hayko-all\ruemonge\pcl_lowres_cvpr15\vector_normals.txt');
    %vectorNormals
    [train_New, test_New, vectorNormals_New] = computeTrainTestFun(train, test, vectorNormals, planeD);
    %na sumpliriwsw to load vectorNormals kai to write test train kai na
    %lew poia einai poia

    
    %depth
    calculateDepthFun(planeD, rmat, index)
    
    clearvars -except planes
        
 end
    
