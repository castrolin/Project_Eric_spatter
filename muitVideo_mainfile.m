% muit-video mainfile
clc,clear
close all
%% post-proces : read file and parameter setting
path = 'E:\NCKU_experimental\Project_Eric_spatter\Video_test\*.avi';
fds = fileDatastore(path,'ReadFcn',@myread,'FileExtensions','.avi');

fps=750;
pixel=42.339783;

%% algorithm part
for i = 1:size(fds.Files,1)
    object.obj{i} =struct('obj',{},'tracks',{});
end
for i = 1:size(fds.Files,1)
    object.obj{i}=setupSystemObject(fds.Files{i});
    tracks=initializeTracks();
    nextId = 1;
    n = 1;
    while ~isDone(object.obj{i}.reader)
        frame = object.obj{i}.reader.step();
        
        frame=adaptivethreshold(frame,2,0.045,1); % bw=adaptivethreshold(IMagine,windowsize,C)
        frame=bwareafilt(frame,[5 70]);
        frame=single(frame);     %data status
        
        [centroids, bboxes]=detectObjects(frame,object.obj{i});
        tracks=predictNewLocationsOfTracks(tracks);
        [assignments, unassignedTracks, unassignedDetections]=detectionToTrackAssignment(tracks,centroids);
        [tracks]=updateAssignedTracks(assignments,centroids,bboxes,tracks,fps,pixel);
        tracks=updateUnassignedTracks(tracks,unassignedTracks);
        
        [centroids,bboxes,nextId,tracks]=createNewTracks(centroids,unassignedDetections,bboxes,nextId,tracks);
        [frame,bboxes]=displayTrackingResults(frame,bboxes,object.obj{i},tracks);
        object.obj{i}.tracks = tracks;
    end
end

























