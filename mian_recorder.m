clc,clear;
close all
%% spatter tracking
path='E:\video\melt pool ���\0708\150W_600mms_spatter.avi';% ��Ū�����ɮ׸��|
obj=setupSystemObject(path);
tracks=initializeTracks();
fps=7400;
pixel=25;

% �ΨӰO�����P�j�p��spatter���t��
% �Ĥ@�欰size
% �ĤG�欰size��sflag
% �ĤT�欰speed
% �ĥ|�欰speed��sflag

nextId = 1; % �Ĥ@�Ӫ���s���]�w��1
n=1;
mov(1:402) = ...
    struct('cdata', zeros(size(pixel,1), size(pixel,2), 3, 'uint8'),...
           'colormap', []);

% �磌��i�氻���ðl��
while ~isDone(obj.reader)% ���ɮ�Ū�쩳�|�^��true�A�٨SŪ�쩳�|�^��false(�٨SŪ�쩳~isDone�^��True�Awhile�~�����)
    frame=obj.reader.step();%Ū��frame
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
    %tracks=deleteLostTracks(tracks);%�N�L�k�����쪺tracks�R��
    
    % �Y��e���������餣�btrack list���A�h�s�W track �s��
    [centroids,bboxes,nextId,tracks]=createNewTracks(centroids,unassignedDetections,bboxes,nextId,tracks);
    
    % ��ܰl�ܵ��G
    [frame,bboxes]=displayTrackingResults(frame,bboxes,obj,tracks);
    
    mov(n).cdata = frame;
    n=n+1;
end



h1 = implay(mov);
%% size histogram
% �N�l�ܧ�����spatter��size������histogram �e�X
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
% t=tabulate(dia);%����spatter�j�p�P�ƶq
% id=find(t(:,2)==0);
% t(id,:)=[];
% % plot(dia,speed,'o')
% for i=1:size(t,1)
%     s(i)=mean(speed(find(dia==t(i,1))));
% end
% smean=[t(:,1) s'];