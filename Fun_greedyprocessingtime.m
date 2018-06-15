function [ flowlatency, flowcompletiontime,flowduringtime,flowqueue ] = Fun_greedyprocessingtime( myNode,myflow,VNFexecutetime )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
ma_nu = length(myNode);
flowcount = length(myflow);
%ÿ������һ��ʱ���α�
timecursor=zeros(1,ma_nu);

for i =1:flowcount
    currentSFC = myflow(i).SFC;
    flowfinishtime = myflow(i).arrivetime;
    for j =1:length(currentSFC)  % Ϊ���SFC�ҳ�����Ľڵ�
        [temp,index]=min(VNFexecutetime(currentSFC(j),:));
        myflow(i).exe_node(j)=index;
        myflow(i).processtime(j) = temp;
    end
    % ����ɲ���󣬰���FIFO�Ĺ���ʼ��flow���е��ȣ�������ͼ�����
    for j=1:length(currentSFC)
        currentnode = myflow(i).exe_node(j); % ��ǰ���ĵ�j��VNF�����������ĸ��ڵ�
        
        timecursor(1,currentnode) = max(flowfinishtime,timecursor(1,currentnode));
        myflow(i).begintime(j) = timecursor(1,currentnode);
        duringtime = myflow(i).processtime(j);
        myNode(currentnode).currentsolution(1,timecursor(1,currentnode)+1:timecursor(1,currentnode)+duringtime+1)=i;
        % ���¸õ��ʱ���α꣬����flow��ǰVNFִ�����ʱ��
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
      % flow����Ϳ�ʼ֮����Ƴ�
      flowlatency = flowbegintime-flowarrivetime;
      % flow completion time�� ��flow ����뵽��֮��Ĳ��
      flowcompletiontime = flowfinishtime- flowarrivetime;
      % flow ִ��ʱ�� �� flow ����뿪ʼִ��֮��Ĳ��
      flowduringtime = flowfinishtime - flowbegintime;
      % flow ���Ŷ�ʱ��
      flowqueue = flowduringtime - totalprocesstime;




end

