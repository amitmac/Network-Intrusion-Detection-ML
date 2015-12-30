function ans = findResult(idx)
    p=0;
    for i=1:length(idx)
       if(idx(i)==1) 
           ans(i)=0;
       else
           ans(i)=1;
       end
    end

end