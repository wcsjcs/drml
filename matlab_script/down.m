path = 'D:\DatasetEmotion\EmotioNetFACSfile\';
for i=17970:1:24666
    url = char(log.textdata(i,1));
    url = url(2:end-1);
    %disp(i);
    a = findstr(url,'/');
    file = url(a(end)+1:end);
    file = strcat(path,file);
    %disp(file);
    try
    % ����ִ�е����E
        outfilename = websave(file,url);
    catch
        disp('error :');
        disp(file);
    % ���E���д���
    % ִ��catch��end֮��Ĵ����
    end
end
