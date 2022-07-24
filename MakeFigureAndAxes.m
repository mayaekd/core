%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Figure, AxesList] = MakeFigureAndAxes(FigureBackgroundColor, ...
    AxesBackgroundColor, NumVerticalTiles, NumHorizontalTiles, ...
    xBounds, yBounds)
    TotalNumAxes = NumVerticalTiles * NumHorizontalTiles;
    AxesBackgroundColorList = zeros(TotalNumAxes, 3);
    xBoundsList = zeros(TotalNumAxes, 2);
    yBoundsList = zeros(TotalNumAxes, 2);
    for a = 1:TotalNumAxes
        AxesBackgroundColorList(a,:) = AxesBackgroundColor;
        xBoundsList(a,:) = xBounds;
        yBoundsList(a,:) = yBounds;
    end
    [Figure, AxesList] = MakeFigureAndAxesSuperCustom(...
        FigureBackgroundColor, NumVerticalTiles, NumHorizontalTiles, ...
        0.02, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0, 0, 0, ...
        AxesBackgroundColorList, xBoundsList, yBoundsList);
end
