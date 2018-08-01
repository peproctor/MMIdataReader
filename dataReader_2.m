%senD = readtable('/Users/pproctor/Documents/MMI/Data/ForceData/7_11_18/RID1-SID2018-CID143-094242-Analog_Sensor_edit.txt');

forceFile = '/Users/pproctor/Documents/MMI/Data/232NH8(2_1)/ForceData/RID1-SID2018-CID2194-143300-Analog_Sensor.txt';
senD = readtable(forceFile);

%Time
tF = (senD{:,6}/ 1000000); %(4173000));
%tV = velD{:,6};

%Period how to set period automatically
T = 2.38;
T_perc = T / max(tF);
cycles = tF / 1.64;

%Length of chunking and offset
chunk = 400;%370;
offset = 3430;

%need to set per test cycle
num_cycles = round((length(tF) - offset) / chunk);


%Motorbox force data

sd_1 = senD{:,10};
sd_2 = senD{:,11};
sd_3 = senD{:,12};
sd_4 = senD{:,13};
sd_5 = senD{:,14};
sd_6 = senD{:,15};

%Peak value threshold levels

value_h = .6;
value_l = .25;

%Threshold differential for 1
if max(sd_1) >= 1.5
   
    thld_1 = value_h;
else
    thld_1 = value_l;
end

%Threshold differential for 2
if max(sd_2) >= 1.5
   
    thld_2 = value_h;
else
    thld_2 = value_l;
end

%Threshold differential for 3
if max(sd_3) >= 1.5
   
    thld_3 = value_h;
else
    thld_3 = value_l;
end

%Threshold differential for 4
if max(sd_4) >= 1.5
   
    thld_4 = value_h;
else
    thld_4 = value_l;
end

%Threshold differential for 5
if max(sd_5) >= 1.5
   
    thld_5 = value_h;
else
    thld_5 = value_l;
end

%Threshold differential for 6
if max(sd_6) >= 1.5
   
    thld_6 = value_h;
else
    thld_6 = value_l;
end

%Removing force hold residue
%{
sd1_clean = sd1(offset:length(sd1), 1);
sd2_clean = sd2(offset:length(sd2), 1);
sd3_clean = sd3(offset:length(sd3), 1);
sd4_clean = sd4(offset:length(sd4), 1);
sd5_clean = sd5(offset:length(sd5), 1);
sd6_clean = sd6(offset:length(sd6), 1);
%}

%Tracking force sensor peaks


n = 0;

%Getting sizes of signals


%Storing peak values
%assuming same peak value size, each row will be a peak, each column the elements of the peak 
peak1ValuesAll = zeros(num_cycles, 1); 
peak2ValuesAll = zeros(num_cycles, 1); 
peak3ValuesAll = zeros(num_cycles, 1); 
peak4ValuesAll = zeros(num_cycles, 1); 
peak5ValuesAll = zeros(num_cycles, 1); 
peak6ValuesAll = zeros(num_cycles, 1);

%Taking peak values for SD1 
if (max(sd_1) >= .25)
    while n < num_cycles
        n = n + 1;

        
        if n == 1
 
            [peak1_1, I] = sort(sd_1(offset:(chunk + offset)), 'descend');
            
            comparePeak1 = peak1_1(1);
            peakValue1 = comparePeak1;
            
            peak1ValuesAll(n) = peakValue1;
            
        else
            
            [peak_other1,I1] = sort(sd_1((offset + (chunk * (n-1))) :((chunk * (n))) + offset),'descend');
            
            if (peak_other1(1) >= (comparePeak1 * .8)) || (comparePeak1 - peak_other1(1)) <= thld_1
               
                comparePeak1 = peak_other1(1);
                peakValue1X = comparePeak1;
                
                peak1ValuesAll(n) = peakValue1X;
                
            
                
            end
               
            
            
            
        end
    end
end

%Taking peak values for SD2 
n = 0;

