% Clear past console and variables
clc();clear();

% Generate UI Window and Elements
create_ui();

% Generate the base UI
function create_ui()

    % Figure Setup
    figure = uifigure('Visible', 'off');
    figure.Position = [100 100 860 480];
    figure.Name = 'Water Quality Index';

    % Grid Layout
    grid = uigridlayout(figure);
    grid.ColumnWidth = {220, '1x', 56};
    grid.RowHeight = {'1x'};
    grid.ColumnSpacing = 0;
    grid.RowSpacing = 0;
    grid.Padding = [0 0 0 0];
    grid.Scrollable = 'on';

    % Create LeftPanel
    lpanel = uipanel(grid);
    lpanel.Layout.Row = 1;
    lpanel.Layout.Column = 1;

    % Open File Button
    file_button = uibutton(lpanel, 'push');
    file_button.Position = [60 425 100 22];
    file_button.Text = 'Open File';
    file_button.ButtonPushedFcn = @(obj,event) open_csv(obj,event);

    % Country listbox
    countries_lb = uilistbox(lpanel,"Tag","country_lb");
    countries_lb.Position = [60 87 100 289];

    % Country label
    country_lbl = uilabel(lpanel);
    country_lbl.Position = [60 383 57 22];
    country_lbl.Text = 'Countries';

    % Create CenterPanel
    panel_center = uipanel(grid);
    panel_center.Layout.Row = 1;
    panel_center.Layout.Column = 2;

    % Create Graph
    graph = uiaxes(panel_center,'Tag','main_axes','Nextplot','add');
    title(graph, 'Water Quality')
    xlabel(graph, 'Year')
    ylabel(graph, '% of Population With Non-contaminated Water')
    zlabel(graph, 'Z')
    graph.Position = [6 76 408 362];

    % Create RightPanel
    right_panel = uipanel(grid);
    right_panel.Layout.Row = 1;
    right_panel.Layout.Column = 3;

    % Show the figure after all components are created
    figure.Visible = 'on';
end

% Handle when openfile button pressed
function open_csv(obj,evt)

    % Choose file to load
    [file,path] = uigetfile('*.csv');
    
    % RETURN : Cancel selected so quit
    if(isequal(file,0))
        return;
    end
    
    % Proceed with file load
    T = readtable( strcat(path , file) );

    graph_data(T);
end

% Graph Data
function graph_data(T)
    % Get just country data
    Countries = unique(T.country);
    
    % Get the graph handle and set up for graphing
    graph = findall(groot,"Type","Axes")
    graph = graph(2);
    disp(graph)
    plot(graph,2000,0);
    hold('on');

    % Loop through countries
    for i=1:size(Countries)
        entries = T(T.country == string(Countries(i)),:);
        plot(graph,entries.year_sampled, entries.free_from_contamination)
    end

    % Build the legend and listbox entries
    hold('off');
    legend(graph,Countries);
    country_lb = findall(groot,"Tag","country_lb");
    set(country_lb,'Items',Countries);
end