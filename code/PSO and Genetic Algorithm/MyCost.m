function [cost sol]= MyCost(X,n)

global NFE;
    if isempty(NFE)
        NFE=0;
    end

    NFE=NFE+1;


load main_input
spread=1;
%% 
[~,num]=sort(X);
ch=num(1:n);





[x xt]=random_test_train(I); 
y=x(:,1)';
yt=xt(:,1)';
x=x(:,2:end)';
xt=xt(:,2:end)';
x=x(ch,:);
xt=xt(ch,:);

Yin=ind2vec(y);
Yt=ind2vec(yt);

net = newpnn(x,Yin);


yhat=(sim(net,xt));
yhat=vec2ind(yhat);
 
error=yt-yhat;
correct=find(error==0);
cost=(200-length(correct))./200;
sol.channel=ch;
sol.num=n;
sol.rate=cost;



