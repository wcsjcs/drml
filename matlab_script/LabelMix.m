function getlabel_disfa_plus(dire,ext)  
%����getlabel_disfa_plus('D:\Projects\DRML\database\Disfa\Disfa_plus\Labels','txt');  
%�õ���label.txt��ʽΪ�� SN��Ŀ¼_��Ŀ¼_ͼƬ��.jpg -1 1 ...  
%label.txt��ʽ����SN001_A1_AU1_TrailNo_1_028.jpg 1 -1 -1 -1 1 -1 -1 -1 -1 1 -1 -1  
%��ʾ��ͼƬ�ϳ����˵�1�͵�5�͵�10��AU���ֱ��ӦAU1,AU6��AU20  
%AU˳��AU1,AU12,AU15,AU17,AU2��AU20,AU25,AU26,AU4,AU5,AU6,AU9,  
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
dir_SN = 1;%=1��ʾSNĿ¼��=2��ʾ��С����Ŀ¼  
lai=[];
while flag  
    currfolders=folder;  
    folder={};  
      
    for m=1:1:length(currfolders)  
        direc=currfolders{m};  
        files=dir([direc,filesep,'*.',ext]);%��ǰĿ¼�µ�ext�ļ�  
          
        %the number of *.ext files in the current searching folder  
        L=length(files); 
        for i=1:1:L%������ѭ������ͬһ��ͼƬ���е�AU  
            temp=[direc,filesep,files(i).name];  
            %������ͳ��һ����Ƶ���еľ���AU���  
            label_file=importdata(temp); 
            %disp(label_file(1).data>=3);
            %disp(length(label_file(1).data));
            lai(m) = length(label_file(1).data);
            label(m,1:length(label_file(1).data), i)=label_file(1).data>=3;              
        end          
          
        allfiles=dir(direc);%��ǰĿ¼�����ļ�����Ŀ¼  
        %the number of all the files in the current searching folder  
        L=length(allfiles);  
        %the number of folders to be searched on this class  
        k=length(folder);  
        for i=1:1:L  
            if allfiles(i).isdir&&(~strcmp(allfiles(i).name,'.'))&&~strcmp(allfiles(i).name,'..')  
                k=k+1;  
                folder{k}=[direc,filesep,allfiles(i).name];%������һ����Ŀ¼��Ŀ¼����������  
                if dir_SN == 1  
                    SubDir{k} = allfiles(i).name;%��һ����Ŀ¼��SNϵ��  
                else  
                    SubSubDir{k} = [SubDir{m},'_',allfiles(i).name];%�ڶ�����Ŀ¼  
                end  
            end  
        end  
    end  
    dir_SN=dir_SN+1;  
    %if there are no folders that havenot searched yet,flag=0 so the loop  
    %will be ended ��û��Ŀ¼�ɱ���ʱ������ҽ���  
    if ~length(folder)  
        flag=0;  
    end  
end  
%����label��Ϣ  
disp(length(lai));
disp(length(label(:,1,1)));
for m=1:length(label(:,1,1))%label������������Ƶ���С�ͼƬ��AU  
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