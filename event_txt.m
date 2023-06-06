% output the event.txt

latency = 1:2:178;
type = ones(1,length(latency));
A = [type;latency];
fileID = fopen('event_3min.txt','w');
fprintf(fileID,'%6s %8s\n','type','latency');
fprintf(fileID,'%6d %8.2f\n',A);
fclose(fileID);

