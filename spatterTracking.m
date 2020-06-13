  reader = vision.VideoFileReader('D:\personal data\backup\2019.4.22\Works\SLM melt pool\peaks.avi', ...
    'VideoOutputDataType', 'uint8','ImageColorSpace','Intensity');

  detector = vision.ForegroundDetector();

  blobAnalyzer = vision.BlobAnalysis(...
      'CentroidOutputPort', false, 'AreaOutputPort', false, ...
      'BoundingBoxOutputPort', true, 'MinimumBlobArea', 5);

  player = vision.DeployableVideoPlayer();
  labelI=uint8(zeros(256,512,1000));
  i=1;
  while ~isDone(reader)
    frame  = step(reader);
    fgMask = step(detector, frame);
    bbox   = step(blobAnalyzer, fgMask);

    % draw bounding boxes around cars
    out = insertShape(frame, 'Rectangle', bbox, 'Color', 'Yellow');
    labelI(:,:,i)=out(:,:,1);
    i=i+1;
    step(player, out); % view results in the video player
  end

  release(player);
  release(reader);