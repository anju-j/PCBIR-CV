function [M1,M2,S,a,b,a_ind,b_ind,gamma]=Genparam(dataset,L,w,M,query_len)
%Generate parameters
l=size(dataset,1);
% rng('default');
M1=randi([1 50],l+1,l+1);
S=randi([0,1],1,l+1);
M2=randi([1 50],l+1,l+1);

% rng('default');
a=randn(size(dataset,1),L);
b=unifrnd(0,w,1,L);%Continuous uniform random numbers

% rng('default');
    a_ind=randi([1 L],L,M);
    b_ind=randi([1 L],L,M);
gamma=randi([1 100],query_len,1);%for each query
end