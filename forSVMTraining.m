function forSVMTraining(lrb, data_0, D_0, idx_0, clusterNum_0)
%% Initialization
[h_0, w_0] = size(data_0);
dimension  = w_0;
%% Find the threshold of the rank_th sample in each cluster.
NumInClass = zeros(1,clusterNum_0);
 for i=1:h_0
    classTemp = idx_0(i);
    NumInClass(classTemp) = NumInClass(classTemp) + 1;
 end

 rank = 10;
 for c=1:clusterNum_0
     clear tempArray;
     clear sortArray;
     count = 1;
     for i=1:h_0
         if idx_0(i) == c
              tempArray(count) = D_0(i,c);
              count = count + 1;
         end
     end
     sortArray = sort(tempArray);
     if NumInClass(c)>10
        threX(c) = sortArray(rank);
     else
        threX(c) = sortArray(NumInClass(c));
     end
 end
 %% Choose the samples near the center
 for i=1:h_0
     tempClass = idx_0(i);
     if D_0(i, tempClass) <= threX(tempClass)
         indicator(i) = 1;
     else
         indicator(i) = 0;
     end
 end
     
%% Output the SVM training file.
if lrb==0
    fid0 = fopen('SVM\SVM_data_0','wt');
elseif lrb == 1
    fid0 = fopen('SVM\SVM_data_1','wt');
elseif lrb == 2
    fid0 = fopen('SVM\SVM_data_2','wt');
end

for i=1:h_0
    if indicator(i) == 1
        fprintf(fid0,'+%d\t',idx_0(i));
        %score = bsxfun(@minus,data_0(i,:),mean(data_0(i,:),1))*coef;
        for j=1:dimension
            fprintf(fid0,'%d:%f\t',j,data_0(i,j));
        end
        fprintf(fid0,'\n');
    end
end
fclose(fid0);