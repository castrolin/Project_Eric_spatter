% tracks 為前一個frame 偵測到之物體，centroids為當前frame偵測之物體型心
function [assignments, unassignedTracks, unassignedDetections]=detectionToTrackAssignment(tracks,centroids)
numOfTracks=length(tracks);
numOfDetections=size(centroids, 1);
% Compute the cost of assigning each detection to each track.
cost = zeros(numOfTracks, numOfDetections);

% d = distance(kalmanFilter,z_matrix) computes a distance between the location of a detected object and the predicted location by the Kalman filter object. 
% This distance computation takes into account the covariance of the predicted state and the process noise. 
% The distance function can only be called after the predict function.
% Use the distance function to find the best matches.
% The computed distance values describe how a set of measurements matches the Kalman filter.
% You can thus select a measurement that best fits the filter. 
% This strategy can be used for matching object detections against object tracks in a multiobject tracking problem.
% This distance computation takes into account the covariance of the predicted state and the process noise.
for i = 1:numOfTracks
    cost(i, :) = distance(tracks(i).kalmanFilter, centroids);
end
        
% Solve the assignment problem.
costOfNonAssignment = 10;
[assignments, unassignedTracks, unassignedDetections]=assignDetectionsToTracks(cost, costOfNonAssignment);
