function [tracks]=updateAssignedTracks(assignments,centroids,bboxes,tracks,fps,pixel)
time=1/fps;
numAssignedTracks = size(assignments, 1);
% for i=1:size(assignments,1)
%     if sizeVsSpeed(assignments(i,1),2)~=1
%         sizeVsSpeed(assignments(:,1),1)=(bboxes(:,3)+bboxes(:,4))/2;
%     end
%     sizeVsSpeed(assignments(i,1),2)=1; %spatter size ��sflag
% end

% sizeVsSpeed �ΨӰO�����P�j�p��spatter���t��
% �Ĥ@�欰size
% �ĤG�欰size��sflag
% �ĤT�欰speed
% �ĥ|�欰speed��sflag
% sizeVsSpeed
for i = 1:numAssignedTracks
    % ��sspeed�i�H��b�o�@��
    trackIdx = assignments(i, 1);
    detectionIdx = assignments(i, 2);
    centroid = centroids(detectionIdx, :);
    bbox = bboxes(detectionIdx, :);
    
    x_new=double(bbox(1))+double(bbox(3))/2; %bbox ����XY�y��
    y_new=double(bbox(2))+double(bbox(4))/2;
    x_old=double(tracks(trackIdx).bbox(1))+double(tracks(trackIdx).bbox(3))/2;
    y_old=double(tracks(trackIdx).bbox(2))+double(tracks(trackIdx).bbox(4))/2;
    d=sqrt((x_new-x_old)^2+(y_new-y_old)^2);
    speed=pixel*d*10^-6/time;
    tracks(trackIdx).speed=speed;
   
    % Correct the estimate of the object's location
    tracks(trackIdx).age = tracks(trackIdx).age + 1;
    % using the new detection.
    correct(tracks(trackIdx).kalmanFilter, centroid);
    
    % Replace predicted bounding box with detected
    % bounding box.
    displacement=tracks(trackIdx).bbox;
    tracks(trackIdx).bbox = bbox;
    
    
    % Update track's age.
    
    % Update visibility.
    tracks(trackIdx).totalVisibleCount = ...
        tracks(trackIdx).totalVisibleCount + 1;
    tracks(trackIdx).consecutiveInvisibleCount = 0;
end


