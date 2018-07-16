%This script takes as input an .obj file and returns a cell containing all the planes extracted from
%point cloud. 3D segmentation is only based on geometry.

%obj = readObj('testransac_simplified_3d_mesh.obj'); %use appropriate file
format long 
XYZ1 = dlmread('D:\kommena\OT1.txt');
%an einai alitheia i istoria tou ..XYZ = obj.v;
XYZ = XYZ1(:, 1:3);

i = 1;

while (size(XYZ, 1) > 3)
 
    %set a RANSAC threshold appropriate for your data. In this case RANSAC threshold is set to 1.
    [B, P, inliers, A] = ransacfitplane(XYZ', 0.2);
 
    for j = 1 : size(inliers, 1)
     
        inliersXYZ(j, 1:3) = XYZ(inliers(j), 1:3);
     
    end
 
    planes{i} = inliersXYZ;
 
    XYZ([inliers], :) = [];
 
    i = i + 1;
 
    clear B P inliers A inliersXYZ
end


for i = 1 : size(planes,2)
    
    planeD = planes{i};
    
    [orthoImage, orthoImageCoordinates] = orthoFun(planeD);
    
end
    
    