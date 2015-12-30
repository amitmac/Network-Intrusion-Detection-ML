function data = preprocessO(data)

    for i=1:length(data(:,42))
        if(strcmp(data{i,42},'normal'))
            data{i,42}=0;
        else
            data{i,42}=1;
        end
    end

end