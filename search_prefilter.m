function similar_images=search_prefilter(prefilter,query,M,L,dataset,w,a,b,r)
    ifv=zeros(1,size(dataset,2));
    similar_images=[];
    
     for i=1:L
            %to choose random hash functions- choice of a and b
            a_ind1=prefilter(i).a1;
            a_ind2=prefilter(i).a2;
            b_ind1=prefilter(i).b1;
            b_ind2=prefilter(i).b2;

            a_new=horzcat(a(:,a_ind1),a(:,a_ind2));
            b_new=horzcat(b(:,b_ind1),b(:,b_ind2));
            bk=1;
           
            t=lsh('e2lsh',M,1,size(query,1),query,a_new,b_new,'range',r,'w',w);
                 for k=1:M
                     h=t(k).buckets;
                     bkt(1,k)=h;    
                 end
                [o,pos]=ismember(bkt(1,:),prefilter(i).bkt,'rows');
                if o==1 
                   ifv=or(ifv,prefilter(i).ifv(pos,:));
                end    
            bkt_all(i,:)=bkt(1,:);
                
     end

     % Image IDs of similar images
     count=1;
     for g=1:size(dataset,2)
         if(ifv(1,g)==1)
             similar_images(1,count)=g;
             count=count+1;
         end    
     end

 end