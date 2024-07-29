function [n]=Generate_num_classes(p,cluster)
[a b]=size(p);

n=zeros(1,cluster);
for i=1:cluster
    for j=1:b
        if p(1,j)==i
            n(1,i)=n(1,i)+1;
        end
    end
    
end
