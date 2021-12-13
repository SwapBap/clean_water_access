% Plot 3 - Plots a set of subplots that show total access to basic clean
% water and sanitation.
% Associated files : sanitation*.csv , drinkingwater*.csv
% Satisfies rubrics : 2,3,4,7,8,9
% Primary Author : Joe Remondi

% Clear vars/output
clear();
clc();

% Read in the population with clean drinking water pivot CSVs
% Rubric #3 - Data From Excel
population_d_20 = xlsread('drinkingwater2020.csv','G2:G211');
population_d_19 = xlsread('drinkingwater2019.csv','G2:G215');
population_d_18 = xlsread('drinkingwater2018.csv','G2:G217');
population_d_17 = xlsread('drinkingwater2017.csv','G2:G226');
population_d_16 = xlsread('drinkingwater2016.csv','G2:G211');
population_d_15 = xlsread('drinkingwater2015.csv','G2:G215');
population_d_14 = xlsread('drinkingwater2014.csv','G2:G217');
population_d_13 = xlsread('drinkingwater2013.csv','G2:G226');
population_d_12 = xlsread('drinkingwater2012.csv','G2:G231');
population_d_11 = xlsread('drinkingwater2011.csv','G2:G230');
population_d_10 = xlsread('drinkingwater2010.csv','G2:G229');

% Read in the population with basic sanitation from pivot CSVs
population_s_20 = xlsread('sanitation2020.csv','G2:G134');
population_s_19 = xlsread('sanitation2019.csv','G2:G134');
population_s_18 = xlsread('sanitation2018.csv','G2:G138');
population_s_17 = xlsread('sanitation2017.csv','G2:G141');
population_s_16 = xlsread('sanitation2016.csv','G2:G144');
population_s_15 = xlsread('sanitation2015.csv','G2:G144');
population_s_14 = xlsread('sanitation2014.csv','G2:G145');
population_s_13 = xlsread('sanitation2013.csv','G2:G145');
population_s_12 = xlsread('sanitation2012.csv','G2:G145');
population_s_11 = xlsread('sanitation2011.csv','G2:G145');
population_s_10 = xlsread('sanitation2010.csv','G2:G145');

% Determine percentage of population without access to clean drinking water
uncovered_d_20 = .01*(100 - xlsread('drinkingwater2020.csv','F2:F211'));
uncovered_d_19 = .01*(100 - xlsread('drinkingwater2019.csv','F2:F215'));
uncovered_d_18 = .01*(100 - xlsread('drinkingwater2018.csv','F2:F217'));
uncovered_d_17 = .01*(100 - xlsread('drinkingwater2017.csv','F2:F226'));
uncovered_d_16 = .01*(100 - xlsread('drinkingwater2016.csv','F2:F230'));
uncovered_d_15 = .01*(100 - xlsread('drinkingwater2015.csv','F2:F231'));
uncovered_d_14 = .01*(100 - xlsread('drinkingwater2014.csv','F2:F231'));
uncovered_d_13 = .01*(100 - xlsread('drinkingwater2013.csv','F2:F231'));
uncovered_d_12 = .01*(100 - xlsread('drinkingwater2012.csv','F2:F231'));
uncovered_d_11 = .01*(100 - xlsread('drinkingwater2011.csv','F2:F230'));
uncovered_d_10 = .01*(100 - xlsread('drinkingwater2010.csv','F2:F229'));

% Determine percentage of population without basic sanitation access
uncovered_s_20 = .01*(100 - xlsread('sanitation2020.csv','F2:F134'));
uncovered_s_19 = .01*(100 - xlsread('sanitation2019.csv','F2:F134'));
uncovered_s_18 = .01*(100 - xlsread('sanitation2018.csv','F2:F138'));
uncovered_s_17 = .01*(100 - xlsread('sanitation2017.csv','F2:F141'));
uncovered_s_16 = .01*(100 - xlsread('sanitation2016.csv','F2:F144'));
uncovered_s_15 = .01*(100 - xlsread('sanitation2015.csv','F2:F144'));
uncovered_s_14 = .01*(100 - xlsread('sanitation2014.csv','F2:F145'));
uncovered_s_13 = .01*(100 - xlsread('sanitation2013.csv','F2:F145'));
uncovered_s_12 = .01*(100 - xlsread('sanitation2012.csv','F2:F145'));
uncovered_s_11 = .01*(100 - xlsread('sanitation2011.csv','F2:F145'));
uncovered_s_10 = .01*(100 - xlsread('sanitation2010.csv','F2:F145'));

