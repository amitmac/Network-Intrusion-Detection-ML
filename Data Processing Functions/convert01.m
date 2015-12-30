function ans = convert01(ans)

    for i=1:length(ans)
        if(ans(i)<0)
            ans(i)=0;
        else
            ans(i)=1;
        end
    end
end