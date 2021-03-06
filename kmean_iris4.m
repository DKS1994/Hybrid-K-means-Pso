%kmeans on iris dataset with c=4

X=load('iris.dat');
k=4;
k1=150;
rng(1);

[gIdx,c]=kmeans(X,k);

[n,m]=size(X);

if ~isscalar(k)
    c=k;
    k=size(c,1);
else
    c=X(ceil(rand(k,1)*n),:);
end

g0=ones(n,1);
gIdx=zeros(n,1);
D=zeros(n,k);
P=zeros(n,k);
OP=zeros(1,k);

tic


while any(g0~=gIdx)

    g0=gIdx;
    
    for t=1:k
        d=zeros(n,1);
        
        for s=1:m
            d=d+(X(:,s)-c(t,s)).^2;
        end
        D(:,t)=sqrt(d);
                  
        x=D(:,1);
        y=D(:,2);
        x1=X(:,4);
        y1=X(:,5);

       clf    
     %   plot(x, y , 'o', x1, y1, '*')   
     %   axis([-50 50 -50 50]);
    
     %   pause(.10)
    end
   
    [z,gIdx]=min(D,[],2);
 
    for t=1:k
        c(t,:)=mean(X(gIdx==t,:));
    end
end

for j=1:n
     p=max(D);
     P=p/D(j);
end

for m=1:k
     for j=1:n
         OP=D(j)*P/k;
     end
end

%fitness evaluation
for i=1:k
  for j=1:n
     f1=X(i)-D(j)/n; 
  end
end
 
f=f1/k;

maxv=max(D);
minv=min(D);

disp('CLUSTER center matrix='); disp(D); %cluster center matrix
disp('MIN value ='); disp(min(minv)); %minimum value
disp('MAX value ='); disp(max(maxv)); %maximum value
disp('MAX Purity overall ='); disp(max(OP)); %maximum purity-overall max purity value
disp('Fitness ='); disp(f); %purity

	

toc

gscatter(x1,y1,gIdx);
