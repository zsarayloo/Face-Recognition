function [error rate net]=net_train_test(Xi,de_out,X_test,Y_test)

Target=ind2vec(de_out); 
% net = patternnet(60);
% net.trainFcn = 'trainlm';
% net.layers{1}.transferFcn='radbas';
net = newpnn(Xi,Target);

% net = train(net,Xi,Target);
% % [net,~,~,~,~,tr]=adapt(net,Xi,Target);
% % view(net)
% 
% %testing
% 
% 
Target_test=ind2vec(Y_test); 

Tc=Target_test;

y = sim(net,X_test);
classes = vec2ind(y);
% 
 error=Y_test-classes;
 correct=find(error==0);
 size_c=size(correct);
 rate=(size_c(1,2)./200).*100;


