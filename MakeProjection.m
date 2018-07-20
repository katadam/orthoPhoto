featureFolder = '../';
XYZ1 = load(fullfile(featureFolder, 'XYZ.txt'));
pr = load('./ruemonge/undistorted_images_and_camera_matrix/00001_P.txt');
XYZ1 = [XYZ1 ones(size(XYZ1,1),1)];
out = XYZ1*pr';
out = out./out(:,3);
out(:,3) = [];
im = imread('./ruemonge/undistorted_images_and_camera_matrix/00001.jpg');

idx = out(:,1) <400 & out(:,1) > -400;
idx = out(:,1) <400 & out(:,1) > -400 & out(:,2) <533.5 & out(:,2) > -533.5;
sum(idx)