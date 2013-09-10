function re = centerNumber(clusterNum,data)
[h, w] = size(data);
[idx,C,sumD,D] = kmeans(data, clusterNum);
re = sum(sumD)/h*1000;