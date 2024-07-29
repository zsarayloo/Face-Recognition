
function [traind testd]=random_test_train(I)
percent=0.5;
[traind testd]=Generate_data(I,percent);
[a b]=size(traind);

%% initialize process
traind=random_data(traind);
testd=random_data(testd);
