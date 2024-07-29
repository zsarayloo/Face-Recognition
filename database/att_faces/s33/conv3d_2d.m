function a=conv3d_2d(b)
[z x v]=size(b);
for i=1:x
    for j=1:v
        a(i,j)=b(z,i,j);
    end
end
