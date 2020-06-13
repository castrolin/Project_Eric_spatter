function tracks=deleteLostTracks(tracks)
% �p�G��e�S������tracks�A�h�����������
if isempty(tracks)
    return;
end

% �Y�@��track �Ӫ��ɶ��S�Q������A�h�R����tracks
invisibleForTooLong = 20;
ageThreshold = 8;

% Compute the fraction of the track's age for which it was visible.
ages = [tracks(:).age];
totalVisibleCounts = [tracks(:).totalVisibleCount];
visibility = totalVisibleCounts ./ ages;

% Find the indices of 'lost' tracks.
% lostInds��0�P1���G���x�}
lostInds = (ages < ageThreshold & visibility < 0.4) | ...
    [tracks(:).consecutiveInvisibleCount] >= invisibleForTooLong;

% �R��tracks
tracks = tracks(~lostInds);