function [di]=euq_dis(p,center,num,i)
[a b]=size(p);
data=p(2:a,:);

d=zeros(1,num(1,i));
k=0;

for j=1:b
    if p(1,j)==i
        k=k+1;
        d(1,k)=norm(data(:,j)-center(:,i));
               
    end
end
[A,B]=sort(d);
di=A(1,num(1,i));

