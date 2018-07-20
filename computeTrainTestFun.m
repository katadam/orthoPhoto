function [train_New, test_New, vectorNormals_New] = computeTrainTestFun(train, test, vectorNormals, plane)

%train = load('D:\hayko_all\ruemonge_ethz_cvl_dataset_everything\ruemonge\pcl_lowres_cvpr15\Paris_RueMonge_part1_ruemonge_107_027_800px_lowres_pcl_gt_train.txt');
%test = load('D:\hayko_all\ruemonge_ethz_cvl_dataset_everything\ruemonge\pcl_lowres_cvpr15\Paris_RueMonge_part1_ruemonge_107_027_800px_lowres_pcl_gt_test.txt');

trainMine = zeros(size(train));
trainMine(:,4:6) = train(:,4:6);


testMine = zeros(size(test));
testMine(:,4:6) = test(:,4:6);

vectorNormalsMine = zeros(size(vectorNormals));
vectorNormalsMine(:,4:6) = vectorNormals(:,4:6);

for i = 1 : size(train,1)
     for j = 1 : 3
         
           st = train(i,j);
           m = sprintf('%0.4f',st);
           trainMine(i,j) = str2num(m);
           
%          splt = regexp(num2str(st), '\.', 'split');
%          
%          if size(splt) < 2) 
%          
%          dps = size(splt{2},2);
%          
%          if dps>4 || dps<4
%              m = sprintf('%0.4f',st);
%              trainMine(i,j) = str2num(m);
%          else
%              trainMine(i,j) = st;
%          end
     end
end


for i = 1 : size(test,1)
     for j = 1 : 3
         
           st = test(i,j);
           m = sprintf('%0.4f',st);
           testMine(i,j) = str2num(m);

     end
end


for i = 1 : size(vectorNormals,1)
     for j = 1 : 3
         
           st = vectorNormals(i,j);
           m = sprintf('%0.4f',st);
           vectorNormalsMine(i,j) = str2num(m);

     end
end
    

counter = 1;
%for i = 1 : 17
 %   baseFileName1 = ('D:\hayko_all\matlab_codes\OT');
 %   baseFileName2 = num2str(i);
 %   baseFileName3 = '.txt';
 %   filename = [baseFileName1, baseFileName2, baseFileName3];
    F = plane;
    
        for j = 1 : size(F,1)
            index = find(testMine(:,1) == F(j,1)  & testMine(:,3) == F(j,3));
            if size(index)>0
                test_New(counter,:) = test(index(1),:);
                counter = counter + 1;
            else
                index1 = find(testMine(:,1) == F(j,1));
                if size(index1)>0
                    test_New(counter,:) = test(index1(1),:);
                    counter = counter + 1;
                else index2 = find(testMine(:,2) == F(j,2));
                    test_New(counter,:) = test(index2(1),:);
                    counter = counter + 1;
                end
                    
            end
        end
            
    
%end

% to chnage for fully automatation

%counter = 1;
%for i = 1 : 17
    %baseFileName1 = ('D:\hayko_all\matlab_codes\OT');
    %baseFileName2 = num2str(i);
    %baseFileName3 = '.txt';
    %filename = [baseFileName1, baseFileName2, baseFileName3];
    %F = load(filename);
    
        for j = 1 : size(F,1)
            index = find(trainMine(:,1) == F(j,1)  & trainMine(:,3) == F(j,3));
            if size(index)>0
                train_New(counter,:) = train(index(1),:);
                counter = counter + 1;
            else
                index1 = find(trainMine(:,1) == F(j,1));
                if size(index1)>0
                    train_New(counter,:) = train(index1(1),:);
                    counter = counter + 1;
                else index2 = find(trainMine(:,2) == F(j,2));
                    train_New(counter,:) = train(index2(1),:);
                    counter = counter + 1;
                end
                    
            end
        end
        
         counter = 1;
         for j = 1 : size(F,1)
            index = find(vectorNormalsMine(:,1) == F(j,1)  & vectorNormalsMine(:,3) == F(j,3));
            if size(index)>0
                vectorNormals_New(counter,:) = vectorNormals(index(1),:);
                counter = counter + 1;
            else
                index1 = find(vectorNormalsMine(:,1) == F(j,1));
                if size(index1)>0
                    vectorNormals_New(counter,:) = vectorNormals(index1(1),:);
                    counter = counter + 1;
                else index2 = find(vectorNormalsMine(:,2) == F(j,2));
                    vectorNormals_New(counter,:) = vectorNormals(index2(1),:);
                    counter = counter + 1;
                end
                    
            end
        end
            
    
%end

end