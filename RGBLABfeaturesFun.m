function RGBLABfeaturesFun(indexOfImage, orthoImage, index)

RGBvalues = zeros(size(indexOfImage,1),3);
Labvalues = zeros(size(indexOfImage,1),3);

for i = 1 : size(indexOfImage,1)
    
    ARGBvalues(i,1) = orthoImage(indexOfImage(i,2), indexOfImage(i,3),1);
    ARGBvalues(i,2) = orthoImage(indexOfImage(i,2), indexOfImage(i,3),2);
    ARGBvalues(i,3) = orthoImage(indexOfImage(i,2), indexOfImage(i,3),3);
end

LabOrthoImage = rgb2lab(uint8(orthoImage));
figure(1000); imshow(uint8(LabOrthoImage));


for i = 1 : size(indexOfImage,1)
    
    ALabvalues(i,1) = LabOrthoImage(indexOfImage(i,2), indexOfImage(i,3),1);
    ALabvalues(i,2) = LabOrthoImage(indexOfImage(i,2), indexOfImage(i,3),2);
    ALabvalues(i,3) = LabOrthoImage(indexOfImage(i,2), indexOfImage(i,3),3);
end

s1 = 'RGBFeatures';
s2 = num2str(index);
SF1 = strcat(s1,s2);


s11 = 'LABFeatures';
SF2 = strcat(s11,s2);

dlmwrite( SF1, RGBvalues);
dlmwrite(SF2, Labvalues);

end

%save the train, test, pointCloud files

%save -ascii -double 
%dlmwrite('trainPointsSmallRegion.txt', trainFinal);
%dlmwrite('testPointsSmallRegion.txt', testFinal);
%dlmwrite('pointCloudSmallRegion.txt', cloudFinal);

