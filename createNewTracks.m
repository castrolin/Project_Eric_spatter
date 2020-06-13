% 若目前沒有發現該track，則指派其為新的track
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
    
    % 將新的track增加到當前的track list中
    tracks(end + 1) = newTrack;
    
    % 將當前track的index更新
    nextId = nextId + 1;
end

