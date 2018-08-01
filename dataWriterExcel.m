%opening all the files
load('filterData.mat');
filename1 = '/Users/pproctor/Documents/MMI/Data/peakValues/mb1/data1.xlsx';
filename2 = '/Users/pproctor/Documents/MMI/Data/peakValues/mb2/data2.xlsx';
filename3 = '/Users/pproctor/Documents/MMI/Data/peakValues/mb3/data3.xlsx';
filename4 = '/Users/pproctor/Documents/MMI/Data/peakValues/mb4/data4.xlsx';
filename5 = '/Users/pproctor/Documents/MMI/Data/peakValues/mb5/data5.xlsx';
filename6 = '/Users/pproctor/Documents/MMI/Data/peakValues/mb6/data6.xlsx';

%Setting the Trial number using regexp, fileID must start with a 1
expression = '-1\d+-';
startIndex = regexp(forceFile, expression);
identifier = forceFile(:,(startIndex + 1): (startIndex + 6));

%Creating title strings
for K = 1:7
  ending = strcat('_', num2str(K));
  id = strcat(identifier, ending);
  idCur = strcat('id',id);
  
  filename = strcat('filter', num2str(K));
  loadedvars.(filename) = idCur;
  
end

%creating table
t = table(filter1, filter2, filter3, filter4, filter5, filter6);

%changing the table titles
t.Properties.VariableNames = {loadedvars.filter1, loadedvars.filter2,...
    loadedvars.filter3, loadedvars.filter4, loadedvars.filter5, loadedvars.filter6};

%Need to change the range for each new set of data
writetable(t(:,1), filename1, 'Sheet', 1, 'Range', 'A1');
writetable(t(:,2), filename2, 'Sheet', 1, 'Range', 'A1');
writetable(t(:,3), filename3, 'Sheet', 1, 'Range', 'A1');
writetable(t(:,4), filename4, 'Sheet', 1, 'Range', 'A1');
writetable(t(:,5), filename5, 'Sheet', 1, 'Range', 'A1');
writetable(t(:,6), filename6, 'Sheet', 1, 'Range', 'A1');

