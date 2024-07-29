function s=between_class_scatter(x,c)

[a b]=size(x);
ni=ceil(b./c);
data=x(2:a,:);

mean_x=mean(data,2);
mean_Xi=zeros(a-1,c);

for i=1:c
    for j=1:b
        if x(1,j)==i
            mean_Xi(:,i)=mean_Xi(:,i)+data(:,j);
        end
    end
end

mean_Xi=mean_Xi./ni;

r=a-1;

s=zeros(r,r);
for i=1:c
    q=(mean_Xi(:,i)-mean_x)*(mean_Xi(:,i)-mean_x)';
    s=s+q;
end
s=s.*ni;

        