if (max(sd_2) >= .25)
    while n < num_cycles
        n = n + 1;

        
        if n == 1
           
            [peak2_1, I] = sort(sd_2(offset:(chunk + offset)), 'descend');
            
            comparePeak2 = peak2_1(1);
            peakValue2 = comparePeak2;
            
            peak2ValuesAll(n) = peakValue2;
            
        else
            
            [peak_other2,I2] = sort(sd_2((offset + (chunk * (n-1))) :((chunk * (n))) + offset),'descend');
            
            %problem: previous peak threshold value too high when there is an abrupt
            %change in force, lower force PEAK values aren't registered
            %each chunk has collection of low values
            if (peak_other2(1) >= (comparePeak2 * .8)) || (comparePeak2 - peak_other2(1)) <= thld_2 
               
                comparePeak2 = peak_other2(1);
                peakValue2X = comparePeak2;
                
                peak2ValuesAll(n) = peakValue2X;
                
            
                
            end
               
            
            
            
        end
    end
end

%Taking peak values for SD3 
n = 0;

if (max(sd_3) >= .25)
    while n < num_cycles
        n = n + 1;

        
        if n == 1
            
            [peak3_1, I] = sort(sd_3(offset:(chunk + offset)), 'descend');
            
            comparePeak3 = peak3_1(1);
            peakValue3 = comparePeak3;
            
            peak3ValuesAll(n) = peakValue3;
            
        else
            
            [peak_other3,I3] = sort(sd_3((offset + (chunk * (n-1))) :((chunk * (n))) + offset),'descend');
            
            if (peak_other3(1) >= (comparePeak3 * .8)) || (comparePeak3 - peak_other3(1)) <= thld_3
               
                comparePeak3 = peak_other3(1);
                peakValue3X = comparePeak3;
                
                peak3ValuesAll(n) = peakValue3X;
                
            
                
            end
               
            
            
            
        end
    end
end

%Taking peak values for SD4 
n = 0;

if (max(sd_4) >= .25)
    while n < num_cycles
        n = n + 1;

        
        if n == 1
            %find peak values of first 500 to get comparison value, could
            %be too high of a range
            [peak4_1, I] = sort(sd_4(offset:(chunk + offset)), 'descend');
            
            comparePeak4 = peak4_1(1);
            peakValue4 = comparePeak4;
            
            peak4ValuesAll(n) = peakValue4;
            
        else
            
            [peak_other4,I4] = sort(sd_4((offset + (chunk * (n-1))) :((chunk * (n))) + offset),'descend');
            
            if (peak_other4(1) >= (comparePeak4 * .8)) || (comparePeak4 - peak_other4(1)) <= thld_4
               
                comparePeak4 = peak_other4(1);
                peakValue4X = comparePeak4;
                
                peak4ValuesAll(n) = peakValue4X;
                
            
                
            end
               
            
            
            
        end
    end
end
         
%Taking peak values for SD5 
n = 0;

if (max(sd_5) >= .25)
    while n < num_cycles
        n = n + 1;

        
        if n == 1
            %find peak values of first 500 to get comparison value, could
            %be too high of a range
            [peak5_1, I] = sort(sd_5(offset:(chunk + offset)), 'descend');
            
            comparePeak5 = peak5_1(1);
            peakValue5 = comparePeak5;
            
            peak5ValuesAll(n) = peakValue5;
            
        else
            
            [peak_other5,I5] = sort(sd_5((offset + (chunk * (n-1))) :((chunk * (n))) + offset),'descend');
            
            if (peak_other5(1) >= (comparePeak5 * .8)) || (comparePeak5 - peak_other5(1)) <= thld_5
               
                comparePeak5 = peak_other5(1);
                peakValue5X = comparePeak5;
                
                peak5ValuesAll(n) = peakValue5X;
                
            
                
            end
               
            
            
            
        end
    end
end
            
%Taking peak values for SD6
n = 0;

