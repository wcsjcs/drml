temp = 'D:\wangce\dataset\label.txt';
log=importdata(temp);
iter = log.data(:,1);
loss = log.data(:,3);
plot(iter,loss);



