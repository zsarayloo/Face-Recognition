function D=G_d_out(d,o);
[a ~]=size(d);
D=zeros(a,o);
for i=1:a
    D(i,d(i,1))=1;
end

    