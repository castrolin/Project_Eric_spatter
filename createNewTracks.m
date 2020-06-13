% �Y�ثe�S���o�{��track�A�h�����䬰�s��track
function [centroids,bboxes,nextId,tracks]=createNewTracks(centroids,unassignedDetections,bboxes,nextId,tracks)
centroids = centroids(unassignedDetections, :);
bboxes = bboxes(unassignedDetections, :);

for i = 1:size(centroids, 1)
    
    centroid = centroids(i,:);
    bbox = bboxes(i, :);
    
    % Create a Kalman filter object.
%     kalmanFilter = configureKalmanFilter('ConstantVelocity', ...
%         centroid, [200, 50], [100, 25], 100);
    kalmanFilter = configureKalmanFilter('ConstantVelocity', ...
        centroid, [30, 30], [30, 30], 15);
    
    % Create a new track.
    newTrack = struct(...
        'id', nextId, ...
        'bbox', bbox, ...
        'kalmanFilter', kalmanFilter, ...
        'age', 1, ...
        'totalVisibleCount', 1, ...
        'consecutiveInvisibleCount', 0, ...
        'speed', 0);
    
    % �N�s��track�W�[���e��track list��
    tracks(end + 1) = newTrack;
    
    % �N��etrack��index��s
    nextId = nextId + 1;
end

