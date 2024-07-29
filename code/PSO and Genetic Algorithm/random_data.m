function r=random_data(I)
[a b]=size(I);
k=randperm(a);
for i=1:a
    r(i,:)=I(k(1,i),:);
end
