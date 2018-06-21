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
    % 尝试执行的语句E
        outfilename = websave(file,url);
    catch
        disp('error :');
        disp(file);
    % 如果E运行错误，
    % 执行catch和end之间的代码块
    end
end
