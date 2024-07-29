function SW=within_class_scatter(x,c)

[a b]=size(x);
ni=ceil(b./c);
data=x(2:a,:);

mean_Xi=zeros(a-1,c);

for i=1:c
    for j=1:b
        if x(1,j)==i
            mean_Xi(:,i)=mean_Xi(:,i)+data(:,j);
        end
    end
end

mean_Xi=mean_Xi./ni;

SW=0;
s=0;
for i=1:c
    for j=1:b
        if x(1,j)==i
            q=(data(:,j)-mean_Xi(:,i))*(data(:,j)-mean_Xi(:,i))';
            s=s+q;
        end
    end
    SW=SW+s;
    s=0;
end







