 planes = ransacSegmentationFun(XYZ1, 0.2);
 
 for index = 1 : size(planes,2)
    
    planeD = planes{index};
    
    [orthoImage, orthoImageCoordinates, rmat] = orthoFun(planeD);
    indexOfImage = pointCloudToOrthoFun(cloudFinal, rmat, orthoImageCoordinates);
    
    
    %rgb/lab features
    RGBLABFeaturesFun(indexOfImage, orthoImage, index);
    
    %census features
    censusFeaturesFun(indexOfImage, orthoImage, index)
    
    
    %vectorNormals
    
    
    %depth
    calculateDepthFun(planeD, rmat, index)
    
    clearvars -except planes
        
 end
    