% Temp Vars
numberwithout_20=0; totalpopulation_d_20=0; totalpopulation_s_20=0; unsanitary_20=0;
numberwithout_19=0; totalpopulation_d_19=0; totalpopulation_s_19=0; unsanitary_19=0;
numberwithout_18=0; totalpopulation_d_18=0; totalpopulation_s_18=0; unsanitary_18=0;
numberwithout_17=0; totalpopulation_d_17=0; totalpopulation_s_17=0; unsanitary_17=0;
numberwithout_16=0; totalpopulation_d_16=0; totalpopulation_s_16=0; unsanitary_16=0;
numberwithout_15=0; totalpopulation_d_15=0; totalpopulation_s_15=0; unsanitary_15=0;
numberwithout_14=0; totalpopulation_d_14=0; totalpopulation_s_14=0; unsanitary_14=0;
numberwithout_13=0; totalpopulation_d_13=0; totalpopulation_s_13=0; unsanitary_13=0;
numberwithout_12=0; totalpopulation_d_12=0; totalpopulation_s_12=0; unsanitary_12=0;
numberwithout_11=0; totalpopulation_d_11=0; totalpopulation_s_11=0; unsanitary_11=0;
numberwithout_10=0; totalpopulation_d_10=0; totalpopulation_s_10=0; unsanitary_10=0;

% Calculate total population without clean drinking water by year
% Rubric #7 & Rubric #8
for i=1:length(population_d_20)
    
    numberwithout_20=numberwithout_20+ uncovered_d_20(i)*population_d_20(i);
    totalpopulation_d_20=totalpopulation_d_20 + population_d_20(i);
end

for i=1:length(population_d_19)
    
    numberwithout_19 = numberwithout_19 + uncovered_d_19(i)*population_d_19(i);
    totalpopulation_d_19 = totalpopulation_d_19 + population_d_19(i);
end
for i=1:length(population_d_18)
    
    numberwithout_18 = numberwithout_18 + uncovered_d_18(i)*population_d_18(i);
    totalpopulation_d_18 = totalpopulation_d_18 + population_d_18(i);
  
end
for i=1:length(population_d_17)
    
    numberwithout_17 = numberwithout_17 + uncovered_d_17(i)*population_d_17(i);
    totalpopulation_d_17 = totalpopulation_d_17 + population_d_17(i);
end
for i=1:length(population_d_16)
    
    numberwithout_16=numberwithout_16 + uncovered_d_16(i)*population_d_16(i);
    totalpopulation_d_16=totalpopulation_d_16 + population_d_16(i);
end
for i=1:length(population_d_15)
    
    numberwithout_15=numberwithout_15+ uncovered_d_15(i)*population_d_15(i);
    totalpopulation_d_15=totalpopulation_d_15 + population_d_15(i);
end

for i=1:length(population_d_14)
    
    numberwithout_14 = numberwithout_14 + uncovered_d_14(i)*population_d_14(i);
    totalpopulation_d_14 = totalpopulation_d_14 + population_d_14(i);
end
for i=1:length(population_d_13)
    
    numberwithout_13 = numberwithout_13 + uncovered_d_13(i)*population_d_13(i);
    totalpopulation_d_13 = totalpopulation_d_13 + population_d_13(i);
  
end
for i=1:length(population_d_12)
    
    numberwithout_12 = numberwithout_12 + uncovered_d_12(i)*population_d_12(i);
    totalpopulation_d_12 = totalpopulation_d_12 + population_d_12(i);
