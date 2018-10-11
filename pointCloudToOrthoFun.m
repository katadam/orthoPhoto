%cloudFinal is the final cloud that is used to extract features
%first point cloud was cloudAll (from geomagic - problem with
%correspondences due to precision)

%trainFinal and testFinal are the regions used to compare the results

function  indexOfImage = pointCloudToOrthoFun(cloudFinal, rmat, orthoImageCoordinates, index)

cloudFinalStrammeno = rmat*cloudFinal.';


 cloudFinalStrammeno = cloudFinalStrammeno';
 
 indexOfImage = zeros(size(cloudFinalStrammeno,1),3);

for i = 1 : size(cloudFinalStrammeno,1)
    
    point = cloudFinalStrammeno(i,:);
    distancesN(:,:) = sqrt((point(1,1)- orthoImageCoordinates(:,:,1)).^2 + (point(1,2)-orthoImageCoordinates(:,:,2)).^2);
    
    [value, ind] = min(min(distancesN));
    
    indexOrth = find(distancesN == value);
    
    [I,J] = ind2sub([size(orthoImageCoordinates,1) size(orthoImageCoordinates,2)],indexOrth);
    
    indexI = round(I);
    indexJ = round(J);
    
    indexOfImage(i,1) = i;
    indexOfImage(i,2) = I(1);
    indexOfImage(i,3) = J(1);
    indexOfImage(i,4) = ind;
    
    
    s1 = 'indexToOrtho';
    s2 = num2str(index);
    s3 = strcat(s1,s2);
    dlmwrite(s3,indexOfImage);
    
end
end
    
    
    