function obj=setupSystemObject(path)
        %�إ��ɮ�Ū������
        obj.reader=vision.VideoFileReader('Filename',path);
        %�إ��ɮ׼��񪫥�A���O�����l�v���Pmask�е��v��
        obj.maskPlayer=vision.VideoPlayer('Position', [740, 200, 700, 400]);%���w�v�������}�Ҧ�m
        obj.videoPlayer = vision.VideoPlayer('Position', [20, 200, 700, 400]);%���w�v�������}�Ҧ�m
        %��v���i��Blob���R�s�q����
        obj.blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
            'AreaOutputPort', true,...
            'CentroidOutputPort', true, ...
            'MinimumBlobArea', 5);