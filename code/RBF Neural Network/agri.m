%%%%Face recognition with radial basis function neural network
close all
clear all
clc

%% Generat input and Principal analysis

% load('input')
% percent=0.5;
% [train test]=Generate_data(input,percent);%Generat train&test data
load('train_data')
load('train_target')
dataset=[target;data];

train=[dataset(:,1:18),dataset(:,27:31),dataset(:,40:44),dataset(:,53:62)];
test=[dataset(:,1:2),dataset(:,7:8),dataset(:,19:26),dataset(:,45:52),dataset(:,53:55),dataset(:,58:59)];

[a sample]=size(train);


r=40;
[Pca_train]=Generate_PCA(train);%Generate pca data
[Pca_test]=Generate_PCA(test);

%% Fishers Linear Discriminant

c=8;%number of classes
pca_train=[train(1,:);Pca_train];

SB=between_class_scatter(pca_train,c);

SW=within_class_scatter(pca_train,c);

[eig_vector,eig_value]=eigs(SW,SB,c-1);

Pattern=abs(eig_vector)'*Pca_train;

p=[train(1,:);Pattern];

%% FLD for test data
c=8;%number of classes
pca_test=[test(1,:);Pca_test];

SB_test=between_class_scatter(pca_test,c);

SW_test=within_class_scatter(pca_test,c);

[eig_vector_test,eig_value_test]=eigs(SW_test,SB_test,c-1);

Pattern_test=eig_vector_test'*Pca_test;

p_test=[test(1,:);Pattern_test];
%% RBF neural network

%initial value
[input_neuron ~]=size(Pattern);
output_neuron=c;


%% clustering for determine hidden neuron
cluster=c;

%%Compute center of each cluster
[center,num_cluster]=Generate_center_classes(p,cluster);

%%Compute the Eucliden distance from center

for i=1:cluster
    distance(1,i)=euq_dis(p,center,num_cluster,i);
end

%%Find overlapped cluster


for k=1:cluster
    for j=1:cluster
        
        if j==k
            dc(k,j)=0;
        else
            dc(k,j)=norm(center(:,k)-center(:,j));
        end
    end
end

m=0;
z=0;
embody_overlap=[];
misclass_overlap=[];
re=0;
for i=1:cluster
    [A,B]=sort(dc(i,:));
    dc_min(1,i)=A(1,2);
    L=B(1,2);
    sum_dis=distance(1,i)+distance(1,L);
    diff_dis=abs(distance(1,i)-distance(1,L));
    if sum_dis>dc_min(1,i)
        
        if diff_dis<dc_min(1,i)
            
            m=m+1;
            misclass_overlap(:,m)=[i;L];
            
        else
            
            if distance(1,i)>distance(1,L)
                if z~=0
                    for K=1:z
                        if embody_overlap(1,K)==i
                            re=re+1;
                        end
                    end
                end
                if re==0
                    z=z+1;
                    embody_overlap(:,z)=[i;L];
                end
            else
                if z~=0
                    for K=1:z
                        if embody_overlap(1,K)==L
                            re=re+1;
                        end
                    end
                end
                if re==0
                    z=z+1;
                    embody_overlap(:,z)=[L;i];
                end
            end
        end
    end
    re=0;
end


%%splitt overlaped cluster
new_c11=[];
new_c12=[];
constant=40;
if m~=0
    for i=1:m
        nC1=misclass_overlap(1,i);
        [l1 c1]=G_class(p,nC1);
        [X Y Z Q]=splitt_missclass(c1);
        new_c11=[new_c11 X];
        new_c12=[new_c12 Y];
        center1(:,i)=Z;
        center2(:,i)=Q;
        cluster=cluster+1;
  
    end
end
if z~=0
    
    for i=1:z
        nC1=embody_overlap(1,i);
        [l1 c1]=G_class(p,nC1);
        [X Y Z Q]=splitt_missclass(c1);
        
        new_c11=[new_c11 X];
        new_c12=[new_c12 Y];
        center1(:,i+m)=Z;
        center2(:,i+m)=Q;
        cluster=cluster+1;
        
    end
end

%update center and distance

[new_center new_pattern]=update_center(new_c11,new_c12,center1,center2,center,p,embody_overlap,misclass_overlap,m,z,c);
[num_cluster]=Generate_num_classes(new_pattern,cluster);

