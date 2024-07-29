function [x]=devide (im,w,h)
[u,v]=size(im);
d1=v/h;
d2=u/w;
k1=0;
k2=0;
for r=1:d1*d2
    for W=1:w
        for H=1:h
             x(r,W,H)=im(W+(k1*w),H+(k2*h));%x =total patch        
        end
    end
    k2=k2+1;
    if mod(r,d1)==0
        k2=0;
        k1=k1+1;
    end
end

