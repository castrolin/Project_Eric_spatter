function [frame,bboxes]=displayTrackingResults(frame,bboxes,obj,tracks)
% �N��e�v��(frame)�P�[�Wbbox���v��(mask)�ରRGB�v��
% �Y��l�v����2���v���h�����O���ݭn
frame = im2uint8(frame);
% �Nmask�ƻs3���|��RGB�v��
minVisibleCount = 2;
if ~isempty(tracks)
    
    % Noisy detections tend to result in short-lived tracks.
    % Only display tracks that have been visible for more than
    % a minimum number of frames.
    reliableTrackInds = ...
        [tracks(:).totalVisibleCount] > minVisibleCount;
    reliableTracks = tracks(reliableTrackInds);
    
    % Display the objects. If an object has not been detected
    % in this frame, display its predicted bounding box.
    if ~isempty(reliableTracks)
        % Get bounding boxes.
        bboxes = cat(1, reliableTracks.bbox);
        
        % Get ids.
        ids = int32([reliableTracks(:).id]);
        
        % Create labels for objects indicating the ones for
        % which we display t,objhe predicted rather than the actual
        % location.
        labels = cellstr(int2str(ids'));
        predictedTrackInds = ...
            [reliableTracks(:).consecutiveInvisibleCount] >2;
        isPredicted = cell(size(labels));
        isPredicted(predictedTrackInds) = {' predicted'};
        labels = strcat(labels, isPredicted);
        
        % Draw the objects on the frame.
        frame = insertObjectAnnotation(frame, 'rectangle', ...
            bboxes, labels,'FontSize',8);
        if size(frame,3)~=3
            frame = uint8(repmat(frame, [1, 1, 3]));
        end


    end
end
    % ����v��  
    if size(frame,3)~=3
       frame = uint8(repmat(frame, [1, 1, 3]));
    end
       obj.videoPlayer.step(frame)
