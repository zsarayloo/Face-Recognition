% neural network by extracted features from GA and PSO
clear all
clc
ch=1; % choose GA features
% ch=2; % choos PSO features


load('main_input')
percent=0.3;
[nx nxt]=Generate_data(I,percent);

 
if ch==1
    channel=[1,2,3,5,9,10,14,18,19,20,23,27,29,30,34,35,40,41,43,48,54,56,58,59,60,62,65,69,71,79,80,81,82,91,93,96,97,98,99,100];
else
   channel=[10,2,7,93,48,19,91,90,58,94,43,85,28,64,98,66,25,13,29,54,87,80,53,18,59,84,17,50,77,92,83,75,70,4,20,15,76,46,12,22];
end
 
nx=random_data(nx);
nxt=random_data(nxt);

y=nx(:,1)';
yt=nxt(:,1)';
x=nx(:,2:end)';
xt=nxt(:,2:end)';
x=x(channel,:);
xt=xt(channel,:); 
Yin=ind2vec(y);
Yt=ind2vec(yt);

net = newpnn(x,Yin);
yhat=(sim(net,xt));
yhat=vec2ind(yhat);

 
error=yt-yhat;
correct=find(error==0);

rate=((length(correct))./length(yt))*100;