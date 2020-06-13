function tracks=deleteLostTracks(tracks)
% 如果當前沒有任何tracks，則直接結束函數
if isempty(tracks)
    return;
end

% 若一個track 太長時間沒被偵測到，則刪除該tracks
invisibleForTooLong = 20;
ageThreshold = 8;

% Compute the fraction of the track's age for which it was visible.
ages = [tracks(:).age];
totalVisibleCounts = [tracks(:).totalVisibleCount];
visibility = totalVisibleCounts ./ ages;

% Find the indices of 'lost' tracks.
% lostInds為0與1之二元矩陣
lostInds = (ages < ageThreshold & visibility < 0.4) | ...
    [tracks(:).consecutiveInvisibleCount] >= invisibleForTooLong;

% 刪除tracks
tracks = tracks(~lostInds);