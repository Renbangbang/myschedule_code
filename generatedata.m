function [ myNode,myflow,VNFexecutetime ] = generatedata( ma_nu,flowcount )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here


myNode(ma_nu)=struct('deployVNF',[],'capacity',[],'currentsolution',[]); % currentsolution = [111110000088888]
allVNF =[];
for i =1:ma_nu
     numberofVNF = randperm(4,1);
     randomVNF = randperm(9);
     myNode(i).deployVNF = randomVNF(1:numberofVNF);
     myNode(i).capacity = 100-round(rand(1,1)*50); % 总能放的下，避免拒绝
     myNode(i).currentsolution = zeros(1,10000);
     allVNF = [allVNF, myNode(i).deployVNF];
end
allVNF = unique(allVNF);
for i=1:9
    if ~ismember(i,allVNF)
        node = randperm(9,1);
        myNode(node).deployVNF = [myNode(node).deployVNF, i];
    end
end




% flow的组成，包括其SFC构成,目前为了好表示，我们只取SFC最大长度为9，arrive time, processtime

myflow(flowcount)=struct('SFC',[],'arrivetime',0,'processtime',[],'begintime',[],'exe_node',[],'finishtime',0);
atemp = randperm(9);
myflow(1).SFC = atemp(1:2+ round(rand(1,1)*7)); myflow(1).arrivetime = 0;myflow(1).processtime = zeros(1,length(myflow(1).SFC));
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

end

