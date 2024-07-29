clear all
load main_input

%%pca
[pc,score,latent,tsquare] = princomp(I(:,2:end));