if (max(sd_6) >= .25)
    while n < num_cycles
        n = n + 1;

        
        if n == 1
            %find peak values of first 500 to get comparison value, could
            %be too high of a range
            [peak6_1, I] = sort(sd_6(offset:(chunk + offset)), 'descend');
            
            comparePeak6 = peak6_1(1);
            peakValue6 = comparePeak6;
            
            peak6ValuesAll(n) = peakValue6;
            
        else
            
            [peak_other6,I6] = sort(sd_6((offset + (chunk * (n-1))) :((chunk * (n))) + offset),'descend');
            
            if (peak_other6(1) >= (comparePeak6 * .8)) || (comparePeak6 - peak_other6(1)) <= thld_6
               
                comparePeak6 = peak_other6(1);
                peakValue6X = comparePeak6;
                
                peak6ValuesAll(n) = peakValue6X;
                
               
            end
               
            
            
            
        end
    end
end

%Cleaning and plotting max values

windowSize = 10; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

%removing zeros
peak1ValuesAll(peak1ValuesAll==0) = [];
peak2ValuesAll(peak2ValuesAll==0) = [];
peak3ValuesAll(peak3ValuesAll==0) = [];
peak4ValuesAll(peak4ValuesAll==0) = [];
peak5ValuesAll(peak5ValuesAll==0) = [];
peak6ValuesAll(peak6ValuesAll==0) = [];

aX1 = linspace(1,length(peak1ValuesAll),length(peak1ValuesAll));
aX2 = linspace(1,length(peak2ValuesAll),length(peak2ValuesAll));
aX3 = linspace(1,length(peak3ValuesAll),length(peak3ValuesAll));
aX4 = linspace(1,length(peak4ValuesAll),length(peak4ValuesAll));
aX5 = linspace(1,length(peak5ValuesAll),length(peak5ValuesAll));
aX6 = linspace(1,length(peak6ValuesAll),length(peak6ValuesAll));

%padding with zeros
filterStan = zeros(1, 1000);

%aquiring averaged values
filter1 = filter(b, a, peak1ValuesAll.');
filter2 = filter(b, a, peak2ValuesAll.');
filter3 = filter(b, a, peak3ValuesAll.');
filter4 = filter(b, a, peak4ValuesAll.');
filter5 = filter(b, a, peak5ValuesAll.');
filter6 = filter(b, a, peak6ValuesAll.');


%Plottting force values
figure;
subplot(3,2,1);
plot(aX1, filter1, 'Color',[0,0,1]);
title('Force MB1 vs. Cycles');
xlabel('Cycles');
ylabel('Force');
ylim([0,3]);

subplot(3,2,2);
plot(aX2, filter2, 'Color',[0,.5,0]);
title('Force MB2 vs. Cycles');
xlabel('Cycles');
ylabel('Force');
ylim([0,3]);

subplot(3,2,3);
plot(aX3, filter3, 'Color',[0,.7,0]);
title('Force MB3 vs. Cycles');
xlabel('Cycles');
ylabel('Force');
ylim([0,3]);

subplot(3,2,4);
plot(aX4, filter4, 'Color',[.5,0,0]);
title('Force MB4 vs. Cycles');
xlabel('Cycles');
ylabel('Force');
ylim([0,3]);

subplot(3,2,5);
plot(aX5, filter5, 'Color',[.3,0,0]);
title('Force MB5 vs. Cycles');
xlabel('Cycles');
ylabel('Force');
ylim([0,3]);

subplot(3,2,6);
plot(aX6, filter6, 'Color',[0.7,0,0]);
title('Force MB6 vs. Cycles');
xlabel('Cycles');
ylabel('Force');
ylim([0,3]);

%Padding with zeros
filter1(numel(filterStan)) = 0;
filter2(numel(filterStan)) = 0;
filter3(numel(filterStan)) = 0;
filter4(numel(filterStan)) = 0;
filter5(numel(filterStan)) = 0;
filter6(numel(filterStan)) = 0;



filter1 = filter1.';
filter2 = filter2.';
filter3 = filter3.';
filter4 = filter4.';
filter5 = filter5.';
filter6 = filter6.';


save('filterData', 'filter1', 'filter2', 'filter3', 'filter4',...
    'filter5', 'filter6', 'forceFile');


