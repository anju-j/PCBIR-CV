function [M1_fqa,M2_fqb,fqa,fqb]=trapdoor_gen(fq,M1_inv,M2_inv,S,gamma)
fq=fq';
fq=-2*fq;
fq=horzcat(fq,1);
%============split q based on S to fia and fib===========
        for i=1:size(S,2)
            f_value=fq(i);
            if S(i)==1 || f_value==0
                fqa(i,1)=f_value;
                fqb(i,1)=f_value;
            else
              if f_value<0
                    a=randi([abs(round(f_value))],1,1);  
                    b=f_value-a;
                else
                    a=randi([round(f_value)],1,1);  
                    b=f_value-a;
              end
               
               fqa(i,1)=a;
               fqb(i,1)=b;
            end

        end
        %-----Generate encrypted f-----------------
            M1_fqa=M1_inv*fqa;
            M1_fqa=gamma*M1_fqa;
            M2_fqb=M2_inv*fqb;
            M2_fqb=gamma* M2_fqb;
end