end
for i=1:length(population_d_11)
    
    numberwithout_11 = numberwithout_11 + uncovered_d_11(i)*population_d_11(i);
    totalpopulation_d_11 = totalpopulation_d_11 + population_d_11(i);
end
for i=1:length(population_d_10)
    
    numberwithout_10 = numberwithout_10 + uncovered_d_10(i)*population_d_10(i);
    totalpopulation_d_10 = totalpopulation_d_10 + population_d_10(i);
end


% Caculate total population without basic sanitation access by year
for i=1:length(population_s_20)
    unsanitary_20=unsanitary_20 + uncovered_s_20(i)*population_s_20(i);
    totalpopulation_s_20=totalpopulation_s_20 + population_s_20(i);
end
for i=1:length(population_s_19)
    unsanitary_19=unsanitary_19 + uncovered_s_19(i)*population_s_19(i);
    totalpopulation_s_19 = totalpopulation_s_19 + population_s_19(i);
end
for i=1:length(population_s_18)
    unsanitary_18 = unsanitary_18 + uncovered_s_18(i)*population_s_18(i);
    totalpopulation_s_18 = totalpopulation_s_18 + population_s_18(i);
end
for i=1:length(population_s_17)
    unsanitary_17 = unsanitary_17 + uncovered_s_17(i)*population_s_17(i);
    totalpopulation_s_17 = totalpopulation_s_17 + population_s_17(i);
end
for i=1:length(population_s_16)
    unsanitary_16 = unsanitary_16 + uncovered_s_16(i)*population_s_16(i);
    totalpopulation_s_16 = totalpopulation_s_16 + population_s_16(i);
end
for i=1:length(population_s_15)
    unsanitary_15 = unsanitary_15 + uncovered_s_15(i)*population_s_15(i);
    totalpopulation_s_15 = totalpopulation_s_15 + population_s_15(i);
end
for i=1:length(population_s_14)
    unsanitary_14 = unsanitary_14 + uncovered_s_14(i)*population_s_14(i);
    totalpopulation_s_14 = totalpopulation_s_14 + population_s_14(i);
end
for i=1:length(population_s_13)
    unsanitary_13 = unsanitary_13 + uncovered_s_13(i)*population_s_13(i);
    totalpopulation_s_13 = totalpopulation_s_13 + population_s_13(i);
end
for i=1:length(population_s_12)
    unsanitary_12 = unsanitary_12 + uncovered_s_12(i)*population_s_12(i);
    totalpopulation_s_12 = totalpopulation_s_12 + population_s_12(i);
end
for i=1:length(population_s_11)
    unsanitary_11 = unsanitary_11 + uncovered_s_11(i)*population_s_11(i);
    totalpopulation_s_11 = totalpopulation_s_11 + population_s_11(i);
end
for i=1:length(population_s_10)
    unsanitary_10 = unsanitary_10 + uncovered_s_10(i)*population_s_10(i);
    totalpopulation_s_10 = totalpopulation_s_10 + population_s_10(i);
end

% Percentage of number without clean drinking water
overall_20=numberwithout_20./totalpopulation_d_20;
overall_19=numberwithout_19./totalpopulation_d_19;
overall_18=numberwithout_18./totalpopulation_d_18;
overall_17=numberwithout_17./totalpopulation_d_17;
overall_16=numberwithout_16./totalpopulation_d_16;
overall_15=numberwithout_15./totalpopulation_d_15;
overall_14=numberwithout_14./totalpopulation_d_14;
overall_13=numberwithout_13./totalpopulation_d_13;
overall_12=numberwithout_12./totalpopulation_d_12;
overall_11=numberwithout_11./totalpopulation_d_11;
overall_10=numberwithout_10./totalpopulation_d_10;

disp(overall_20);
disp(overall_19);
disp(overall_18);
disp(overall_17);
disp(overall_16);
disp(overall_15);
disp(overall_14);
disp(overall_13);
disp(overall_12);
disp(overall_11);
disp(overall_10);

