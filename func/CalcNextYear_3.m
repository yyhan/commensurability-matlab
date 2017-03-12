function [max_year, max_count, countArray] = CalcNextYear_3( inputYears, subYear, debugable )

%   CalcNextYear_3 ��Ԫ�ɹ����㷨
%
%   ������
%       inputYears ����������һά���飬��С��������
%       subYear ָ��Ԥ��������С��ݣ�������
%       debugable �Ƿ���debugģʽ��1��������debugģʽ�£����Դ�ӡ�������
%
%   ����ֵ��
%       max_year ���Ԥ����ݣ�����ж���������ؽ�С���Ǹ�
%       max_count ���Ԥ����ݱ�Ԥ�⵽�Ĵ���
%       countArray ����Ԥ�⵽������Լ���Ԥ�⵽�Ĵ�����a[i,1]����ݣ�a[i,2]�Ǳ�Ԥ�⵽�Ĵ���

if debugable == 1
    disp('==== CalcNextYear_3 ��ʼ ====');
    disp('��������:');
    disp(inputYears);
    disp('�������:');
end

% ������������
year_num=length(inputYears);

% Ԥ����һ��10000���ȵļ�������
count=linspace(0, 0, 10000);

% Ԥ�⵽�Ľ��ȥ�غ�ĸ���
countArrayCounter=0;

for a=1:year_num
    for b=a:year_num
        for c=1:year_num
            if c ~=a && c ~= b
                if a + b - c == year_num + 1
                    temp = inputYears(a) + inputYears(b) - inputYears(c); % ��ʱ����
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


% ����Ԥ������ʱ���飬��ȡԤ����
if debugable == 1
    disp('������:');
end
max_year=0; % ���Ԥ����
max_count=0; % ���Ԥ������Ԥ�⵽�Ĵ���
countArray=zeros(countArrayCounter, 2);

countArrayCounter=1; %���������õ���ʼλ��
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
    fprintf('\nԤ������X%d = %d \n', year_num+1, max_year);
    disp('==== CalcNextYear_3 ���� ====');
end

% ��������
end

