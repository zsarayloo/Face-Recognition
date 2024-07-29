function [train test]=G_train_test_multiclass(C1,C2,C3,C4,n)

[train1 test1]=g_train_test_r(C1,n);
[train2 test2]=g_train_test_r(C2,n);
[train3 test3]=g_train_test_r(C3,n);
[train4 test4]=g_train_test_r(C4,n);

train=[train1;train2;train3;train4];
test=[test1;test2;test3;test4];

train=random_data(train);
test=random_data(test);