for i=1:cluster
    new_distance(1,i)=euq_dis(new_pattern,new_center,num_cluster,i);
end



for k=1:cluster
    for j=1:cluster
        
        if j==k
            new_dc(k,j)=0;
        else
            new_dc(k,j)=norm(new_center(:,k)-new_center(:,j));
        end
    end
end
for i=1:cluster
    [A,B]=sort(new_dc(i,:));
    new_dc_min(1,i)=A(1,2);
end




%% determine width of RBF neuron

%initial value

beta=0.6;%confidence level
hidden_neuron=cluster;

sigma_W=abs(new_distance./(sqrt(log(beta))));
nu=abs(sum(sigma_W)./sum(new_dc_min));

sigma_B=nu.*new_dc_min;

for i=1:hidden_neuron
    if sigma_W(1,i)>sigma_B(1,i)
        sigma(i,1)=sigma_W(1,i);
    else
        sigma(i,1)=sigma_B(1,i);
    end
end


%% RBF feedforward and backward process

Weight=rand(output_neuron,hidden_neuron)-0.5;
learning_rate=0.5;

mu=1./learning_rate;
identity_m=mu.*eye(sample);


opt_epoch=150;



for epoch=1:opt_epoch
    
    input_data=random_data(p);
    Xi=p(2:input_neuron+1,:);
    Xi=Xi./(max(max(abs(Xi))));%normalize
    
    de_out=input_data(1,:);
    De_out=G_d_out(de_out',output_neuron);
    De_out=De_out';
    
    for i=1:sample
        
        X_in=repmat(Xi(:,i),1,hidden_neuron);
        R=X_in-new_center;
        for j=1:hidden_neuron
            hidden_out(j,i)=active_fun(R(:,j),sigma(j,1));
        end
        
        
    end
    
    
    
    
    % learning parameter of RBF unit
    
    for i=1:sample
        
        X_in=repmat(Xi(:,i),1,hidden_neuron);
        R=X_in-new_center;
        for j=1:hidden_neuron
            hidden_RBF(j,1)=active_fun(R(:,j),sigma(j,1));
        end
        
        
        
        RBF_output=Weight*hidden_RBF;
        
        e(:,i)=De_out(:,i)-RBF_output;
        
        %  Weight=Weight+learning_rate*e(:,i)*hidden_RBF';%learning
        %learning weight by LSE
         Weight=De_out*inv(hidden_out'*hidden_out+identity_m)*hidden_out';
        
        for j=1:hidden_neuron
            delta_center(:,j)=e(:,i)'*Weight(:,j)*(R(:,j)./(sigma(j,1).^2)).*active_fun(R(:,j),sigma(j,1));
        end
        
        
        new_center=new_center+2*learning_rate*delta_center;
        
        for j=1:hidden_neuron
            delta_sigma(:,j)=e(:,i)'*Weight(:,j)*((norm(R(:,j)).^2)./(sigma(j,1).^3)).*active_fun(R(:,j),sigma(j,1));
        end
        sigma=sigma+2*learning_rate.*delta_sigma';
        
    end
    Error(1,epoch)=mse(e);
    
end




%% testing process

Xi_test=p_test(2:input_neuron+1,:);
Xi_test=Xi_test./(max(max(abs(Xi_test))));%normalize
de_out_test=p_test(1,:);
De_out_test=G_d_out(de_out_test',output_neuron);
De_out_test=De_out_test';

for i=1:sample
    
    X_in_test=repmat(Xi_test(:,i),1,hidden_neuron);
    R_test=X_in_test-new_center;
    for j=1:hidden_neuron
        hidden_out_test(j,i)=active_fun(R_test(:,j),sigma(j,1));
    end
end
E_test=Weight*hidden_out_test;
RBF_output_test=De_out_test-E_test;

error=0;
correct=0;
for k1=1:sample
    [R XI]=sort(RBF_output_test(:,k1));
    T=XI(output_neuron,1);
    if T==de_out_test(1,k1);
        correct=correct+1;
    else
        error=error+1;
    end
    
    
end
accuracy=100-error_rate(error,sample)
figure 
plot(Error)
title('evaluated error')

% RBF information
display('RBF neural network topology is :')
input_neuron
output_neuron
hidden_neuron


















