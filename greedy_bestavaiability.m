% 网络中的节点组成
clear;
ma_nu = 50;
myNode(ma_nu)=struct('deployVNF',[],'capacity',[],'currentsolution',[]); % currentsolution = [111110000088888]
for i =1:ma_nu
     numberofVNF = randperm(4,1);
     randomVNF = randperm(9);
     myNode(i).deployVNF = randomVNF(1:numberofVNF);
     myNode(i).capacity = 100-round(rand(1,1)*50); % 总能放的下，避免拒绝
     myNode(i).currentsolution = zeros(1,10000);
end

% flow的组成，包括其SFC构成,目前为了好表示，我们只取SFC最大长度为9，arrive time, processtime
flowcount = 30;
myflow(flowcount)=struct('SFC',[],'arrivetime',0,'processtime',[],'begintime',[],'exe_node',[],'finishtime',0);
myflow(1).SFC = [8,2,3,6,5]; myflow(1).arrivetime = 0;myflow(1).processtime = zeros(1,length(myflow(1).SFC));
myflow(1).begintime = zeros(1,length(myflow(1).SFC));myflow(1).exe_node = zeros(1,length(myflow(1).SFC));
for i=2:flowcount
     SFClength = 2+ round(rand(1,1)*7);
     a = randperm(SFClength);
     myflow(i).SFC = a(1:SFClength);
     myflow(i).arrivetime = myflow(i-1).arrivetime+ round(rand(1,1)*3);
     myflow(i).processtime = zeros(1,length(myflow(2).SFC));
     myflow(i).begintime = zeros(1,length(myflow(2).SFC));
     myflow(i).exe_node = zeros(1,length(myflow(2).SFC));

end


%%VNF在不同node上的执行时间是[1,10]
VNFexecutetime = ceil(rand(9,ma_nu)*10); 
for i = 1:ma_nu
  for j =1:9
      if ~ismember(j,myNode(i).deployVNF)
          VNFexecutetime(j,i)=10000;
      end
      
  end

end
%每个点有一个时间游标
timecursor=zeros(1,ma_nu);

for i =1:flowcount
    currentSFC = myflow(i).SFC;
    flowfinishtime = myflow(i).arrivetime;
    for j =1:length(currentSFC)  % 为这个SFC找出部署的节点
        currentVNF = currentSFC(j);
        possiblenode = find( VNFexecutetime(currentVNF,:)<10000);
        queuetime = zeros(1,length(possiblenode));
        for kk=1:length(possiblenode)
            queuetime(kk)= timecursor(1,possiblenode(kk)); % + VNFexecutetime(currentVNF,possiblenode(kk))
        end
        [~,location] = min(queuetime);  
           
        
        myflow(i).exe_node(j)= possiblenode(location);
        myflow(i).processtime(j) = VNFexecutetime(currentVNF,possiblenode(location));
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
x=[];
y = [];
for i=1:flowcount
    x=[x,i];
    y=[y,myflow(i).finishtime];
end
bar(x,y)
    















