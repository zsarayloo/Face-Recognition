function vn = mutation( v1 )
m1=find(v1);m10=find(1-v1);
r1=randsample(length(m1),1);
r2=randsample(length(m10),1);

v1(m1(r1))=0;v1(m10(r2))=1;
vn=v1;
end

