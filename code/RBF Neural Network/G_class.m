function [l1 c1]=G_class(I,i)
l1=0;
[n a]=size(I);

for j=1:a
    if I(1,j)==i
        l1=l1+1;
       c1(:,l1)=I(:,j);
    end
end