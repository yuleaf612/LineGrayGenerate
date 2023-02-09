clc;clear;
H = 720;
W = 1280;
code = m_gray_code(8);
delta = ceil(W/256);
GrayImg = zeros(H,W,8);
for j=1:8
    num = num2str(j,'%d');
    filename=['generate\GRAY_',num,'.bmp'];
    filename2=['generate\GRAY_inv_',num,'.bmp'];
    for i=1:delta:W
        k = ceil(i/delta);
        a = code(k);
        b = char(a);
        c = str2double(b(9-j));
        GrayImg(:,i:i+delta-1,j)=255*c;
    end
    imwrite(uint8(GrayImg(:,:,j)),filename);
    imwrite(uint8(255-GrayImg(:,:,j)),filename2);
end

LineMoveImg = zeros(H,W,10);
for i=1:10
    num = num2str(i,'%d');
    filename=['generate\LINE_',num,'.bmp'];
    for j=1:10:W
        LineMoveImg(:,j+(i-1),i)=255;
        
        k = j+1+(i-1);
        if k > 1280
            k = k-1280;
        end
        LineMoveImg(:,k,i)=255;
        
%         k = j+2+(i-1);
%         if k > 1280
%             k = k-1280;
%         end
%         LineMoveImg(:,k,i)=255;
    end
    imwrite(uint8(LineMoveImg(:,:,i)),filename);
end


%code字符串中存放n位格雷码的表示
function [code] = m_gray_code(n) %n是格雷码的位数
    if (n < 1)
        disp("格雷码数量必须大于0");
        return;
    elseif (n == 1)
        % 产生0、1 两个数字
        code = ["0", "1"];
        % 返回code
    else
        code_pre = m_gray_code(n - 1);
        [~, num] = size(code_pre);
        % 初始化一个数组
        code = repmat("", 1, num * 2);
        % step1：每个字符串前面都+0
        idx = 0;
        for i = 1: num
            idx = idx + 1;
            code(idx) = "0" + code_pre(i);
        end
        % step2：翻转首个元素，其余取对称
        for i = num: -1: 1
            idx = idx + 1;
            code(idx) = "1" + code_pre(i);
        end
    end
end
