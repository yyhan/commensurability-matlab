function [ max_year, max_count, countArray ] = CalcNextYear_5_1( inputYears )

%   CalcNextYear_5_1 ��Ԫ�ɹ����㷨��һ��
%
%   ������
%       inputYears ����������һά���飬��С��������
%
%   ����ֵ��
%       max_year ���Ԥ����ݣ�����ж���������ؽ�С���Ǹ�
%       max_count ���Ԥ����ݱ�Ԥ�⵽�Ĵ���
%       countArray ����Ԥ�⵽������Լ���Ԥ�⵽�Ĵ�����a[i,1]����ݣ�a[i,2]�Ǳ�Ԥ�⵽�Ĵ���

disp('==== start ====');

% ������������
year_num=length(inputYears);

% Ԥ����һ��10000���ȵļ�������
count=linspace(0, 0, 10000);

% Ԥ�⵽�Ľ��ȥ�غ�ĸ���
countArrayCounter=0;

disp('==== ������� ====');
for a=1:year_num
    for b=a:year_num
        for c=1:year_num
            if c ~=a && c ~= b
                for d=c:year_num
                    if d ~=a && d ~= b
                        if (a + b - c - d) == 0  || a + b - c - d == -1 || a + b - c - d == 1
                            temp = inputYears(a) + inputYears(b) - inputYears(c) - inputYears(d); % ��ʱ����
                            
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
disp('==== ������ ====');

% ����Ԥ������ʱ���飬��ȡԤ����

max_year=0; % ���Ԥ����
max_count=0; % ���Ԥ������Ԥ�⵽�Ĵ���
countArray=zeros(countArrayCounter, 2);

countArrayCounter=1; %���������õ���ʼλ��
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
fprintf('\nԤ������X%d = %d \n', year_num+1, max_year);
disp('==== over ====');
end

