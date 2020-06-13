function [centroids, bboxes] = detectObjects(frame,obj)
% 進行開運算，即先腐蝕再膨脹，用來消除小物體、在纖細點處分離物體、平滑較大物體的邊界的同時並不明顯改變其面積。
% mask = imopen(mask, strel('rectangle', [3,3]));
% % 進行閉運算，即先膨脹再腐蝕，用來填充物體內細小空洞、連接鄰近物體、平滑其邊界的同時並不明顯改變其面積。
% mask = imclose(mask, strel('rectangle', [3, 3])); 
% % 
% mask = imfill(mask, 'holes');
        
% 執行blob 分析已找到連通之物體之型心瑀boundary box
% centroids:為 m by 2 之矩陣，m為找到之物體個數,且第一行為X座標，第二行為Y座標
% bbox:     為 m by 4 之矩陣，m為找到之物體個數且，第一行為boundary box X座標，第二行為boundary box Y座標
%           第三行為width，第四行height
[~, centroids, bboxes] = step(obj.blobAnalyser,logical(frame));% use the step function to run the System object(?) algorithm.