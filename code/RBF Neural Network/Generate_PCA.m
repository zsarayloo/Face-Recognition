function [pca r]=Generate_PCA(train)
[a ~]=size(train);
[pc,score,latent] = princomp(train(2:a,:)','econ');
[a ~]=size(latent);
for i=1:a
    if latent(i,1)<1
        break
    end
    
    pca(:,i)=score(:,i);
end
pca=pca';
[a r]=size(pca);

    