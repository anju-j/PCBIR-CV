function [rp,time_final]=compute_final_result(count_with_prefilter,time_taken)
num_q=size(count_with_prefilter,1);
rp=zeros(1,5);
time_final=zeros(1,2);%indexing and search (sec n ms)

rp(1,1)=mean(count_with_prefilter(:,2)/20);
rp(1,2)=mean(count_with_prefilter(:,4)/40);
rp(1,3)=mean(count_with_prefilter(:,6)/60);
rp(1,4)=mean(count_with_prefilter(:,8)/80);
rp(1,5)=mean(count_with_prefilter(:,10)/100);

time_final(1,1)=time_taken(1,1)+time_taken(2,1)+time_taken(3,1);%indexing time in sec
time_final(1,2)=(time_taken(5,1)/num_q)*1000;% search time in ms

