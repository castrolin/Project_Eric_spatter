function [centroids, bboxes] = detectObjects(frame,obj)
% �i��}�B��A�Y���G�k�A���ȡA�ΨӮ����p����B�b�ֲ��I�B��������B���Ƹ��j���骺��ɪ��P�ɨä�������ܨ䭱�n�C
% mask = imopen(mask, strel('rectangle', [3,3]));
% % �i�泬�B��A�Y�����ȦA�G�k�A�ΨӶ�R���餺�Ӥp�Ŭ}�B�s���F����B���ƨ���ɪ��P�ɨä�������ܨ䭱�n�C
% mask = imclose(mask, strel('rectangle', [3, 3])); 
% % 
% mask = imfill(mask, 'holes');
        
% ����blob ���R�w���s�q�����餧����޷boundary box
% centroids:�� m by 2 ���x�}�Am����줧����Ӽ�,�B�Ĥ@�欰X�y�СA�ĤG�欰Y�y��
% bbox:     �� m by 4 ���x�}�Am����줧����ӼƥB�A�Ĥ@�欰boundary box X�y�СA�ĤG�欰boundary box Y�y��
%           �ĤT�欰width�A�ĥ|��height
[~, centroids, bboxes] = step(obj.blobAnalyser,logical(frame));% use the step function to run the System object(?) algorithm.