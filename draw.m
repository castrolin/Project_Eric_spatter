figure,
yyaxis left
histogram(sizeDistrubution)
ylabel('Count of Spatter','FontSize',20)
xlabel('Particle Diameter (\mum)','FontSize',20)

set(gca,'FontSize',20)
yyaxis right
plot(h(2).XData,h(2).YData/max(h(2).YData),'lineWidth',5)
set(gca,'FontSize',20)
ylabel('Normalized Probability Density','FontSize',20)
ylim([0,1.2])