function [rp,time_final]= index_search(M,L,w,dataset,query_set,range)
num_q=size(query_set,2);

t_gen=tic;
[M1,M2,S,a,b,a_ind,b_ind,gamma]=Genparam(dataset,L,w,M,num_q);
time_taken(1,:)=toc(t_gen);
M1_inv=inv(M1);
M2_inv=inv(M2);

similar_images=struct([]);
t_enc=tic;
[M1_fia,M2_fib,~,~]=encrypt_feature(dataset,M1,M2,S);
time_taken(2,:)=toc(t_enc);
t_pre=tic;
prefilter=prefilter_table_gen(dataset,M,L,w,a,b,a_ind,b_ind,range);
time_taken(3,:)=toc(t_pre);

time_taken(4,:)=0;
time_taken(5,:)=0;
% time_taken(6,:)=0;
% time_taken(7,:)=0;
count_with_prefilter=zeros(num_q,12);
M1_fqa=zeros(size(M1,1),num_q);
M2_fqb=zeros(size(M1,1),num_q);

for u=1: num_q
    %t_q=tic;
    q_ind=query_set(u);
    query=dataset(:,q_ind);
%     disp(u);
   % query_all(:,u)=query;

      [M1_fqa(:,u),M2_fqb(:,u),fqa,fqb]=trapdoor_gen(query,M1_inv,M2_inv,S,gamma(u,1));
   
    %Without prefilter table, seach entire set of images:
%     t_search_without=tic;
%     [d,ind(:,u),c]=search_cbir(M1_fia,M2_fib,M1_fqa(:,u),M2_fqb(:,u));%---without prefilter table M1_fia,M1_fib has 129*2000- entire dataset 
%     time_taken(4,:)=time_taken(4,:)+toc(t_search_without);
%     
    %t_search_withouteuc=tic;
    %[ind_euc(:,u),ind_jd(:,u),ind_abs(:,u),ind_corr(:,u)]=search_euc(query,dataset);
    %time_taken(5,:)=time_taken(5,:)+toc(t_search_withouteuc);
    
    %actually similar
    %count_without(u,:)=actually_similar(q_ind,ind(:,u));
    %count_euc(u,:)=actually_similar(q_ind,ind_euc(:,u));
    %count_jd(u,:)=actually_similar(q_ind,ind_jd(:,u));
    %count_abs(u,:)=actually_similar(q_ind,ind_abs(:,u));
    %count_corr(u,:)=actually_similar(q_ind,ind_corr(:,u));

     similar_images(u).query=q_ind; %have Results_similar of LSH
     t_search_pre=tic;%obtaining lsh result
     similar_images(u).result=search_prefilter(prefilter,query,M,L,dataset,w,a,b,range);%all retreived image IDs by LSH for query u is in similar_images(u).result
        time_taken(4,:)=time_taken(4,:)+toc(t_search_pre);
     %generate M1_fia and M2_fib for these retrived image features alone
	if isempty(similar_images(u).result)~=1
     M1_fia_lsh=zeros(size(M1_fia,1),size(similar_images(u).result,2));
     M2_fib_lsh=zeros(size(M2_fib,1),size(similar_images(u).result,2));
     for u1=1:size(similar_images(u).result,2)
         img=similar_images(u).result(u1);
         M1_fia_lsh(:,u1)=M1_fia(:,img);
         M2_fib_lsh(:,u1)=M2_fib(:,img);

     end
	 t_search_prelsh=tic;
     [d,ind_prefilter_subset(:,1),c]=search_cbir(M1_fia_lsh,M2_fib_lsh,M1_fqa(:,u),M2_fqb(:,u));%---with prefilter table M1_fia,M1_fib has 129*2000- entire dataset 
      time_taken(5,:)=time_taken(5,:)+toc(t_search_prelsh);

     for u2=1:size(ind_prefilter_subset,1)
        elt=ind_prefilter_subset(u2,1);%indices of top ranked images
        ind_prefilter(u2,1)=similar_images(u).result(elt);
    end

     similar_images(u).actually_similar=  ind_prefilter(:,1);
     count_with_prefilter(u,:)=actually_similar(q_ind,ind_prefilter(:,1));
     %similar_images(u).actually_similar_count=count_with_prefilter(u,:);
     
     %count comparing with Euclidean similar images
     %t_witheuc=tic;
     %[count_withpre_euc(u,:),similar_images(u).sorted_lsh]=actually_similar_euc(ind_euc(:,u),similar_images(u).result,dataset,query);
 	%time_taken(8,:)=toc(t_witheuc);
else
   fprintf('no matching Results_similar in LSH for query %d',u);
end
clear ind_prefilter ind_prefilter_subset;
% time_query(u,:)=toc(t_q);
[rp,time_final]=compute_final_result(count_with_prefilter,time_taken);
end
  
