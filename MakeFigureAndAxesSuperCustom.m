%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Figure, AxesList] = MakeFigureAndAxesSuperCustom(...
    FigureBackgroundColor, NumVerticalTiles, NumHorizontalTiles, ...
    OverallTopBorder, OverallBottomBorder, ...
    OverallHorizontalBetweenBorder, OverallLeftBorder, ...
    OverallRightBorder, OverallVerticalBetweenBorder, ...
    IndividualTopBorder, IndividualBottomBorder, IndividualLeftBorder, ...
    IndividualRightBorder, AxesBackgroundColors, xBoundsList, yBoundsList)
    % The lists that are in a vector-type order will be matched to axes by
    % going left to right, top to bottom.
    Figure = figure("Color", FigureBackgroundColor);
    % Altgorithmically creating the tile axis coordinates
    OuterPositions = cell(NumVerticalTiles, NumHorizontalTiles);
    InnerPositions = cell(NumVerticalTiles, NumHorizontalTiles);
    xDistOuter = (1 - OverallLeftBorder - OverallRightBorder - ...
        (OverallVerticalBetweenBorder * (NumHorizontalTiles - 1)))...
        /NumHorizontalTiles;
    yDistOuter = (1 - OverallTopBorder - OverallBottomBorder - ...
        (OverallHorizontalBetweenBorder * (NumVerticalTiles - 1)))...
        /NumVerticalTiles;
    xDistInner = xDistOuter - IndividualLeftBorder - IndividualRightBorder;
    yDistInner = yDistOuter - IndividualTopBorder - IndividualBottomBorder;
    % Initial values for lower tiles
    yMinOuter = OverallBottomBorder;
    yMinInner = yMinOuter + IndividualBottomBorder;
    for VIndex = 1:NumVerticalTiles
        % Initial values for left tiles
        xMinOuter = OverallLeftBorder;
        xMinInner = xMinOuter + IndividualLeftBorder;
        for HIndex = 1:NumHorizontalTiles
            OuterPositions{VIndex, HIndex} = [xMinOuter yMinOuter xDistOuter yDistOuter];
            InnerPositions{VIndex, HIndex} = [xMinInner yMinInner xDistInner yDistInner];
            % Updating values for next loop
            xMinOuter = xMinOuter + xDistOuter + OverallVerticalBetweenBorder;
            xMinInner = xMinOuter + IndividualLeftBorder;
        end
        % Updating values for next loop
        yMinOuter = yMinOuter + yDistOuter + OverallHorizontalBetweenBorder;
        yMinInner = yMinOuter + IndividualBottomBorder;
    end
    AxesList = cell(NumVerticalTiles * NumHorizontalTiles, 1);
    ListIndex = 1;
    for VIndex = 1:NumVerticalTiles
        for HIndex = 1:NumHorizontalTiles
            CurrentAxes = axes(Figure, "OuterPosition", ...
                OuterPositions{NumVerticalTiles - VIndex + 1, HIndex}, ...
                "Position", ...
                InnerPositions{NumVerticalTiles - VIndex + 1, HIndex}, ...
                "Color", AxesBackgroundColors(ListIndex, :), ...
                "XTickMode", "manual", "YTickMode", "manual", ...
                "XTickLabel", {}, "YTickLabel", {}, ...
                "XLimMode", "manual", "YLimMode", "manual", ...
                "XLim", xBoundsList(ListIndex, :), ...
                "YLim", yBoundsList(ListIndex, :));
            AxesList{ListIndex, 1} = CurrentAxes;
            ListIndex = ListIndex + 1;
        end
    end
end



