function [x1,x2] = computeDist(X)
    max = 0;
    %m = length(X);
    for i=1:9999
        for j=(i+1):10000
           dist = sum(X(i,:)- X(j,:)).^2;
           if(dist > max)
              x1 = X(i,:);
              x2 = X(j,:);
              max = dist;
           end
        end
    end
    
end