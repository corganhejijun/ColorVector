function colorDis = ColorDistance(color1, color2)
% ����������ɫ�ľ���, ����ֵΪ0~255
%% 
% norm����ŷ�Ͼ���
% baseΪ�������ϵ��
% ʹ��ָ�������ĵ�һ���޲��֣���֤��������0~255֮�䣬�ұ���һ�����½��ٶ�
% ִ���������鿴���߱仯��Χ
%   a = 0 : norm([255, 255, 255]);
%   b = (1/1.002).^a;
%   plot(a, 255 * b)
    base = 1/1.022;
    colorDis = (base^norm(color1 - color2))*255;
end