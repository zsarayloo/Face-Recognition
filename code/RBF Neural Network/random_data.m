function r=random_data(I)
[a b]=size(I);
k=randperm(b);
for i=1:b
    r(:,i)=I(:,k(1,i));
end
