function [ max_year, max_count, countArray ] = CalcNextYear_5_1( inputYears )

%   CalcNextYear_5_1 五元可公度算法（一）
%
%   参数：
%       inputYears 是输入的年份一维数组，从小到大排列
%
%   返回值：
%       max_year 最佳预测年份，如果有多个，将返回较小的那个
%       max_count 最佳预测年份被预测到的次数
%       countArray 所有预测到的年份以及被预测到的次数，a[i,1]是年份，a[i,2]是被预测到的次数

disp('==== start ====');

% 输入样本数量
year_num=length(inputYears);

% 预分配一个10000长度的计数数组
count=linspace(0, 0, 10000);

% 预测到的结果去重后的个数
countArrayCounter=0;

disp('==== 计算过程 ====');
for a=1:year_num
    for b=a:year_num
        for c=1:year_num
            if c ~=a && c ~= b
                for d=c:year_num
                    if d ~=a && d ~= b
                        if (a + b - c - d) == 0  || a + b - c - d == -1 || a + b - c - d == 1
                            temp = inputYears(a) + inputYears(b) - inputYears(c) - inputYears(d); % 临时变量
                            
                            if temp > 0
                                temp = temp + inputYears(year_num);
                                if count(temp)==0
                                    countArrayCounter=countArrayCounter+1;
                                end
                                count(temp) = count(temp) + 1;
                                fprintf('*X%d + X%d + X%d - X%d - X%d = X%d = X%d \n', year_num, a, b, c, d, year_num + 1, temp);
                            end
                        end 
                    end

                end
            end
            
        end
    end
end
disp('==== 计算结果 ====');

% 遍历预测结果临时数组，提取预测结果

max_year=0; % 最佳预测结果
max_count=0; % 最佳预测结果被预测到的次数
countArray=zeros(countArrayCounter, 2);

countArrayCounter=1; %将计数器置到起始位置
for d=1:1:10000
    if count(d) > 0
        countArray(countArrayCounter,1)=d;
        countArray(countArrayCounter,2)=count(d);
        countArrayCounter=countArrayCounter+1;
        
        fprintf('%d year %d time \n', d, count(d));
    end
    if max_count < count(d)
        max_count= count(d);
        max_year= d;
    end
end
fprintf('\n预测结果：X%d = %d \n', year_num+1, max_year);
disp('==== over ====');
end

