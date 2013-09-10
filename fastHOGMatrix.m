function [HOGMatrix_0] = fastHOGMatrix(lrb,clusterNum, C_0)
HOGMatrix_0 = zeros(clusterNum,clusterNum);
dimension = 324;
 for i=1:clusterNum
     for j=1:clusterNum
         for m=1:dimension
             HOGMatrix_0(i,j) = HOGMatrix_0(i,j) + min(C_0(i,m),C_0(j,m));
         end
     end
 end

 minValue = 1;
 maxValue = 0;
  for i=1:clusterNum
     for j=1:clusterNum
         if HOGMatrix_0(i,j)>0.7 && HOGMatrix_0(i,j) < 0.999
            if HOGMatrix_0(i,j)>maxValue
                maxValue = HOGMatrix_0(i,j);
            end
            if HOGMatrix_0(i,j)<minValue
                minValue = HOGMatrix_0(i,j);
            end
         end
     end
  end
 
 for i=1:clusterNum
     for j=1:clusterNum
         if HOGMatrix_0(i,j)<0.7 || j<i
             HOGMatrix_0(i,j) = 0.0;
         elseif HOGMatrix_0(i,j) > 0.999
             HOGMatrix_0(i,j) = 1.0;
         else
             HOGMatrix_0(i,j) = (HOGMatrix_0(i,j)-minValue)/(maxValue-minValue);
         end
         
     end
 end
 %%
 if lrb == 0
     fid0 = fopen('postureC_0.txt','wt'); 
 elseif lrb == 1
     fid0 = fopen('postureC_1.txt','wt'); 
 elseif lrb == 2
     fid0 = fopen('postureC_2.txt','wt'); 
 end

 fprintf(fid0,'NUMBER\t%d\n',clusterNum);
 for i=1:clusterNum
     for j=1:dimension-1
         fprintf(fid0,'%f\t', C_0(i,j));
     end
     fprintf(fid0,'%f', C_0(i,dimension));
     fprintf(fid0,'\n');
 end
 fclose(fid0);
 
 if lrb == 0
     fidH = fopen('postureMatrix_0.txt','wt'); 
 elseif lrb == 1
     fidH = fopen('postureMatrix_1.txt','wt'); 
 elseif lrb == 2
     fidH = fopen('postureMatrix_2.txt','wt'); 
 end
 
 for i=1:clusterNum
     for j=1:clusterNum-1
         fprintf(fidH,'%f\t', HOGMatrix_0(i,j));
     end
     fprintf(fidH,'%f', HOGMatrix_0(i,clusterNum));
     fprintf(fidH,'\n');
 end
 fclose(fidH);
 %%
%  HOGMatrix_0
surf(HOGMatrix_0);
view(2);
colorbar;