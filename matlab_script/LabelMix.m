function getlabel_disfa_plus(dire,ext)  
%例如getlabel_disfa_plus('D:\Projects\DRML\database\Disfa\Disfa_plus\Labels','txt');  
%得到的label.txt格式为： SN子目录_子目录_图片名.jpg -1 1 ...  
%label.txt格式例：SN001_A1_AU1_TrailNo_1_028.jpg 1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1  
%表示该图片上出现了第1和第5和第10个AU，分别对应AU1,AU6，AU20  
%AU顺序：AU1,AU12,AU15,AU17,AU2，AU20,AU25,AU26,AU4,AU5,AU6,AU9,  
%  
%check if the input and output is valid  
if ~isdir(dire)  
    msgbox('The input isnot a valid directory','Warning','warn');  
    return  
else  
if nargin==1  
        ext='*';  
elseif nargin>2||nargin<1  
    msgbox('1 or 2 inputs are required','Warning','warn');  
    return  
end  
if nargout>1  
    msgbox('Too many output arguments','Warning','warn');  
    return  
end  
  
%containing the searching results  
SubDir={};SubSubDir={};  
%create a txt file to save all the directory  
flabel=fopen('labelnew.txt','w');  
%containing all the directories on the same class  
folder{1}=dire;  
flag=1; %1 when there are folders havenot be searched,0 otherwise  
dir_SN = 1;%=1表示SN目录，=2表示更小的子目录  
lai=[];
while flag  
    currfolders=folder;  
    folder={};  
      
    for m=1:1:length(currfolders)  
        direc=currfolders{m};  
        files=dir([direc,filesep,'*.',ext]);%当前目录下的ext文件  
          
        %the number of *.ext files in the current searching folder  
        L=length(files); 
        for i=1:1:L%进来该循环的是同一个图片序列的AU  
            temp=[direc,filesep,files(i).name];  
            %在这里统计一个视频序列的具体AU情况  
            label_file=importdata(temp); 
            %disp(label_file(1).data>=3);
            %disp(length(label_file(1).data));
            lai(m) = length(label_file(1).data);
            label(m,1:length(label_file(1).data), i)=label_file(1).data>=3;              
        end          
          
        allfiles=dir(direc);%当前目录所有文件及子目录  
        %the number of all the files in the current searching folder  
        L=length(allfiles);  
        %the number of folders to be searched on this class  
        k=length(folder);  
        for i=1:1:L  
            if allfiles(i).isdir&&(~strcmp(allfiles(i).name,'.'))&&~strcmp(allfiles(i).name,'..')  
                k=k+1;  
                folder{k}=[direc,filesep,allfiles(i).name];%将所有一级子目录的目录名保存下来  
                if dir_SN == 1  
                    SubDir{k} = allfiles(i).name;%第一层子目录，SN系列  
                else  
                    SubSubDir{k} = [SubDir{m},'_',allfiles(i).name];%第二层子目录  
                end  
            end  
        end  
    end  
    dir_SN=dir_SN+1;  
    %if there are no folders that havenot searched yet,flag=0 so the loop  
    %will be ended 当没有目录可遍历时，则查找结束  
    if ~length(folder)  
        flag=0;  
    end  
end  
%保存label信息  
disp(length(lai));
disp(length(label(:,1,1)));
for m=1:length(label(:,1,1))%label三级索引：视频序列、图片、AU  
    %for n=1:length(label(1,:,1))  
    for n=1:lai(m)
        fprintf(flabel,'%s',SubSubDir{m});          
        fprintf(flabel,'_%03i.jpg',n-1);
        %disp(lai(m));
        for k=1:length(label(1,1,:))  
            if label(m,n,k) ==0  
                fprintf(flabel,' %d', -1);  
            else  
                fprintf(flabel,' %d', 1);  
            end  
        end  
        fprintf(flabel,'\n');  
    end  
end  
fclose(flabel);  
if nargout==1  
    ;  
end  
clear D fout folder flag currfolders m files L num temp allfiles k i direc  
  
end  