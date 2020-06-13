% %% plot length
length=[171 162 207;132 161 179;117 154 171;122 120 132.2];
error=[23 0 0 ;31.7 0 0 ;36 0 0;26.8 0 0 ];
h=barwitherr(error,length);
set(gca,'XTickLabel',{'300W','250W','200W','150W'},'FontSize',30)
legend('Monitoring',"Simulation ","measured",'FontSize',30)
xlabel('laser power[W]','FontSize',30)
ylabel('\mum','FontSize',30)
ylim([0 250]) % specific y axis range
title('extracted length for scaning speed 600mm/s','FontSize',30)

%% plot width
% figure;
% width=[213 150 180;224 143 173; 210 132 160;147 128 150]
% error=[25.0 0 0;35.1 0 0;34 0 0;24.22 0 0];%error bar
% h=barwitherr(error,width)
% set(gca,'XTickLabel',{'300W','250W','200W','150W'})
% legend('experiment','Simon simulation','Eason')
% xlabel('laser power[W]')
% ylabel('um')
% title('extracted width for scaning speed 600mm/s')
%% plot spatter
% figure;
% width=[49 42 24 23;15 16 12 6;12 8 4 5;7 6 4 4; 5 4 8 2];
% error=zeros(size(width));
% h=barwitherr(error,width)
% set(gca,'XTickLabel',{'0~50','50~75um','75~100um','100~125um','>125um'})
% legend('300W','250W','200W','150W');
% xlabel('spot diameter')
% ylabel('count')
% title('histogram for different size')