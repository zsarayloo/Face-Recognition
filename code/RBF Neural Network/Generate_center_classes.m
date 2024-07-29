function [center,n]=Generate_center_classes(p,cluster)
[a b]=size(p);
data=p(2:a,:);

mean_Xi=zeros(a-1,cluster);
n=zeros(1,cluster);
for i=1:cluster
    for j=1:b
        if p(1,j)==i
            mean_Xi(:,i)=mean_Xi(:,i)+data(:,j);
            n(1,i)=n(1,i)+1;
        end
    end
    
end
number=repmat(n,a-1,1);
center=mean_Xi./number;

