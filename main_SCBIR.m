clear;
diary /results/Results.txt;
warning('off');
diary on;
M=2;%number of hash functions/tables
%diary('result/output_run.txt');

query_set_distinct=[20,25,105,115,206,234,322,351,434,467,522,539,601,662,716,782,803,831,911,916,1045,1055,1128,1136,1227,1235,1319,1326,1428,1430,1530,1542,1621,1626,1716,1722,1829,1845,1925,1938]; %for reproducibility
query_set_similar=[27,52,113,168,209,222,315,327,401,462,520,553,611,642,723,736,814,834,920,943,1029,1064,1114,1116,1224,1284,1332,1333,1414,1486,1549,1558,1616,1622,1762,1789,1876,1891,1958,1981];%for reproducibility
query_set_entire=[59,70,122,170,207,256,301,345,402,486,520,525,627,652,713,768,805,815,906,920,1010,1027,1137,1141,1209,1222,1307,1327,1415,1427,1506,1534,1622,1651,1734,1767,1822,1839,1924,1991,2001,2062,2116,2182,2217,2245,2320,2353,2407,2449,2503,2525,2630,2678,2708,2742,2811,2842,2923,2936,3022,3055,3102,3136,3228,3232,3312,3318,3414,3434,3503,3531,3629,3640,3713,3728,3828,3854,3911,3916,4036,4046,4121,4141,4245,4255,4328,4336,4426,4430,4506,4526,4623,4625,4720,4743,4821,4834,4913,4918,5011,5012,5106,5129,5227,5235,5321,5331,5429,5464,5534,5551,5619,5626,5723,5745,5828,5830,5945,5963,6043,6047,6130,6142,6227,6228,6340,6347,6414,6416,6529,6536,6606,6625,6725,6733,6824,6884,6920,6926,7021,7026,7128,7129,7237,7238,7332,7333,7422,7430,7514,7586,7632,7633,7760,7761,7853,7858,7949,7958,8012,8021,8138,8146,8216,8222,8362,8389,8438,8454,8536,8537,8641,8642,8725,8733,8830,8832,8929,8936,9020,9028,9117,9128,9229,9245,9321,9325,9425,9438,9518,9521,9622,9630,9776,9791,9858,9881,9938,9942];%for reproducibility

 %% distinct image categories
L=12; %number of times repeated, also L hash functions are defined 
w=14;  % distance parameter for LSH
range=2000;
i=1;
rp_distinct=zeros(10,5);
time_taken_distinct=zeros(10,2);

load('dataset_combined/distinct/csd_scd_distinct.mat','csd_scd_distinct');
load('dataset_combined/distinct/csd_cld_distinct.mat','csd_cld_distinct');
load('dataset_combined/distinct/csd_ehd_distinct.mat','csd_ehd_distinct');
load('dataset_combined/distinct/csd_dcd_distinct.mat','csd_dcd_distinct');

load('dataset_combined/distinct/scd_cld_distinct.mat','scd_cld_distinct');
load('dataset_combined/distinct/scd_ehd_distinct.mat','scd_ehd_distinct');
load('dataset_combined/distinct/scd_dcd_distinct.mat','scd_dcd_distinct');

load('dataset_combined/distinct/cld_ehd_distinct.mat','cld_ehd_distinct');
load('dataset_combined/distinct/cld_dcd_distinct.mat','cld_dcd_distinct');
load('dataset_combined/distinct/ehd_dcd_distinct.mat','ehd_dcd_distinct');
disp('----------------------------------------------------------------------------------------');
disp('     Retrieval Precision using distinct image categories in Corel-10k Dataset        ');
disp('----------------------------------------------------------------------------------------');
fprintf("Feature   r=20 \t r=40  \t  r=60  r=80  r=100\n"); %top-r retrieved images
disp('----------------------------------------------------------------------------------------');

dataset=csd_scd_distinct;

