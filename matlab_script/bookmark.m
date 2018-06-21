ipath = 'D:\wangce\dataset\predata';
opath = 'D:\wangce';
allfiles = dir(ipath);
L = length(allfiles);
disp(L);
fbookmark=fopen('bookmark.txt','w'); 
for i=3:1:L
    %if allfiles(i).isdir&&(~strcmp(allfiles(i).name,'.'))&&~strcmp(allfiles(i).name,'..')  
        disp(allfiles(i).name);
        fprintf(fbookmark,'/home/wangce/data/predata/');
        fprintf(fbookmark,'/%s\n', allfiles(i).name);  
        %fprintf(fbookmark,'\n');
    %end
end
fclose(fbookmark);  
    