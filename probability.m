function prob = probability(ans,y)

    count=0;
    for i=1:length(ans)
        if(y(i)==ans(i))
            count=count+1;
        end
    end
    prob = (count*100)./length(ans);

end