function cost = fnc( ch )

load main_input
spread=1;
%% 
[x xt]=random_test_train(I); 
y=x(:,1)';
yt=xt(:,1)';
x=x(:,2:end)';
xt=xt(:,2:end)';
x=x(find(ch),:);
xt=xt(find(ch),:);

Yin=ind2vec(y);
Yt=ind2vec(yt);

net = newpnn(x,Yin);


yhat=(sim(net,xt));
yhat=vec2ind(yhat);

 
error=yt-yhat;
correct=find(error==0);

cost=(200-length(correct))./200;



