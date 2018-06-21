ipath = 'D:\wangce\dataset\predata';
opath = 'D:\wangce';
f=fopen('D:\wangce\dataset\bp4d_test_shuffled_sh.txt','w');
temp = 'D:\wangce\dataset\bp4d_test_shuffled.txt';
addr_file=importdata(temp); 
L = length(addr_file.textdata);
disp(L);
for i=1:1:L
    %disp(addr_file.textdata(i));
    fprintf(f,'/');
    s = char(addr_file.textdata(i,1));
    fprintf(f,'%s ',s );  
    fprintf(f,'\n');
    
end
fclose(f);  
    