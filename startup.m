
% 运行命令 startup
% 输入数据文件：data\input.csv
% 输出数据文件：data\output.csv

currentDir = pwd;
funcDir = strcat(currentDir, '\func');
inputFile = strcat(currentDir, '\data\input.csv');
outputFile = strcat(currentDir, '\data\output.csv');

if exist(funcDir', 'dir') ~= 7
    error('请确保函数目录“func”在当前目录下');
end
if exist(inputFile, 'file') ~= 2
    error('请确保“data”目录下包含输入数据文件“input.csv”');
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
    fprintf('\n<<<< X%d开始计算 >>>>\n', r-1);
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
    fprintf('\n<<<< X%d计算结束 >>>>\n', r-1);
end
disp('\n所有单元计算结束，结果如下：\n');
disp(res);
csvwrite(outputFile, res);
