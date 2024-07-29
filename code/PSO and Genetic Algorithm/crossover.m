function [v1n,v2n] = crossover( v1,v2 )
m1=find(v1);m10=find(1-v1);
m2=find(v2);m20=find(1-v2);
r1=randsample(length(m1),1);
r2=randsample(length(m10),1);

v1(m1(r1))=0;v1(m10(r2))=1;
v2(m2(r1))=0;v2(m20(r2))=1;

v1n=v1;
v2n=v2;
end

