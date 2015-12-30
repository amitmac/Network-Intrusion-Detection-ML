cd 'C:\Users\Amit\Desktop\Project\Processed Data'
Xtest = load('X-Testing.txt');
ytest = load('y-Testing.txt');
centroid = [X(84252,:) ; X(17428,:)]
cd 'C:\Users\Amit\Desktop\Project\K-Means Clustering'
idx = findClosestCentroids(Xtest,centroid);
idx = findClosestCentroids(Xtest,centroid);
cd ../
ans = convert01(idx);
a = sum(ans==ytest);
b = length(Xtest);
(a/b)*100