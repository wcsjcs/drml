landmarks_path='D:\wangce\dataset\DISFA_Plus_Dataset\DISFA_Plus_Dataset\FaceLandmarks';  
saveface_path='D:\wangce\dataset\predata';  
%遍历所有landmark文件并获取脸部图片  
alldirs=dir(landmarks_path);%当前目录所有子目录  
folder={};  
%the number of all the files in the current searching folder  
L=length(alldirs);  
%the number of folders to be searched on this class  
k=0;  
for i=1:1:L  
    if alldirs(i).isdir&&(~strcmp(alldirs(i).name,'.'))&&~strcmp(alldirs(i).name,'..')  
        k=k+1;  
        folder{k}=alldirs(i).name;%=[landmarks_path,filesep,allfiles(i).name];%将所有一级子目录的目录名保存下来  
    end  
end  
L=length(folder);  
for i=1:L      
    allfiles=dir([landmarks_path,filesep,folder{i},filesep,'*.','mat']);%[direc,filesep,'*.',ext]  
    cnt=length(allfiles);  
    for j=1:cnt  
        landmarks=load([landmarks_path,filesep,folder{i},filesep,allfiles(j).name]);  
        imgnum=length(landmarks.FaceImg_CropResize);  
        for k=1:imgnum  
           facefilename=[folder{i},'_',allfiles(j).name(1:(length(allfiles(j).name)-16)),'_', landmarks.FaceImg_CropResize{k}.imgID];  
           imwrite(landmarks.FaceImg_CropResize{k}.ImgCropped, [saveface_path, filesep, facefilename]);  
        end  
    end  
end 