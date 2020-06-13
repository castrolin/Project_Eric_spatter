% SizeDistribution of muti video
% Date:06/03
% Creator:@CastroLin
clc,clear
close all

Data = load('DataBaseOf4L.mat');
% release(Data.object{1,:}.maskPlayer)
for i = 1:size(Data.object.obj,2)
    delete(Data.object.obj{1,i}.videoPlayer)
    delete(Data.object.obj{1,i}.maskPlayer)
end
pixel=42.339783;
stamatrix = zeros(2,size(Data.object.obj,2)); %statistical (1,:)=>mu (2,:)=>sigma
for i = 1:size(Data.object.obj,2)
    numOfSpatter = size(Data.object.obj{1,i}.tracks,2);
    sizeDistribution = zeros(numOfSpatter,1);
    for j = 1:numOfSpatter
        sizeDistribution(j,1) = pixel*sqrt(double(Data.object.obj{1,i}.tracks(j).bbox(3)+...
                                   Data.object.obj{1,i}.tracks(j).bbox(4)))/2;
    end
    
    pd = fitdist(sizeDistribution,'Normal');
    figure(100+i)
    h = histfit(sizeDistribution);
    stamatrix(1,i) = pd.mu;
    stamatrix(2,i) = pd.sigma;
    figure(i),
    yyaxis left
    histogram(sizeDistribution)
    ylabel('Number of spatter','FontSize',20)
    set(gca,'FontSize',20)
    yyaxis right
    plot(h(2).XData,h(2).YData/max(h(2).YData),'lineWidth',5)
    set(gca,'FontSize',20)
    ylabel('Probility density','FontSize',20)
    ylim([0,1.2])
end