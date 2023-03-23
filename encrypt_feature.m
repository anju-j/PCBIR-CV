function [M1_fia,M2_fib,fia_all,fib_all]=encrypt_feature(dataset,M1,M2,S)
    for j=1:size(dataset,2)
        f=dataset(:,j);
        l=size(f,1);

        norm_f=norm(f);
        norm_f=norm_f*norm_f;
        %f=cat(1,f,norm_f);
        f=vertcat(f,norm_f);
        %============split f based on S to fia and fib===========
        for i=1:size(S,2)
            f_value=f(i);
            if S(i)==0 || f_value==0
                fia(i,1)=f_value;
                fib(i,1)=f_value;
            else
                if f_value<0
                    a=randi([abs(round(f_value))],1,1);  
                    b=f_value-a;
                else
                    a=randi([round(f_value)],1,1);  
                    b=f_value-a;
                end
               
               fia(i,1)=a;
               fib(i,1)=b;
            end

        end
        %-----Generate encrypted f-----------------
        fia_all(:,j)=fia(:,1);
        fib_all(:,j)=fib(:,1);
    
            M1_fia(:,j)=mtimes(M1',fia(:,1));
            M2_fib(:,j)=mtimes(M2',fib(:,1));
            clear fia fib;
    end
end