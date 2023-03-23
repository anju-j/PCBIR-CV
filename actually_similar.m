function count_array=actually_similar(qu,i)
    category= ceil(qu/100);% 100 is size of each category
    high=category*100;
    low=high-100+1;
    count=0;
    count_array=zeros(1,12);
    count_array(11)=size(i,1);
%     fprintf('\n------------Query %d------------- ',qu);
    flag=0;
    index=0;
        for k=1:10
             in=k*10;
              for z=1:in
                 if z>size(i,1)
                    break;
                end
                  if i(z,1)>=low && i(z,1)<=high
                        count=count+1;
                 end
                 
              end
              count_array(1,k)=count;
              count=0; 
         end
%-------find recall
count_all=0;
for g=1:size(i,1)
     if i(g,1)>=low && i(g,1)<=high
        count_all=count_all+1;
     end
end
count_array(1,12)=count_all;
%----------------
end