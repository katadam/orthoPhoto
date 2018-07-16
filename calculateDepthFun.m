function calculateDepthFun(cloudFinal, rmat, index)

cloudFinalStrammeno = rmat*cloudFinal.';

meanZ1 = mean(cloudFinalStrammeno(:,3));

Adepth1 = zeros(size(cloudFinalStrammeno,1),1);

Adepth1(:,1) = cloudFinalStrammeno(:,3) - meanZ1;

%dlmwrite('depthSmallRegionWithouDuplicates.txt', depth1);

s1 = 'depth';
s2 = num2str(index);

s3 = strcat(s1,s2);
dlmwrite(s3, Adepth1)

end