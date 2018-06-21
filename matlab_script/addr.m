ipath = 'D:\wangce\dataset\predata';
opath = 'D:\wangce';
f=fopen('D:\wangce\dataset\bp4d_test_shuffled_addr_225.txt','w');
temp = 'D:\wangce\dataset\bp4d_test_shuffled.txt';
addr_file=importdata(temp); 
L = length(addr_file.textdata);
disp(L);
for i=1:1:L
    %disp(addr_file.textdata(i));
    fprintf(f,'/data/wangce/croped/');
    s = char(addr_file.textdata(i,1));
    fprintf(f,'%s ',s );  
    fprintf(f,'%d',addr_file.data(i,1) );
    fprintf(f,' %d',addr_file.data(i,2) );
    fprintf(f,' %d',addr_file.data(i,3) );
    fprintf(f,' %d',addr_file.data(i,4) );
    fprintf(f,' %d',addr_file.data(i,5) );
    fprintf(f,' %d',addr_file.data(i,6) );
    fprintf(f,' %d',addr_file.data(i,7) );
    fprintf(f,' %d',addr_file.data(i,8) );
    fprintf(f,' %d',addr_file.data(i,9) );
    fprintf(f,' %d',addr_file.data(i,10) );
    fprintf(f,' %d',addr_file.data(i,11) );
    fprintf(f,' %d',addr_file.data(i,12) );
    fprintf(f,'\n');
    
end
fclose(f);  
    