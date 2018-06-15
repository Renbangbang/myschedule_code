function [ flowlatency, flowcompletiontime,flowduringtime,flowqueue ] = Fun_greedyprocessingtime( myNode,myflow,VNFexecutetime )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
ma_nu = length(myNode);
flowcount = length(myflow);
%每个点有一个时间游标
timecursor=zeros(1,ma_nu);

for i =1:flowcount
    currentSFC = myflow(i).SFC;
    flowfinishtime = myflow(i).arrivetime;
    for j =1:length(currentSFC)  % 为这个SFC找出部署的节点
        [temp,index]=min(VNFexecutetime(currentSFC(j),:));
        myflow(i).exe_node(j)=index;
        myflow(i).processtime(j) = temp;
    end
    % 在完成部署后，按照FIFO的规则开始对flow进行调度，即甘特图的填充
    for j=1:length(currentSFC)
        currentnode = myflow(i).exe_node(j); % 当前流的第j个VNF被部署在了哪个节点
        
        timecursor(1,currentnode) = max(flowfinishtime,timecursor(1,currentnode));
        myflow(i).begintime(j) = timecursor(1,currentnode);
        duringtime = myflow(i).processtime(j);
        myNode(currentnode).currentsolution(1,timecursor(1,currentnode)+1:timecursor(1,currentnode)+duringtime+1)=i;
        % 更新该点的时间游标，更新flow当前VNF执行完的时间
        timecursor(1,currentnode) = timecursor(1,currentnode)+ myflow(i).processtime(j); 
        flowfinishtime = max(flowfinishtime,timecursor(1,currentnode));
    
    end
        myflow(i).finishtime = timecursor(1,currentnode);
        
end
      flowarrivetime = [];flowbegintime =[];flowfinishtime =[]; totalprocesstime=[];
      for i=1:flowcount
          flowarrivetime = [flowarrivetime,myflow(i).arrivetime];
          tempbegintime = myflow(i).begintime;
          flowbegintime = [flowbegintime, tempbegintime(1)];
          flowfinishtime = [flowfinishtime, myflow(i).finishtime];
          totalprocesstime = [totalprocesstime, sum(myflow(i).processtime)];
          
      end
      % flow到达和开始之间的推迟
      flowlatency = flowbegintime-flowarrivetime;
      % flow completion time， 即flow 完成与到达之间的差距
      flowcompletiontime = flowfinishtime- flowarrivetime;
      % flow 执行时间 即 flow 完成与开始执行之间的差距
      flowduringtime = flowfinishtime - flowbegintime;
      % flow 的排队时间
      flowqueue = flowduringtime - totalprocesstime;




end

