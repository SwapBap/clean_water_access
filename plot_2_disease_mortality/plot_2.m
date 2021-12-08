
plot_data();

% Entry point, loads data with load_*data, then plots data sets with
% plot_bar(...). Returns axes.
function axes = plot_data()

    % Our Query Parameters for years/countries we want
    five_low = ["Kenya" "Ethiopia" "Tanzania" "Republic of Congo" "Côte d’Ivoire"];
    five_high = ["Australia","Mexico"    ];
    five_low_iso = ["KEN" "ETH" "TZA" "COD" "CIV"];
    five_high_iso = ["AUS","MEX"   ];
    years_of_interest = [ 2018 2019 2020 ];
    
    % Load both trachoma data and washdata
    washdata = load_washdata("WASHDATA_BASIC_ACCESS_2020.csv");
    trachdata = load_trachomadata("trachoma_data.csv");
    
    % Plot five low countries
    plot_bar( five_low , five_low_iso , years_of_interest , [1 2] ,...
        "% of Population with Access to Improved Water Sources",...
        "Number of Population Treated for Trachoma Infection" ,...
        washdata, trachdata );
    
    % Plot five high countries
    plot_bar( five_high, five_high_iso , years_of_interest , [3 4] ,...
        "% of Population with Access to Improved Water Sources",...
        "Number of Population Treated for Trachoma Infection" ,...
        washdata, trachdata );
end

% Function that plots two specified subplots for the trichoma data based on
% country and year range
function plot_bar( countries, countries_iso, years , subplots , title1 , title2 , washdata , trachdata )

    % Get our graphable data in year, % access, trichoma cases format
    access_grouped = [];
    trachoma_grouped = [];
    for( i=1:length(countries_iso) )
        
        % Query table for access and trach data
        [access,trach] = get_row(countries_iso(i),washdata,trachdata,years);
        access_grouped(i,:) = access;
        trachoma_grouped(i,:) = trach;
        
        % Interpolate using fillmissing using linear interpolation
        [access_grouped(i,:),tf] = fillmissing(access_grouped(i,:),'next','SamplePoints',years);
        [trachoma_grouped(i,:),tf] = fillmissing(trachoma_grouped(i,:),'next','SamplePoints',years);
        
    end
    
    % Plot our bars
    % Plot 1, Percentage of population
    plot_access = subplot(4,1,subplots(1));
    plot_trachoma = subplot(4,1,subplots(2));
    
    % Access Graph Plot
    bar(plot_access,years, access_grouped);
    legend(plot_access, countries);
    
    % Access Graph Setup
    title(plot_access,title1);
    xlim(plot_access, [ years(1)+0.5 years(end)+0.5]);
    xticks(plot_access,years);
    grid(plot_access, "on");
    ylim(plot_access,[-10 110]);
    ylabel("Percentage of population with access to improved water sources");
    xlabel("Sample Year");
    
    
    % Trachoma Graph Plot
    bar(plot_trachoma,years, trachoma_grouped);

    % Trachoma Graph Setup
    title(plot_trachoma,title2);
    xlim(plot_trachoma, [ years(1)+0.5 , years(end)+0.5]);
    xticks(plot_trachoma,years);
    grid(plot_trachoma, "on");
    legend(plot_trachoma, countries);
    ylim(plot_trachoma,'auto');
    ylabel("Population treated for Trachoma");
    xlabel("Sample Year");
    

end

% Gets the a row of y-value data based on country code
function [access,trach]= get_row(country_code,washdata,trachdata,years_of_interest)
    
    access = [];
    trach = [];
    
    for( j=1:length(years_of_interest) )
        % Query Table For Access Info by year and country
        idx = washdata.ISO3 == country_code & washdata.YEAR == years_of_interest(j);
        if idx == 0
            fprintf("%s %d access data isn't available!", country_code, years_of_interest(j));
        end
        access(j) = washdata(idx,:).PERCENT_BASIC_ACCESS;
        % Get number of trachoma cases per year
        idx = trachdata.ISO3 == country_code & trachdata.Year == years_of_interest(j);
        if idx == 0
            fprintf("%s %d trachoma data isn't available!", country_code, years_of_interest(j));
        end
        trach(j) = trachdata(idx,:).FactValueNumeric;
        % Debug Print
        %fprintf("%s %d %f %f\n",country_code, years_of_interest(j),access,trachoma);
    end
end

% Loads the washdata
function data = load_washdata(filename)
    % Set up the Import Options and import the data
    opts = delimitedTextImportOptions("NumVariables", 4);

    % Specify range and delimiter
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["COUNTRY", "ISO3", "YEAR", "PERCENT_BASIC_ACCESS"];
    opts.VariableTypes = ["string", "string", "double", "double"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["COUNTRY", "ISO3"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["COUNTRY", "ISO3"], "EmptyFieldRule", "auto");

    % Import the data
    data = readtable(filename, opts);
end

% Loads number of people treated for trachoma infection data
function data = load_trachomadata(filename)
    % Import options
    opts = delimitedTextImportOptions("NumVariables", 34);

    % Specify range and delimiter
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "ISO3", "Location", "Var9", "Year", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "FactValueNumeric", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34"];
    opts.SelectedVariableNames = ["ISO3", "Location", "Year", "FactValueNumeric"];
    opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];

    % Specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Specify variable properties
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "ISO3", "Location", "Var9", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "ISO3", "Location", "Var9", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, ["Year", "FactValueNumeric"], "ThousandsSeparator", ",");

    % Import the data
    data = readtable(filename, opts);

end