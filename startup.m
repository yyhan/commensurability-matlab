
% �������� startup
% ���������ļ���data\input.csv
% ��������ļ���data\output.csv

currentDir = pwd;
funcDir = strcat(currentDir, '\func');
inputFile = strcat(currentDir, '\data\input.csv');
outputFile = strcat(currentDir, '\data\output.csv');

if exist(funcDir', 'dir') ~= 7
    error('��ȷ������Ŀ¼��func���ڵ�ǰĿ¼��');
end
if exist(inputFile, 'file') ~= 2
    error('��ȷ����data��Ŀ¼�°������������ļ���input.csv��');
end
addpath(funcDir);

data = csvread(inputFile);


rowAndCols = size(data);

rowLength = rowAndCols(1);
colLength = rowAndCols(2);

yearIndex=data(1,:);
maxYear=yearIndex(colLength);
%maxYear=0;

res=zeros(rowLength-1, 2);

for r=2:rowLength
    fprintf('\n<<<< X%d��ʼ���� >>>>\n', r-1);
    row = data(r,:);
    preRow=linspace(0, 0, colLength);
    prePointer = 1;
    for c=1:colLength
        cell = row(c);
        if cell >= 2
            preRow(prePointer)=yearIndex(c);
            prePointer=prePointer+1;
        end
    end
    if prePointer > 1
       tagRow =  preRow(1:prePointer-1);
       t = CalcNextYear_3(tagRow, maxYear, 1);
       res(r-1, 1)=r-1;
       res(r-1, 2)=t;
    else
        res(r-1, 1)=r-1;
        res(r-1, 2)=-1;
    end
    fprintf('\n<<<< X%d������� >>>>\n', r-1);
end
disp('\n���е�Ԫ���������������£�\n');
disp(res);
csvwrite(outputFile, res);
