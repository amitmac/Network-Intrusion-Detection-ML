function data = preprocess2(data)

    for i=1:length(data(:,2))
        if(strcmp(data{i,2},'tcp'))
            data{i,2}=2;
        elseif(strcmp(data{i,2},'udp'))
            data{i,2}=3;
        end
        if(strcmp(data{i,2},'icmp'))
            data{i,2}=4;
        end
    end

end

