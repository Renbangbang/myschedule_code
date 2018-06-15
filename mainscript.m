% main ³ÌÐò 
clear
ma_nu=10;
flowcount=15;
[ myNode,myflow,VNFexecutetime ] = generatedata( ma_nu,flowcount );


[ flowlatency1, flowcompletiontime1,flowduringtime1,flowqueue1 ] = Fun_greedyprocessingtime( myNode,myflow,VNFexecutetime );
[ flowlatency2, flowcompletiontime2,flowduringtime2,flowqueue2 ] = Fun_bestavailability( myNode,myflow,VNFexecutetime );
[ flowlatency3, flowcompletiontime3,flowduringtime3,flowqueue3 ] = Fun_firstfinishtime( myNode,myflow,VNFexecutetime );
x=[1:flowcount];
figure(1)
y_all=[flowlatency1;flowlatency2;flowlatency3]';  
bar(x,y_all)  
title('The lateness of Flow')  
xlabel('Flow')  
ylabel('Lateness Time')  
legend('greedyprocessingtime','greedybegintime','greedyfinishtime','location','best') 
figure(2)
y_all=[flowcompletiontime1;flowcompletiontime2;flowcompletiontime3]';  
bar(x,y_all)  
title('The flow completion time of Flow')  
xlabel('Flow')  
ylabel('Flow Completion Time')  
legend('greedyprocessingtime','greedybegintime','greedyfinishtime','location','best') 
figure(3)
y_all=[flowduringtime1;flowduringtime2;flowduringtime3]';  
bar(x,y_all)  
title('The flow during time of Flow')  
xlabel('Flow')  
ylabel('Flow During Time')  
legend('greedyprocessingtime','greedybegintime','greedyfinishtime','location','best') 
figure(4)
y_all=[flowqueue1;flowqueue2;flowqueue3]';  
bar(x,y_all)  
title('The flow queue time of Flow')  
xlabel('Flow')  
ylabel('Flow queue Time')  
legend('greedyprocessingtime','greedybegintime','greedyfinishtime','location','best') 



