clc,clear;
close all
%% spatter tracking
path='E:\video\melt pool 實拍\0708\150W_600mms_spatter.avi';% 欲讀取之檔案路徑
obj=setupSystemObject(path);
tracks=initializeTracks();
fps=7400;
pixel=25;

% 用來記錄不同大小之spatter的速度
% 第一行為size
% 第二行為size更新flag
% 第三行為speed
% 第四行為speed更新flag

nextId = 1; % 第一個物體編號設定為1
n=1;
mov(1:402) = ...
    struct('cdata', zeros(size(pixel,1), size(pixel,2), 3, 'uint8'),...
           'colormap', []);

% 對物體進行偵測並追蹤
while ~isDone(obj.reader)% 當檔案讀到底會回傳true，還沒讀到底會回傳false(還沒讀到底~isDone回傳True，while繼續執行)
    frame=obj.reader.step();%讀取frame
%     frame=imbinarize(frame,0.4);
%     frame=frame(:,:,1);    
    frame=adaptivethreshold(frame,9,0.03,1); % bw=adaptivethreshold(IMagine,windowsize,C)
    frame=bwareafilt(frame,[5 100]);
    frame=single(frame);     %data status

    [centroids, bboxes]=detectObjects(frame,obj);
    tracks=predictNewLocationsOfTracks(tracks);
    [assignments, unassignedTracks, unassignedDetections]=detectionToTrackAssignment(tracks,centroids);
    [tracks]=updateAssignedTracks(assignments,centroids,bboxes,tracks,fps,pixel);
    tracks=updateUnassignedTracks(tracks,unassignedTracks);
    %tracks=deleteLostTracks(tracks);%將無法偵測到的tracks刪除
    
    % 若當前偵測之物體不在track list中，則新增 track 編號
    [centroids,bboxes,nextId,tracks]=createNewTracks(centroids,unassignedDetections,bboxes,nextId,tracks);
    
    % 顯示追蹤結果
    [frame,bboxes]=displayTrackingResults(frame,bboxes,obj,tracks);
    
    mov(n).cdata = frame;
    n=n+1;
end



h1 = implay(mov);
%% size histogram
% 將追蹤完畢之spatter的size分布用histogram 畫出
numOfSpatter=size(tracks,2);
sizeDistrubution =zeros(numOfSpatter,1);
for i=1:numOfSpatter
    sizeDistrubution(i)=pixel*(tracks(i).bbox(3)+tracks(i).bbox(4))/2;
end
% histogram(sizeDistrubution,20);
% title('spatter size histogram')
% xlabel('diameter of spatter(um)')
% ylabel('spatter number')
%N=histogram(sizeDistrubution,[0 25 50 75 100 125 150])
%% speed calculation
% for i=1:size(tracks,2)
%     speed(i)=tracks(i).speed;
%     dia(i)=15.0*(double(tracks(i).bbox(3))+double(tracks(i).bbox(4)))/2.0;
% end
% sizeVsSpeed=[dia;speed];
% t=tabulate(dia);%紀錄spatter大小與數量
% id=find(t(:,2)==0);
% t(id,:)=[];
% % plot(dia,speed,'o')
% for i=1:size(t,1)
%     s(i)=mean(speed(find(dia==t(i,1))));
% end
% smean=[t(:,1) s'];