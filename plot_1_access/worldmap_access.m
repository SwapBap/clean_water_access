% Plot 1 - Plots a world map using washdata to show access to improved
% water sources.
% Associated files : Countries.* , WASHDATA_BASIC_ACCESS_2020.csv.

plot_map();

function plot_map()

    washdata_access_file = "WASHDATA_BASIC_ACCESS_2020.csv";
    countries_shapefile = "Countries.shp";

    % Load in shapes and countries
    map = worldmap('World');
    countries = shaperead(countries_shapefile, 'UseGeoCoords', true);

    data = load_washdata(washdata_access_file);
    
    % Loop through countries in shape file and fill them with access info
    for i=1:length(countries)
        
        % Query Table For Access Info
        idx = data.ISO3 == countries(i).ISO_A3 & data.YEAR == 2020;
        access = data(idx,:).PERCENT_BASIC_ACCESS;
        
        % Provide filler values for non-existing data
        if(isempty(access))
           access = -1;
        end
        
        countries(i).WaterAccess = double(access);

 
    end
    
    % Set Up Color Mapping
    cmap = colormap(autumn(length(countries) ) );
    rules = makesymbolspec('Polygon',...
        {'WaterAccess', [1 99.9], 'FaceColor', cmap}, ... % Valid Colors
        {'WaterAccess', [-2 -1], 'FaceColor', '#000000'}); % No data colors
    
    % Plot Shape/Color Data
    geoshow(map, countries,"SymbolSpec",rules);
    c = colorbar(...
        'AxisLocation','out', ...
        'Ticks',[.01 .20 .40 .60 .80 1.00],...
        'TickLabels', ["<1%" "20%" "40%" "60%" "80%" ">99%"]);
        
    c.Label.String = "Percent of population";
    
    % Get rid of the lat long text
    mlabel off; plabel off;
    
    % Set Title
    title("Global Access to Improved Water Sources (Black Means No Data)");
        

    
    
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