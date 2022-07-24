%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Figure, AxesList] = MakeFigureAndAxes3D(FigureBackgroundColor, ...
    AxesBackgroundColor, NumVerticalTiles, NumHorizontalTiles, ...
    xBounds, yBounds, zBounds, GridOnOff, Projection)
    TotalNumAxes = NumVerticalTiles * NumHorizontalTiles;
    AxesBackgroundColorList = zeros(TotalNumAxes, 3);
    xBoundsList = zeros(TotalNumAxes, 2);
    yBoundsList = zeros(TotalNumAxes, 2);
    zBoundsList = zeros(TotalNumAxes, 2);
    for a = 1:TotalNumAxes
        AxesBackgroundColorList(a,:) = AxesBackgroundColor;
        xBoundsList(a,:) = xBounds;
        yBoundsList(a,:) = yBounds;
        zBoundsList(a,:) = zBounds;
    end

    xPosition = max(xBoundsList, [], "all") + (1.5 * (max(xBoundsList, [], "all") - min(xBoundsList, [], "all")));
    yPosition = max(yBoundsList, [], "all") + (1.5 * (max(yBoundsList, [], "all") - min(yBoundsList, [], "all")));
    zPosition = mean(zBoundsList, "all") + (0.8 * (max(zBoundsList, [], "all") - min(zBoundsList, [], "all")));
    
    CameraPosition = [xPosition yPosition zPosition];
    CameraFocalPoint = [mean(xBoundsList, "all") mean(yBoundsList, "all") mean(zBoundsList, "all")];

    [Figure, AxesList] = MakeFigureAndAxesSuperCustom3D(...
        FigureBackgroundColor, NumVerticalTiles, NumHorizontalTiles, ...
        0.02, 0.01, 0.01, 0.01, 0.01, 0.01, 0.01, 0, 0, 0, ...
        AxesBackgroundColorList, xBoundsList, yBoundsList, zBoundsList, ...
        GridOnOff, Projection, CameraPosition, CameraFocalPoint);
end
