function [Adepth1] = calculateDepthFun(cloudFinal, rmat)

cloudFinalStrammeno = rmat*cloudFinal.';

meanZ1 = mean(cloudFinalStrammeno(:,3));

Adepth1 = zeros(size(cloudFinalStrammeno,1),1);

Adepth1(:,1) = cloudFinalStrammeno(:,3) - meanZ1;

%dlmwrite('depthSmallRegionWithouDuplicates.txt', depth1);
end