img = [1 2 3 4];
prob = [0.4 0.2 0.1 0.3];
inpSeq = [4 1 2 3 4];
cumProb = 0;

for i=1:size(prob,2)
    cumProb = [cumProb cumProb(i)+prob(i)];
end
temp = cumProb;
for i = 1: size(inpSeq,2)-1
    range = temp(inpSeq(i)+1)-temp(inpSeq(i));
    start = temp(inpSeq(i));
    for k=1:size(cumProb,2)
        temp(k) = range*cumProb(k)+start;
    end
    temp
end

x = temp(inpSeq(i+1))+temp(inpSeq(i+1)+1);
x = x/2;
out = 0;
for i=1:length(inpSeq)
    k=0;
    while x>cumProb(k+1)
        k=k+1;
    end
    out = [out k];
    x = (x-cumProb(k))/(cumProb(k+1)-cumProb(k));
end
out = out(2:length(out))
