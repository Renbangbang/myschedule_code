clear;clc;  
x=[1 2 3 4 5 6 7 8];%  
% training20_testing50  
% y1=[69 33 90 95 96 94 100 73];  
% y2=[94 67 88 93 98 85 100 77];  
  
% training10_testing50  
 y1=[60 51 83 69 96 61 100 61];  
 y2=[92 46 63 95 98 54 98 60];  
y_all=[y1;y2]';  
bar(x,y_all)  
title(' 10-Training and 50-Testing')  
xlabel('Class')  
ylabel('Accuracy')  
legend('SVM','NN',2)  
%set(gca,'xticklabel',{'Hyt','Maple','Su','Zm','Bob','Hly','Hhf','Yq'}); 