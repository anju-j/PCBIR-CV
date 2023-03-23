 function prefilter= prefilter_table_gen(dataset,M,L,w,a,b,a_ind,b_ind,range)%

   prefilter=struct([]); %index= value of L    
     for i=1:L
        %to choose random hash functions- choice of a and b

        a_new=horzcat( a(:,a_ind(i,1)) , a(:,a_ind(i,2)) );
        b_new=horzcat(b(:,b_ind(i,1)), b(:,b_ind(i,2)) );
        bk=1;
        table=lsh('e2lsh',L,1,size(dataset,1),dataset,a,b,'w',w);
         
        for j=1:size(dataset,2)
             t=lsh('e2lsh',M,1,size(dataset,1),dataset(:,j),a_new,b_new,'range',range,'w',w);
             for k=1:M
                 h=t(k).buckets;
                 bkt(j,k)=h;    
             end
        end

        pre=struct([]);
        for z=1:M
              [bkts,ia,ic]=unique(bkt(:,z),'rows');
              pre(z).bkts=bkts;
              pre(z).ifv=zeros(size(bkts,1),size(dataset,2));
              for n=1:size(dataset,2)
                  pre(z).ifv(ic(n),n)=1;
              end
        end
        
        [bkt_combined,ia,ic]=unique(bkt,'rows');
        ifv_combined=zeros(1,size(dataset,2));%replace withg ones for and operation
        for g=1:size(bkt_combined,1)
            ifv_combined=zeros(1,size(dataset,2));
            for n=1:M
                 ha=bkt_combined(g,n);
                  [o,pos]=ismember(ha,pre(n).bkts);
                 if o==1
                    ifv_combined=or(ifv_combined,pre(n).ifv(pos,:));
                 end    
            end
            ifv_new(g,:)=ifv_combined(1,:);
        end
        %joining adjacent ifv
               for g=1:size(bkt_combined,1)
                   if g~=1 && g~=size(bkt_combined,1)
                        ifv_joined(g,:)=or(ifv_new(g,:),ifv_new(g-1,:));
                        ifv_joined(g,:)=or(ifv_joined(g,:),ifv_new(g+1,:));
                   else
                       if g==1
                           ifv_joined(g,:)=ifv_new(g,:);
                            ifv_joined(g,:)=or(ifv_joined(g,:),ifv_new(g+1,:));                           
                       end
                       if g==size(bkt_combined,1)
                           ifv_joined(g,:)=ifv_new(g,:);
                           ifv_joined(g,:)=or(ifv_joined(g,:),ifv_new(g-1,:));     
                       end
                   end
               end
        %-----------------------
            prefilter(i).bkt=bkt_combined;
            prefilter(i).ifv=ifv_joined;
            prefilter(i).a1=a_ind(i,1);%random indices generated alone are samved not full a and b
            prefilter(i).a2=a_ind(i,2);
            prefilter(i).b1=b_ind(i,1);
            prefilter(i).b2=b_ind(i,2);
        
           %[new_table(i).b,new_table(i).ifv]=test(a_new,b_new,dataset,M,w);%call test for each image in dataset
                 end
 end
      