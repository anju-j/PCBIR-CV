function [d,ind,c]=search_cbir(M1_fia,M2_fib,M1_fqa,M2_fqb)

    for i=1:size(M1_fia,2)% earlier size(M1_fia,2)
        d(i,1)=M1_fqa'*M1_fia(:,i) + M2_fqb'*M2_fib(:,i);%i replaced with img_id
    end
    [c,ind]=sort(d);
end