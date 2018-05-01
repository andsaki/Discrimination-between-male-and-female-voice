function findex = frameindex(framelength, noverlap,signallength)
n = fix((signallength-framelength)/noverlap);
findex = repmat((1:framelength)',1,n)+repmat((0:(n-1))*noverlap,framelength,1);
end