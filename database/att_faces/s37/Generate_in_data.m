function d=Generate_in_data(a,v)
[c b]=size(v);
d=[repmat(a,c,1),v];
