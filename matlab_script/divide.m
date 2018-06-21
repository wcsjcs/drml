temp = 'D:\wangce\dataset\label.txt';
log=importdata(temp);
ftrain=fopen('label_train_7.txt','w'); 
ftest=fopen('label_test_2.txt','w');
for i=1:1:164220:
    %if allfiles(i).isdir&&(~strcmp(allfiles(i).name,'.'))&&~strcmp(allfiles(i).name,'..')  
        disp(allfiles(i).name);
        fprintf(fbookmark,'/home/wangce/data/predata/');
        fprintf(fbookmark,'/%s\n', allfiles(i).name);  
        %fprintf(fbookmark,'\n');
    %end
end
fclose(fbookmark);  