disp(totalpopulation_d_20);
disp(totalpopulation_d_19);
disp(totalpopulation_d_18);
disp(totalpopulation_d_17);
disp(totalpopulation_d_16);
disp(totalpopulation_d_15);
disp(totalpopulation_d_14);
disp(totalpopulation_d_13);
disp(totalpopulation_d_12);
disp(totalpopulation_d_11);
disp(totalpopulation_d_10);

disp(numberwithout_20);
disp(numberwithout_19);
disp(numberwithout_18);
disp(numberwithout_17);
disp(numberwithout_16);
disp(numberwithout_15);
disp(numberwithout_14);
disp(numberwithout_13);
disp(numberwithout_12);
disp(numberwithout_11);
disp(numberwithout_10);

disp(unsanitary_20);
disp(unsanitary_19);
disp(unsanitary_18);
disp(unsanitary_17);
disp(unsanitary_16);
disp(unsanitary_15);
disp(unsanitary_14);
disp(unsanitary_13);
disp(unsanitary_12);
disp(unsanitary_11);
disp(unsanitary_10);

% Percent of total population without basic sanitation access
sanitary_rate_20 = (unsanitary_20./totalpopulation_d_20);
sanitary_rate_19 = (unsanitary_19./totalpopulation_d_19);
sanitary_rate_18 = (unsanitary_18./totalpopulation_d_18);
sanitary_rate_17 = (unsanitary_17./totalpopulation_d_17);
sanitary_rate_16 = (unsanitary_16./totalpopulation_d_16);
sanitary_rate_15 = (unsanitary_15./totalpopulation_d_15);
sanitary_rate_14 = (unsanitary_14./totalpopulation_d_14);
sanitary_rate_13 = (unsanitary_13./totalpopulation_d_13);
sanitary_rate_12 = (unsanitary_12./totalpopulation_d_12);
sanitary_rate_11 = (unsanitary_11./totalpopulation_d_11);
sanitary_rate_10 = (unsanitary_10./totalpopulation_d_10);

disp(sanitary_rate_20);
disp(sanitary_rate_19);
disp(sanitary_rate_18);
disp(sanitary_rate_17);
disp(sanitary_rate_16);
disp(sanitary_rate_15);
disp(sanitary_rate_14);
disp(sanitary_rate_13);
disp(sanitary_rate_12);
disp(sanitary_rate_11);
disp(sanitary_rate_10);

% Define plot data and plot
% Rubric #4,#9

% Define years to plot
years = [2010:1:2020];

poverall = subplot(4,1,1);

% Plot Overall
overall = [overall_10 overall_11 overall_12 overall_13 overall_14 overall_15 ...
            overall_16 overall_17 overall_18 overall_19 overall_20];
plot(poverall,years,overall);
title("% of World Population Without Clean Drinking Water");
       
ptotal = subplot(4,1,2);

% Plot Total
total = [totalpopulation_d_10 totalpopulation_d_11 totalpopulation_d_12 ...
            totalpopulation_d_13 totalpopulation_d_14 totalpopulation_d_15 ...
            totalpopulation_d_16 totalpopulation_d_17 totalpopulation_d_18 ...
            totalpopulation_d_19 totalpopulation_d_20];
plot(ptotal,years,total);
title("Total World Population Without Clean Drinking Water");

% Plot Number Without
numberwithout = [ numberwithout_10 numberwithout_11 numberwithout_12 numberwithout_13 ...
                    numberwithout_14 numberwithout_15 numberwithout_16 numberwithout_17 ...
                    numberwithout_18 numberwithout_19 numberwithout_20 ];
 
pnumwithout = subplot(4,1,3);
plot(pnumwithout, years, numberwithout);
title("Total World Population Without Sanitation Access");

% Sanitary Rate
sanitary_rate = [   sanitary_rate_10 sanitary_rate_11 sanitary_rate_12 ...
                    sanitary_rate_13 sanitary_rate_14 sanitary_rate_15 ...
                    sanitary_rate_16 sanitary_rate_17 sanitary_rate_18 ...
                    sanitary_rate_19 sanitary_rate_20 ];

srate_plot = subplot(4,1,4);
plot(srate_plot, years, sanitary_rate);
title("% of World Population Without Sanitation Access");