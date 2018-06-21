path = 'D:\DatasetEmotion\EmotioNetCompoundEmotionsURLfile\';

for i=3:1:2479
    url = char(logforcat.textdata(i,1));
    %url = url(2:end-1);
    disp(url);
    a = findstr(url,'/');
    file = url(a(end)+1:end);
    file = strcat(path,file);
    %disp(file);
    weboptions('Timeout',60);
    websave(file,url);

end