 planes = ransacSegmentationFun(XYZ1, 0.2);
 
 for i = 1 : size(planes,2)
    
    planeD = planes{i};
    
    [orthoImage, orthoImageCoordinates, rmat] = orthoFun(planeD);
    indexOfImage = pointCloudToOrthoFun(cloudFinal, rmat, orthoImageCoordinates);
    
    
    %rgb/lab features
    RGBLABFeaturesFun(indexOdImage, orthoImage, i);
    
    %census features
    
    
    %vectorNormals
    
    
    %depth
    

        
        
        
 end
    
