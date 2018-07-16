function planes = ransacSegmentationFun(XYZ1, ransacThreshold)

format long 

%an einai alitheia i istoria tou ..XYZ = obj.v;
XYZ = XYZ1(:, 1:3);

i = 1;

while (size(XYZ, 1) > 3)
 
    %set a RANSAC threshold appropriate for your data. In this case RANSAC threshold is set to 1.
    [~, ~, inliers, ~] = ransacfitplane(XYZ', ransacThreshold);
 
    for j = 1 : size(inliers, 1)
     
        inliersXYZ(j, 1:6) = XYZ1(inliers(j), 1:6);
     
    end
 
    planes{i} = inliersXYZ;
 
    XYZ([inliers], :) = [];
 
    i = i + 1;
 
    clear inliers inliersXYZ
end

end


    
    