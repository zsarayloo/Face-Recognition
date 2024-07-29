
clc;close all;clear all;

%  for num_f=10:2:40
num_f=40;
load main_input
popsize=15;
pm=.5;
pc=.7;
Maxit=700;
nofsi=num_f;%number of selected inputs
%%%%%%%%%%%
% neuron=nofsi;
% net = patternnet(neuron);
% net.trainFcn = 'trainlm';
% net.layers{1}.transferFcn='radbas';
% save('pnet.mat','net');
%%%%%%%%%%%%
bit=100;%total feature
Min=inf;
pop=zeros(popsize,bit);
for i=1:popsize
%     temp=randperm(bit,nofsi);
      A = randperm(bit); 
      temp = A(1:nofsi);
    pop(i,temp)=1;
end
Fit=zeros(popsize,1);
best_fit=zeros(Maxit,1);
for i=1:popsize
  
end

for it=1:Maxit
    display(it)
        add=popsize;
    for i=1:popsize
        Fit(i)=fnc(pop(i,:));
    end
    %--------------------crossover-----------
    randnum=rand(1,popsize);
    k=1;
    for i=1:popsize
        if( randnum(i)<pc)
            if (k==1)
                k=0;
                v1=pop(i,:);
            else
                v2=pop(i,:);
                k=1;
                [pop(add+1,:),pop(add+2,:)]=crossover(v1,v2);
                Fit(add+1)=fnc(pop(add+1,:));
                Fit(add+2)=fnc(pop(add+2,:));
                add=add+2;
            end
        end
    end
    %----------------------mutation--------------
   randnum=rand(1,popsize);
    for i=1:popsize
        if(randnum(i)<pm)
             
                pop(add+1,:)=mutation(pop(i,:));
            
             Fit(add+1)=fnc(pop(add+1,:));
             add=add+1;
        end
    end
    %---------------------select-------------------------

    for i=1:add-1 
        for j=i+1:add
            if Fit(i)>Fit(j)
                TEMP=pop(i,:);
                pop(i,:)=pop(j,:);
                pop(j,:)=TEMP;
                TEMP=Fit(j);
                Fit(j)=Fit(i);
                Fit(i)=TEMP;
            end
        end
    end
    if (Min > Fit(1))
        Min=Fit(1);
        xb=pop(1,:);
        Itration=it;
    end
            best_fit(it)=Min;
end

save(sprintf('feature (%d).mat',num_f),'xb','best_fit')
% end
plot(best_fit,'.-')
xlabel Generation
ylabel 'Best fitness'
chosen_ind_GA=find(xb)