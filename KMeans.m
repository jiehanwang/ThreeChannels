clear all;
clusterNum_0 = 35;
clusterNum_1 = 100;
clusterNum_2 = 50;
dimension = 324;
dimensionPCA = 100;
%% Read the data
disp('Reading data...');
disp('No.1 ...');
data_0 = xlsread('Gallery_Data_0.csv');
disp('No.2 ...');
data_1 = xlsread('Gallery_Data_1.csv');
disp('No.3 ...');
data_2 = xlsread('Gallery_Data_2.csv');
[h_0, w_0] = size(data_0);
[h_1, w_1] = size(data_1);
[h_2, w_2] = size(data_2);
disp('Data has been read!');
%% PCA
%  [coef_0,score_0,latent_0,t2_0] = princomp(data_0);
%  [coef_1,score_1,latent_1,t2_1] = princomp(data_1);
%  [coef_2,score_2,latent_2,t2_2] = princomp(data_2);
%  data_0_ = score_0(:,1:100);
%  data_1_ = score_1(:,1:100);
%  data_2_ = score_2(:,1:100);
 
%% Kmeans
disp('Kmeans...');
disp('No.1 ...');
[idx_0,C_0,sumD_0,D_0] = kmeans(data_0, clusterNum_0); % D_0: each point's distances to all the center.
disp('No.2 ...');
[idx_1,C_1,sumD_1,D_1] = kmeans(data_1, clusterNum_1);
disp('No.3 ...');
[idx_2,C_2,sumD_2,D_2] = kmeans(data_2, clusterNum_2);
disp('Kmeans complete!');

%% Write the txt
 fid0 = fopen('idx_0.txt','wt'); 
 fprintf(fid0,'NUMBER\t%d\n',h_0);
 for i=1:h_0
     fprintf(fid0,'%d\t',i-1);
     fprintf(fid0,'%d\t%f\n',idx_0(i),D_0(i,idx_0(i)));
 end
 fclose(fid0);
 
 fid1 = fopen('idx_1.txt','wt'); 
 fprintf(fid1,'NUMBER\t%d\n',h_1);
 for i=1:h_1
     fprintf(fid1,'%d\t',i-1);
     fprintf(fid1,'%d\t%f\n',idx_1(i),D_1(i,idx_1(i)));
 end
 fclose(fid1);
 
 fid2 = fopen('idx_2.txt','wt'); 
 fprintf(fid2,'NUMBER\t%d\n',h_2);
 for i=1:h_2
     fprintf(fid2,'%d\t',i-1);
     fprintf(fid2,'%d\t%f\n',idx_2(i),D_2(i,idx_2(i)));
 end
 fclose(fid2);
 %%
 HOGMatrix_0 = zeros(clusterNum_0,clusterNum_0);

 for i=1:clusterNum_0
     for j=1:clusterNum_0
         for m=1:dimension
             HOGMatrix_0(i,j) = HOGMatrix_0(i,j) + min(C_0(i,m),C_0(j,m));
         end
     end
 end

 for i=1:clusterNum_0
     for j=1:clusterNum_0
         if HOGMatrix_0(i,j)<0.7 || j<i
             HOGMatrix_0(i,j) = 0.0;
         end
     end
 end
 HOGMatrix_0
 

 
 
 
 
 
 
 
 
 
 
 