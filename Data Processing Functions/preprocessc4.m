function [data,arr,p] = preprocessc4(data)
    arr = cell(11,1);
    arr(1,:) = data(1,4);
    p=2;
    for i=2:length(data(:,4))
        flag=true;
        for j=1:length(arr)
            if(strcmp(data(i,4),arr(j)))
                flag = false;
                break;
            end
        end
        if(flag==true)
            arr(p,:)=data(i,4);
            p=p+1;
        end
    end
    for i=1:length(data(:,4))
        for j=1:length(arr)
            if(strcmp(data{i,4},arr(j) ))
                data{i,4} = j+4;
            end
        end
    end
end