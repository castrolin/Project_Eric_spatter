% the spatterSizeDistribution analysis
% using the motion of muti-object to calculate
% Date : 06/03
% Creator : CastroLin
clc,clear;
close all
%% spatter tracking
path='E:\NCKU_experimental\Project_Eric_spatter\Video_test\1.avi';;% ��Ū�����ɮ׸��|
obj=setupSystemObject(path);
tracks=initializeTracks();
fps=550;
pixel=42.3397836;

% �ΨӰO�����P�j�p��spatter���t��
% �Ĥ@�欰size
% �ĤG�欰size��sflag
% �ĤT�欰speed
% �ĥ|�欰speed��sflag

nextId = 1; % �Ĥ@�Ӫ���s���]�w��1
n=1;

% �磌��i�氻���ðl��
while ~isDone(obj.reader)% ���ɮ�Ū�쩳�|�^��true�A�٨SŪ�쩳�|�^��false(�٨SŪ�쩳~isDone�^��True�Awhile�~�����)
    frame=obj.reader.step();%Ū��frame
%     frame=imbinarize(frame,0.4);
%    frame=frame(:,:,1);   

    frame=adaptivethreshold(frame,2,0.045,1); % bw=adaptivethreshold(IMagine,windowsize,C)
    frame=bwareafilt(frame,[5 50]);
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
    n=n+1;
%     if n>10
%         break;
%     end
end



%% size histogram
% �N�l�ܧ�����spatter��size������histogram �e�X
numOfSpatter=size(tracks,2);
sizeDistrubution =zeros(numOfSpatter,1);
for i=1:numOfSpatter
    sizeDistrubution(i)=pixel*sqrt(double((tracks(i).bbox(3)+tracks(i).bbox(4))))/2; % size is diameter
end
histogram(sizeDistrubution,20);
title('spatter size histogram')
xlabel('diameter of spatter(um)')
ylabel('spatter number')
pd = fitdist(sizeDistrubution,'Normal');
h = histfit(sizeDistrubution);
figure,
yyaxis left
histogram(sizeDistrubution)
ylabel('Number of spatter','FontSize',20)

set(gca,'FontSize',20)
yyaxis right
plot(h(2).XData,h(2).YData/max(h(2).YData),'lineWidth',5)
set(gca,'FontSize',20)
ylabel('Probility density','FontSize',20)
ylim([0,1.2])
% histogram with normaldistribution at the same graph.
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