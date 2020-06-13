data=[20 24 27 18;14 12 11 11;12 10 11 12; 9 12 8 10;17 11 4 11];
bar(data,'DisplayName','data')
set(gca,'xticklabel',{'50-75','75-100','100-125','125-150','>150'})
xlabel('spatter diameter[um]')
ylabel('number');
legend('300W','250W','200W','150W');
title('scanning speed 600mm/s')