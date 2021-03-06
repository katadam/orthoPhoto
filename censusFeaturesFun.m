function [censusFeatures] = censusFeaturesFun(indexOfImage, orthoPhoto)

censusFeaturesOrthoImage = zeros(size(indexOfImage,1),8);


for i = 1 : size(censusFeaturesOrthoImage,1)
    
    pixelI = indexOfImage(i,2);
    pixelJ = indexOfImage(i,3);

    F = census(pixelI, pixelJ, orthoPhoto);
    censusFeatures(i,1:8) = F;

end

end