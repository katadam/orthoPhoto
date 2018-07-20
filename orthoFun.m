function [orthoImage, orthoImageCoordinates, rmat] = orthoFun(allCloud, UAVimagesFolder)

point1 = allCloud(1,1:3)';
point2 = allCloud(round(size(allCloud,1)/2) ,1:3)';
point3 = allCloud(size(allCloud,1),1:3)';

%find two normal vectors
a = point2 - point1;
b = point3 - point1;

 
%compute the normal vector
normalV = cross(a,b);

%compute the angles
M = normalV;
N = [0;0;1];
costheta = dot(M,N)/(norm(M)*norm(N));
axis = cross(M, N)/norm(cross(M,N));

c = costheta;
s = sqrt(1-c*c);
C = 1-c;

x = axis(1);
y = axis(2);
z = axis(3);

%rotation matrix
rmat = [ x*x*C+c    x*y*C-z*s  x*z*C+y*s ;
        y*x*C+z*s  y*y*C+c    y*z*C-x*s ;
        z*x*C-y*s  z*y*C+x*s  z*z*C+c   ];
    
    
%rotate all points    
for i = 1 : size(allCloud,1)
    
    point = allCloud(i,1:3);
    newpoint = rmat*point';
    pointsAll(i,1:3) = newpoint';
end

XYZ = pointsAll;


format long 
list = dir(fullfile(UAVimagesFolder,'*.txt'));
projectionMatrices = zeros(3,4,size(list,1));
imagesAll = dir(fullfile(UAVimagesFolder,'*.jpg'));

for i = 1 : size(list,1)
    V = struct2cell(list(i));
    text = load(V{1});
    projectionMatrices(1:3,1:4,i) = text;
    clear text V;
end


for i = 1 : size(imagesAll,1)
    VV = struct2cell(imagesAll(i));
    image1 = imread(VV{1});
    images{i,1} = image1;
end

XYZ = pointsAll;

minX = min(XYZ(:,1));
maxX = max(XYZ(:,1));


minY = min(XYZ(:,2));
maxY = max(XYZ(:,2));

% meanZ = mean(XYZ(:,3));

step = 0.001;

indexX = 1;


for X = minX : step : maxX %for X = minX : step : minX + step*500
   
    indexY = 1;
    
    for Y = minY : step : maxY %for Y = minY : step : minY + step*500
        
        rgbCour(1) = 0;
        rgbCour(2) = 0;
        rgbCour(3) = 0;
        counter = 0;
        
        distances = sqrt((X-XYZ(:,1)).^2 + (Y-XYZ(:,2)).^2);
        [~,index] = min(distances);
        Z = XYZ(index,3);
        
        %get back to the original cloud
        
        pointInitial = rmat'*[X; Y; Z];
        Xinit = pointInitial(1);
        Yinit = pointInitial(2);
        Zinit = pointInitial(3);
        
        %         distancesInit = sqrt((Xinit-allCloud(:,1)).^2 + (Yinit-allCloud(:,2)).^2 + Zinit-allCloud(:,3).^2);
        %         [minimumInit, indexInit] = min(dinstancesInit);
        %
        %
        %         Xinit_p =
        
        for i = 1 : size(list,1)
            
            imageN = images{i};
            P = projectionMatrices(1:3,1:4,i);
            points = [Xinit; Yinit; Zinit; 1];
            
            point = P*points;
            
            x(i,1) = point(1)/point(3);
            x(i,2) = point(2)/point(3);
            
            % end
            
            if(x(i,1)) < 1
                x(i,1) = 1;
            end
            
            if(x(i,2)) < 1
                x(i,2) = 1;
            end
            
            if (x(i,2) >1 && x(i,2)<size(imageN,1) && x(i,1)>1 && x(i,1)<size(imageN,2))
                counter = counter+1;
                i;
                rgbCour(1) = double(imageN(round(x(i,2)), round(x(i,1)), 1)) + double(rgbCour(1));
                rgbCour(2) = double(imageN(round(x(i,2)), round(x(i,1)), 2)) + double(rgbCour(2));
                rgbCour(3) = double(imageN(round(x(i,2)), round(x(i,1)), 3)) + double(rgbCour(3));
            end
        end
        
        
        %clear x
        
        %indexX
        %indexY
        
        orthoImage(indexX,indexY,1) = round(rgbCour(1)/counter);
        orthoImage(indexX,indexY,2) = round(rgbCour(2)/counter);
        orthoImage(indexX,indexY,3) = round(rgbCour(3)/counter);
        
        orthoImageCoordinates(indexX, indexY, 1) = X;
        orthoImageCoordinates(indexX, indexY, 2) = Y;
        
        indexY = indexY + 1;
        
    end
    
    
    indexX = indexX + 1;
    
    clear rgbCour
    
end

end







% 
% canonNorm = nomalV/norm(normalV);
% clear cm
% cm = mean(XYZ);
% cm=cm(1:3);
% % subtract off the column means
% XYZ0 = bsxfun(@minus,XYZ,cm);
% XYZ0 = XYZ0(:,1:3);
% [U,S,V] = svd(XYZ0,0);
% diag(S);
% P = V(:,3);
% 
%  u=cross(P/norm(P),[0,0,1]);
%  deg=asind(norm(u));
%  
% 
%  
%  [XYZnew, R, t] = AxelRot(XYZ0', deg, u, [0;0;0]);
% 
