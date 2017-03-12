function [max_year, max_count, countArray] = CalcNextYear_3( inputYears, subYear, debugable )

%   CalcNextYear_3 三元可公度算法
%
%   参数：
%       inputYears 是输入的年份一维数组，从小到大排列
%       subYear 指定预测结果的最小年份（不含）
%       debugable 是否开启debug模式，1：开启。debug模式下，可以打印运算过程
%
%   返回值：
%       max_year 最佳预测年份，如果有多个，将返回较小的那个
%       max_count 最佳预测年份被预测到的次数
%       countArray 所有预测到的年份以及被预测到的次数，a[i,1]是年份，a[i,2]是被预测到的次数

if debugable == 1
    disp('==== CalcNextYear_3 开始 ====');
    disp('输入样本:');
    disp(inputYears);
    disp('计算过程:');
end

% 输入样本数量
year_num=length(inputYears);

% 预分配一个10000长度的计数数组
count=linspace(0, 0, 10000);

% 预测到的结果去重后的个数
countArrayCounter=0;

for a=1:year_num
    for b=a:year_num
        for c=1:year_num
            if c ~=a && c ~= b
                if a + b - c == year_num + 1
                    temp = inputYears(a) + inputYears(b) - inputYears(c); % 临时变量
                    if temp > inputYears(year_num)
                        if count(temp)==0
                            countArrayCounter=countArrayCounter+1;
                        end
                        count(temp) = count(temp) + 1;
                        if debugable == 1
                            fprintf('*X%d + X%d - X%d = X%d = X%d \n', a, b, c, year_num + 1, temp);
                        end
                    end
                end
            end
        end
    end
end


% 遍历预测结果临时数组，提取预测结果
if debugable == 1
    disp('计算结果:');
end
max_year=0; % 最佳预测结果
max_count=0; % 最佳预测结果被预测到的次数
countArray=zeros(countArrayCounter, 2);

countArrayCounter=1; %将计数器置到起始位置
for d=1:1:10000
    if count(d) > 0
        countArray(countArrayCounter,1)=d;
        countArray(countArrayCounter,2)=count(d);
        countArrayCounter=countArrayCounter+1;
        if debugable == 1
        	fprintf('%d year %d time \n', d, count(d));
        end
    end
    if d > subYear && max_count < count(d)
        max_count= count(d);
        max_year= d;
    end
end

if debugable == 1
    fprintf('\n预测结果：X%d = %d \n', year_num+1, max_year);
    disp('==== CalcNextYear_3 结束 ====');
end

% 函数结束
end

