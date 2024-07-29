clear all
close all
clc
%% Generate input data
load('main_input')
percent=0.5;
[traind testd]=Generate_data(I,percent);
[a b]=size(traind);

%% initialize process
traind=random_data(traind);
testd=random_data(testd);
Xi=traind(:,2:b);
de_out=traind(:,1);

X_test=testd(:,2:b)';
Y_test=testd(:,1)';


%%
Xi=Xi';
de_out=de_out';

[error rate net]=net_train_test(Xi,de_out,X_test,Y_test)
save(sprintf('Design_net.mat','net','Xi','de_out','X_test','Y_test'))

%%GA




























%%



% %%%number of neuron
% input_neuron=100;
% hidden_neuron=40;
% output_neuron=40;
% 
% %%%Generate waight
% W1=rand(input_neuron+1,hidden_neuron);
% W1=(W1-0.5)*0.6;
% 
% W2=rand(hidden_neuron+1,output_neuron);
% % Wjm=rand(1,output_neuron);
% W2=(W2-0.5)*0.6;
% % Wjm=(Wjm-0.5)*0.6;
% 
% 
% epoch=5000;
% 
% eta=0.007;  %learning rate
% % alfa=0.21;  %momentom rate
% % mu0=1;    %anxiety coefficient
% mu=zeros(1,epoch);
% mu(1,1)=mu0;
% k=zeros(1,epoch);     %confidence coefficient
% % mse_Ep=zeros(1,epoch);
% de_wcjh=0;
% de_wmjh=0;
% de_wchi=0;
% de_wmhi=0;
% %neural network-feed forward process_full propagation
% %%hidd;epoen layer
% for i=1:epoch
%     %%
%     train=random_data(train);
%     Xi=train(:,2:b);
%     de_out=train(:,1);
%     De_out=G_d_out(de_out,output_neuron);
%     Xm=mean(Xi,2);
%     Yave=mean(Xm);
%     input=[Xb,Xi];
%     
%     
%     %%
%     
%     for j=1:a
%         TPhc=input(j,:)*W1;
%         TPhm=Xm(j,:)*Whm;
%         XHh=TPhc+TPhm;
%         YHh=logsig(XHh);
%         
%         %%%output layer
%         YHh2=[Xb(j,:),YHh];
%         TPjc=YHh2*W2;
%         TPjm=Xm(j,:)*Wjm;
%         XJ=TPjc+TPjm;
%         Y_out=logsig(XJ);
%         
%         Ep=De_out(j,:)-Y_out;
%         mse_Ep(1,j)=mean(Ep).^2;
%         E1(1,j)=mse(Ep)./(output_neuron*a);
%         
%         
%         
%         %% learning process
%         delta_j=(1-Y_out)*Y_out'*Ep;
%         
%         de_wcjh=eta*YHh2'*delta_j+alfa*de_wcjh;
%         W2=W2+de_wcjh;
%         
%         de_wmjh=mu(1,i)*Xm(j,:)'*delta_j+k(1,i)*de_wmjh;
%         Wjm=Wjm+de_wmjh;
%         
%         delta_h=YHh*(1-YHh)'*delta_j*W2(2:(hidden_neuron+1),:)';
%         
%         de_wchi=eta*input(j,:)'*delta_h+alfa*de_wchi;
%         W1=W1+de_wchi;
%         
%         de_wmhi=mu(1,i)*Xm(j,:)'*delta_h+k(1,i)*de_wmhi;
%         Whm=Whm+de_wmhi;
%     end
%     mse_Ep1(1,i)=mean(mse_Ep);
%     E(1,i)=mean(E1);
%     mu(1,i+1)=Yave+E(1,i);
%     k(1,i+1)=mu0-mu(1,i+1);
%     
%     
% end
% 
% i=[1:epoch+1];
% figure
% plot(i,k,'r',i,mu)
% legend('confidence level','anxiety level')
% % testing process
% figure
% mse_Ep=mean(mse_Ep1);
% plot(mse_Ep1)
% 
% X_t=[Xb,X_test];
% test_TPhc=X_t*W1;
% test_TPhm=Xm*Whm;
% test_XHh=test_TPhc+test_TPhm;
% test_YHh=logsig(test_XHh);
% 
% %%output layer
% test_YHh2=[Xb,test_YHh];
% test_TPjc=test_YHh2*W2;
% test_TPjm=Xm*Wjm;
% test_XJ=test_TPjc+test_TPjm;
% test_Y_out=logsig(test_XJ);
% test_Y_t=test_Y_out;
% %%calculate error
% error=0;
% correct=0;
% 
% for k1=1:a
%     [R XI]=sort(test_Y_out(k1,:));
%     T=XI(1,output_neuron);
%     if T==Y_test(k1,1);
%         correct=correct+1;
%     else
%         error=error+1;
%     end
%     
%     mid=(max(max(test_Y_out(k1,:)))+min(min(test_Y_out(k1,:))))./2;
%     for j=1:output_neuron
%         if test_Y_out(k1,j)<mid
%             test_Y_t(k1,j)=0;
%         end
%     end
%     
%     
% end
% 
% 
% De_out=G_d_out(Y_test,output_neuron);
% 
% 
% test_Ep=De_out-test_Y_t;
% 
% test_mse_Ep=mean(test_Ep,2).^2;
% figure
% plot(test_mse_Ep)
% Error=(error./200)*100;
% accuracy=100-Error;
% 
% % train
% % train=random_data(train);
% % Xi=train(:,2:b);
% % de_out=train(:,1);
% % De_out=G_d_out(de_out,output_neuron);
% % Xm=mean(Xi,2);
% % Yave=mean(Xm);
% % input=[Xb,Xi];
% % 
% % X_t=input;
% % test_TPhc=X_t*W1;
% % test_TPhm=Xm*Whm;
% % test_XHh=test_TPhc+test_TPhm;
% % test_YHh=logsig(test_XHh);
% % 
% % %%output layer
% % test_YHh2=[Xb,test_YHh];
% % test_TPjc=test_YHh2*W2;
% % test_TPjm=Xm*Wjm;
% % test_XJ=test_TPjc+test_TPjm;
% % test_Y_out=logsig(test_XJ);
% % test_Y_t=test_Y_out;
% % %%calculate error
% % error=0;
% % correct=0;
% % 
% % for k1=1:a
% %     [R XI]=sort(test_Y_out(k1,:));
% %     T=XI(1,output_neuron);
% %     if T==de_out(k1,1);
% %         correct=correct+1;
% %     else
% %         error=error+1;
% %     end
% % 
% %     mid=(max(max(test_Y_out(k1,:)))+min(min(test_Y_out(k1,:))))./2;
% %     for j=1:output_neuron
% %         if test_Y_out(k1,j)<mid
% %             test_Y_t(k1,j)=0;
% %         end
% %     end
% % 
% % 
% % end
% % 
% % 
% % De_out=G_d_out(Y_test,output_neuron);
% % 
% % 
% % test_Ep=De_out-test_Y_t;
% % 
% % test_mse_Ep=mean(test_Ep,2).^2;
% % figure
% % plot(test_mse_Ep)
% % Error=(error./200)*100;
% % 
% 
% 
% 
% 
% 
% 








% 
% 
% 
% 
