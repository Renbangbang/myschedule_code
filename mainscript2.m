% 看看参数对算法的影响，多次运行的平均结果
dbstop if error
clear;
ma_nu=20;
flowcount = [20:10:80];
meanflowlatency1 = zeros(1,length(flowcount));meanflowcompletiontime1 = zeros(1,length(flowcount));
meanflowduringtime1 = zeros(1,length(flowcount));meanflowqueue1 = zeros(1,length(flowcount));
meanflowlatency2 = zeros(1,length(flowcount));meanflowcompletiontime2 = zeros(1,length(flowcount));
meanflowduringtime2 = zeros(1,length(flowcount));meanflowqueue2 = zeros(1,length(flowcount));
meanflowlatency3 = zeros(1,length(flowcount));meanflowcompletiontime3 = zeros(1,length(flowcount));
meanflowduringtime3 = zeros(1,length(flowcount));meanflowqueue3 = zeros(1,length(flowcount));


runtimes = 100;
flowlatency1=zeros(1,runtimes);flowlatency2=zeros(1,runtimes);flowlatency3=zeros(1,runtimes);
flowcompletiontime1=zeros(1,runtimes);flowcompletiontime2=zeros(1,runtimes);flowcompletiontime3=zeros(1,runtimes);
flowduringtime1=zeros(1,runtimes);flowduringtime2=zeros(1,runtimes);flowduringtime3=zeros(1,runtimes);
flowqueue1=zeros(1,runtimes);flowqueue2=zeros(1,runtimes);flowqueue3=zeros(1,runtimes);
for i =1:length(flowcount)
   for j=1:runtimes
       [ myNode,myflow,VNFexecutetime ] = generatedata( ma_nu,flowcount(i) );
       myNode2 =myNode;myflow2 = myflow;VNFexecutetime2 = VNFexecutetime;
       myNode3 =myNode;myflow3 = myflow;VNFexecutetime3 = VNFexecutetime;
       [a,b,c,d ] = Fun_greedyprocessingtime( myNode,myflow,VNFexecutetime );
       flowlatency1(j)= mean(a);flowcompletiontime1(j)=mean(b);flowduringtime1(j)=mean(c);flowqueue1(j)=mean(d);
       [a,b,c,d ] = Fun_bestavailability( myNode2,myflow2,VNFexecutetime2 );
       flowlatency2(j)=mean(a);flowcompletiontime2(j)=mean(b);flowduringtime2(j)=mean(c);flowqueue2(j)=mean(d);
       [a,b,c,d]= Fun_firstfinishtime( myNode3,myflow3,VNFexecutetime3 );
       flowlatency3(j)=mean(a);flowcompletiontime3(j)=mean(b);flowduringtime3(j)=mean(c);flowqueue3(j)=mean(d);

   end
   meanflowlatency1(i) = mean(flowlatency1);meanflowcompletiontime1(i) = mean(flowcompletiontime1);
   meanflowduringtime1(i)= mean(flowduringtime1);meanflowqueue1(i) = mean(flowqueue1);
   
   meanflowlatency2(i) = mean(flowlatency2);meanflowcompletiontime2(i) = mean(flowcompletiontime2);
   meanflowduringtime2(i)= mean(flowduringtime2);meanflowqueue2(i) = mean(flowqueue2);
   
   meanflowlatency3(i) = mean(flowlatency3);meanflowcompletiontime3(i) = mean(flowcompletiontime3);
   meanflowduringtime3(i)= mean(flowduringtime3);meanflowqueue3(i) = mean(flowqueue3);
 
end
figure(1)
plot(flowcount,meanflowlatency1,'-s',flowcount,meanflowlatency2,'*-',flowcount,meanflowlatency3,'-h')
xlabel('The number of flows')
ylabel('The mean lateness of flow')
legend('greedyprocessingtime','greedybegintime','greedyfinishtime','location','best') 

figure(2)
plot(flowcount,meanflowcompletiontime1,'-s',flowcount,meanflowcompletiontime2,'*-',flowcount,meanflowcompletiontime3,'-h')
xlabel('The number of flows')
ylabel('The mean flow completion time')
legend('greedyprocessingtime','greedybegintime','greedyfinishtime','location','best') 

figure(3)
plot(flowcount,meanflowduringtime1,'-s',flowcount,meanflowduringtime2,'*-',flowcount,meanflowduringtime3,'-h')
xlabel('The number of flows')
ylabel('The mean duringtime of flow')
legend('greedyprocessingtime','greedybegintime','greedyfinishtime','location','best') 

figure(4)
plot(flowcount,meanflowqueue1,'-s',flowcount,meanflowqueue2,'*-',flowcount,meanflowqueue3,'-h')
xlabel('The number of flows')
ylabel('The mean queue of flow')
legend('greedyprocessingtime','greedybegintime','greedyfinishtime','location','best') 