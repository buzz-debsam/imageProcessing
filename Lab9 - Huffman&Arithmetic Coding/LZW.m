input = 'ABABBABCABABBA';
l = length(input);
x = {'A','B','C'};
y = [1 2 3];
lmap = containers.Map(x,y);
output = [];
count = 4;
string = input(1);
ind = 1;
while ind+1<=l
    ind = ind+1;
    char = input(ind);
    if isKey(lmap,strcat(string,char))
        string = strcat(string,char);
    else
        output = [output values(lmap,{string})];
        lmap(strcat(string,char)) = count;
        count = count+1;
        string = char;
    end
end