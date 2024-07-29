function [nc1 nc2 center1 center2]=splitt_missclass(c1)
[a,b]=size(c1);
center=sum(c1(2:a,:),2)./b;

k=0;

for j=1:b
        k=k+1;
        d(1,k)=norm(c1(2:a,j)-center);
end
[A,B]=sort(d);
d=A(1,b);
ce=B(1,b);
cl1=c1(:,ce);
m=2;
k=0;
nc1=[];
center_nc1=cl1(2:a,1);
nc2=[];
for i=1:b
        
        di(:,i)=norm(c1(2:a,i)-center_nc1);
end
[A B]=sort(di);
num=ceil((length(B))./2) ;
for i=1:num
    nc1=[nc1,c1(:,B(1,i))];
end
[a1 s]=size(B);
num2=s-num;
for i=1:num2
    nc2=[nc2,c1(:,B(1,i+num))];
end
center1=sum(nc1(2:a,:),2)./num;
center2=sum(nc2(2:a,:),2)./num2;




    
    
    
    