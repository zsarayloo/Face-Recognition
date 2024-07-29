function [train1 test]=Generate_data(I,n)
[a b]=size(I);
j=1;
k=1;
for i=1:a
    C(j,k,:)=I(i,:);
    k=k+1;
    if k==11
        k=1;
        j=j+1;
    end
end

for j=1:40
    [train(j,:,:) test1(j,:,:)]=g_train_test_r(C(j,:,:),n);
end

train1=[conv3d_2d(train(1,:,:));conv3d_2d(train(2,:,:));conv3d_2d(train(3,:,:));conv3d_2d(train(4,:,:));conv3d_2d(train(5,:,:));conv3d_2d(train(6,:,:));conv3d_2d(train(7,:,:));conv3d_2d(train(8,:,:));conv3d_2d(train(9,:,:));conv3d_2d(train(10,:,:));conv3d_2d(train(11,:,:));conv3d_2d(train(12,:,:));conv3d_2d(train(13,:,:));conv3d_2d(train(14,:,:));conv3d_2d(train(15,:,:));conv3d_2d(train(16,:,:));conv3d_2d(train(17,:,:));conv3d_2d(train(18,:,:));conv3d_2d(train(19,:,:));conv3d_2d(train(20,:,:));conv3d_2d(train(21,:,:));conv3d_2d(train(22,:,:));conv3d_2d(train(23,:,:));conv3d_2d(train(24,:,:));conv3d_2d(train(25,:,:));conv3d_2d(train(26,:,:));conv3d_2d(train(27,:,:));conv3d_2d(train(28,:,:));conv3d_2d(train(29,:,:));conv3d_2d(train(30,:,:));conv3d_2d(train(31,:,:));conv3d_2d(train(32,:,:));conv3d_2d(train(33,:,:));conv3d_2d(train(34,:,:));conv3d_2d(train(35,:,:));conv3d_2d(train(36,:,:));conv3d_2d(train(37,:,:));conv3d_2d(train(38,:,:));conv3d_2d(train(39,:,:));conv3d_2d(train(40,:,:))];
test=[conv3d_2d(test1(1,:,:));conv3d_2d(test1(2,:,:));conv3d_2d(test1(3,:,:));conv3d_2d(test1(4,:,:));conv3d_2d(test1(5,:,:));conv3d_2d(test1(6,:,:));conv3d_2d(test1(7,:,:));conv3d_2d(test1(8,:,:));conv3d_2d(test1(9,:,:));conv3d_2d(test1(10,:,:));conv3d_2d(test1(11,:,:));conv3d_2d(test1(12,:,:));conv3d_2d(test1(13,:,:));conv3d_2d(test1(14,:,:));conv3d_2d(test1(15,:,:));conv3d_2d(test1(16,:,:));conv3d_2d(test1(17,:,:));conv3d_2d(test1(18,:,:));conv3d_2d(test1(19,:,:));conv3d_2d(test1(20,:,:));conv3d_2d(test1(21,:,:));conv3d_2d(test1(22,:,:));conv3d_2d(test1(23,:,:));conv3d_2d(test1(24,:,:));conv3d_2d(test1(25,:,:));conv3d_2d(test1(26,:,:));conv3d_2d(test1(27,:,:));conv3d_2d(test1(28,:,:));conv3d_2d(test1(29,:,:));conv3d_2d(test1(30,:,:));conv3d_2d(test1(31,:,:));conv3d_2d(test1(32,:,:));conv3d_2d(test1(33,:,:));conv3d_2d(test1(34,:,:));conv3d_2d(test1(35,:,:));conv3d_2d(test1(36,:,:));conv3d_2d(test1(37,:,:));conv3d_2d(test1(38,:,:));conv3d_2d(test1(39,:,:));conv3d_2d(test1(40,:,:))];
    



    
    
    