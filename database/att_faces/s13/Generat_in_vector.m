function v=Generat_in_vector(I)
I = imresize(I, [100 100]);
I=im2double(I);
k=0;
for j=1:100
    for i=1:100
        k=k+1;
        v(1,k)=I(j,i);
        
    end
      
end

