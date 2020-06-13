function obj=setupSystemObject(path)
        %建立檔案讀取物件
        obj.reader=vision.VideoFileReader('Filename',path);
        %建立檔案撥放物件，分別撥放原始影片與mask標註影片
        obj.maskPlayer=vision.VideoPlayer('Position', [740, 200, 700, 400]);%指定影片視窗開啟位置
        obj.videoPlayer = vision.VideoPlayer('Position', [20, 200, 700, 400]);%指定影片視窗開啟位置
        %對影像進行Blob分析連通情形
        obj.blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
            'AreaOutputPort', true,...
            'CentroidOutputPort', true, ...
            'MinimumBlobArea', 5);