[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
fmt=['\nCSD+SCD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:));  
i=i+1;
% fprintf('\nDistinct CSD+SCD 1 completed');

dataset=csd_cld_distinct;
[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
fmt=['\nCSD+CLD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:));  
i=i+1;
% fprintf('\nDistinct CSD+CLD completed');

dataset=csd_ehd_distinct;
[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
fmt=['\nCSD+EHD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:)); 
%fprintf('\nDistinct CSD+EHD completed');
i=i+1;

dataset=csd_dcd_distinct;
[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
fmt=['\nCSD+DCD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:)); 
%fprintf('\nDistinct CSD+DCD completed');
i=i+1;

L=5; 
w=6;
dataset=scd_cld_distinct;
[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
%fprintf('\nDistinct SCD+CLD completed');
fmt=['\nSCD+CLD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:)); 
i=i+1;

L=8; 
w=4;
dataset=scd_ehd_distinct;
[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
%fprintf('\nDistinct SCD+EHD completed');
fmt=['\nSCD+EHD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:)); 
i=i+1;

dataset=scd_dcd_distinct;
[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
%fprintf('\nDistinct SCD+DCD completed');
fmt=['\nSCD+DCD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:)); 
i=i+1;

L=4; 
w=4;
dataset=cld_ehd_distinct;
[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
%fprintf('\nDistinct CLD+EHD completed');
fmt=['\nCLD+EHD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:)); 
i=i+1;

dataset=cld_dcd_distinct;
[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
%fprintf('\nDistinct CLD+DCD completed');
fmt=['\nCLD+DCD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:)); 
i=i+1;

dataset=ehd_dcd_distinct;
[rp_distinct(i,:), time_taken_distinct(i,:)]= index_search(M,L,w,dataset,query_set_distinct,range); 
fmt=['\nEHD+DCD\t' repmat(' %.2f \t',1,numel(rp_distinct(i,:)))];
fprintf(fmt,rp_distinct(i,:)); 
%fprintf('\nDistinct EHD+DCD completed');
    %save('result/result_rp_distinct.mat','rp_distinct');
                                                           


%===================================Similar==================================================
rp_similar=zeros(10,5);
time_taken_similar=zeros(10,2);
load('dataset_combined/similar/csd_scd_similar.mat','csd_scd_similar');
load('dataset_combined/similar/csd_cld_similar.mat','csd_cld_similar');
load('dataset_combined/similar/csd_ehd_similar.mat','csd_ehd_similar');
load('dataset_combined/similar/csd_dcd_similar.mat','csd_dcd_similar');

load('dataset_combined/similar/scd_cld_similar.mat','scd_cld_similar');
load('dataset_combined/similar/scd_ehd_similar.mat','scd_ehd_similar');
load('dataset_combined/similar/scd_dcd_similar.mat','scd_dcd_similar');

load('dataset_combined/similar/cld_ehd_similar.mat','cld_ehd_similar');
load('dataset_combined/similar/cld_dcd_similar.mat','cld_dcd_similar');
load('dataset_combined/similar/ehd_dcd_similar.mat','ehd_dcd_similar');
i=1;
L=12; %number of times repeated, also L hash functions are defined 
w=14;
fprintf('\n');
disp('----------------------------------------------------------------------------------------');
disp('     Retrieval Precision using similar image categories in Corel-10k Dataset        ');
disp('----------------------------------------------------------------------------------------');
fprintf("Feature   r=20 \t r=40  \t  r=60  \t  r=80  \t  r=100\n"); %top-r retrieved images
disp('----------------------------------------------------------------------------------------');
dataset=csd_scd_similar;

[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
fmt=['\nCSD+SCD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:));  
i=i+1;
% fprintf('\nDistinct CSD+SCD 1 completed');

dataset=csd_cld_similar;
[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
fmt=['\nCSD+CLD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:));  
i=i+1;
% fprintf('\nDistinct CSD+CLD completed');

dataset=csd_ehd_similar;
[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
fmt=['\nCSD+EHD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:)); 
i=i+1;
%fprintf('\nDistinct CSD+EHD completed');

dataset=csd_dcd_similar;
[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
fmt=['\nCSD+DCD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:)); 
%fprintf('\nDistinct CSD+DCD completed');
i=i+1;

L=5; 
w=6;
dataset=scd_cld_similar;
[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
%fprintf('\nDistinct SCD+CLD completed');
fmt=['\nSCD+CLD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:)); 
i=i+1;
L=8; 
w=4;
dataset=scd_ehd_similar;
[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
%fprintf('\nDistinct SCD+EHD completed');
fmt=['\nSCD+EHD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:)); 
i=i+1;


dataset=scd_dcd_similar;
[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
%fprintf('\nDistinct SCD+DCD completed');
fmt=['\nSCD+DCD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:)); 
i=i+1;
L=4; 
w=4;
dataset=cld_ehd_similar;
[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
%fprintf('\nDistinct CLD+EHD completed');
fmt=['\nCLD+EHD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:)); 
i=i+1;


dataset=cld_dcd_similar;
[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
%fprintf('\nDistinct CLD+DCD completed');
fmt=['\nCLD+DCD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:)); 
i=i+1;

dataset=ehd_dcd_similar;
[rp_similar(i,:), time_taken_similar(i,:)]= index_search(M,L,w,dataset,query_set_similar,range); 
fmt=['\nEHD+DCD\t' repmat(' %.2f \t',1,numel(rp_similar(i,:)))];
fprintf(fmt,rp_similar(i,:)); 
%fprintf('\nDistinct EHD+DCD completed');
                                          
%=================================ENTIRE=================================
rp_entire=zeros(10,5);
time_taken_entire=zeros(10,2);
load('dataset_combined/entire/csd_scd_entire.mat','csd_scd_entire');
load('dataset_combined/entire/csd_cld_entire.mat','csd_cld_entire');
load('dataset_combined/entire/csd_ehd_entire.mat','csd_ehd_entire');
load('dataset_combined/entire/csd_dcd_entire.mat','csd_dcd_entire');

load('dataset_combined/entire/scd_cld_entire.mat','scd_cld_entire');
load('dataset_combined/entire/scd_ehd_entire.mat','scd_ehd_entire');
load('dataset_combined/entire/scd_dcd_entire.mat','scd_dcd_entire');

load('dataset_combined/entire/cld_ehd_entire.mat','cld_ehd_entire');
load('dataset_combined/entire/cld_dcd_entire.mat','cld_dcd_entire');
load('dataset_combined/entire/ehd_dcd_entire.mat','ehd_dcd_entire');
i=1;
range=10000;
fprintf('\n');
disp('----------------------------------------------------------------------------------------');
disp('     Retrieval Precision using all image categories in Corel-10k Dataset        ');
disp('----------------------------------------------------------------------------------------');
fprintf("Feature   r=20 \t r=40  \t  r=60   r=80   r=100\n"); %top-r retrieved images
disp('----------------------------------------------------------------------------------------');
dataset=csd_scd_entire;
L=12; 
w=14;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
fmt=['\nCSD+SCD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:));  
i=i+1;
% fprintf('\nDistinct CSD+SCD 1 completed');

dataset=csd_cld_entire;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
fmt=['\nCSD+CLD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:));  
i=i+1;
% fprintf('\nDistinct CSD+CLD completed');

dataset=csd_ehd_entire;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
fmt=['\nCSD+EHD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:));
i=i+1;
%fprintf('\nDistinct CSD+EHD completed');

dataset=csd_dcd_entire;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
fmt=['\nCSD+DCD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:)); 
%fprintf('\nDistinct CSD+DCD completed');
i=i+1;

L=5; 
w=6;
dataset=scd_cld_entire;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
%fprintf('\nDistinct SCD+CLD completed');
fmt=['\nSCD+CLD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:)); 
i=i+1;
L=8; 
w=4;
dataset=scd_ehd_entire;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
%fprintf('\nDistinct SCD+EHD completed');
fmt=['\nSCD+EHD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:)); 
i=i+1;


dataset=scd_dcd_entire;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
%fprintf('\nDistinct SCD+DCD completed');
fmt=['\nSCD+DCD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:)); 
i=i+1;

L=4; 
w=4;
dataset=cld_ehd_entire;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
%fprintf('\nDistinct CLD+EHD completed');
fmt=['\nCLD+EHD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:)); 
i=i+1;


dataset=cld_dcd_entire;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
%fprintf('\nDistinct CLD+DCD completed');
fmt=['\nCLD+DCD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:)); 
i=i+1;

dataset=ehd_dcd_entire;
[rp_entire(i,:), time_taken_entire(i,:)]= index_search(M,L,w,dataset,query_set_entire,range); 
fmt=['\nEHD+DCD\t' repmat(' %.2f \t',1,numel(rp_entire(i,:)))];
fprintf(fmt,rp_entire(i,:)); 
fprintf('\n');
%fprintf('\nDistinct EHD+DCD completed');
%----------------------------DISPLAY TIME-------------------------
disp('----------------------------------------------------------------------------------------');
disp('     Index generation time (s) using distinct, similar and entire image categories in Corel-10k Dataset        ');
disp('----------------------------------------------------------------------------------------');
fprintf("Feature   Distinct  Similar  Entire  \n"); %top-r retrieved images
disp('----------------------------------------------------------------------------------------');
i=1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nCSD+SCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 

i=i+1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nCSD+CLD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 

i=i+1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nCSD+EHD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nCSD+DCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nSCD+CLD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nSCD+EHD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nSCD+DCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nCLD+EHD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nCLD+DCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,1),time_taken_similar(i,1),time_taken_entire(i,1)];
fmt=['\nEHD+DCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
%----------------------------DISPLAY TIME-------------------------
fprintf('\n');
disp('----------------------------------------------------------------------------------------');
disp('    Search time (ms) using distinct, similar and entire image categories in Corel-10k Dataset        ');
disp('----------------------------------------------------------------------------------------');
fprintf("Feature   Distinct Similar  Entire \n "); %top-r retrieved images
disp('----------------------------------------------------------------------------------------');
fprintf('\n');
i=1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nCSD+SCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 

i=i+1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nCSD+CLD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 

i=i+1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nCSD+EHD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nCSD+DCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nSCD+CLD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nSCD+EHD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nSCD+DCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nCLD+EHD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nCLD+DCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
i=i+1;
time_all=[time_taken_distinct(i,2),time_taken_similar(i,2),time_taken_entire(i,2)];
fmt=['\nEHD+DCD\t' repmat(' %.2f \t',1,numel(time_all))];
fprintf(fmt,time_all); 
%-----------------Saving outputs---------------------
%save('result/result_rp_distinct.mat','rp_distinct');
%save('result/result_rp_similar.mat','rp_similar');
%save('result/result_rp_entire.mat','rp_entire');

%save('result/result_time_taken_distinct.mat','time_taken_distinct');
%save('result/result_time_taken_similar.mat','time_taken_similar');
%save('result/result_time_taken_entire.mat','time_taken_entire');
diary off;