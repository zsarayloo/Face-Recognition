function [new_center new_pattern]= update_center(new_c11,new_c12,center1,center2,center,p,embody_overlap,misclass_overlap,m,z,c)
[a b]=size(p);
[a1 b1]=size(embody_overlap);
[a2 b2]=size(misclass_overlap);
new_pattern=[];
new_center=[];

for i=1:c
    n=0;
    if m~=0
        for j=1:b2
            if i==misclass_overlap(1,j)
                n=n+1;
            end
        end
        
    end
    if z~=0
        for j=1:b1
            if i==embody_overlap(1,j)
                n=n+1;
            end
        end
        
    end
    if n==0
        
        new_pattern=[new_pattern,p(:,(5*i-4:5*i))];
        new_center=[new_center,center(:,i)];
    end
end
constant=41;


n=0;
k=new_c11(1,1);
for i=1:length(new_c11)
    if new_c11(1,i)==k
        n=n+1;
    else
        break
    end
end
[a b]=size(new_c11);
for i=1:b
    new_c11(1,i)=constant;
    if mod(i,n)==0
     constant=constant+1;
    end
end 

new_pattern=[new_pattern,new_c12,new_c11];
new_center=[new_center,center1,center2];







