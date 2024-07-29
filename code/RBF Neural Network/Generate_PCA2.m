function [pca]=Generate_PCA2(train,r)
[a ~]=size(train);
[pc,score,latent] = princomp(train(2:a,:)','econ');
[a ~]=size(latent);
for i=1:r   
    pca(:,i)=score(:,i);
end
pca=pca';

