function [PointA, PointB, PointC, PointD, PointE, PointF, ...
    PointG, PointH, OuterPointSequence, ...
    UpperRightValues, UpperLeftValues, LowerRightValues, LowerLeftValues, ...
    CIndex, EIndex, GIndex, LastIndex] = FindOuterPointSequence( ...
    RegionsToCombine)
    NumRegions = length(RegionsToCombine);
    UpperRightValues = nan(2, NumRegions);
    UpperLeftValues = nan(2, NumRegions);
    LowerRightValues = nan(2, NumRegions);
    LowerLeftValues = nan(2, NumRegions);
    %          A     B
    %      H                C
    %
    %
    %      G
    %                       D
    %
    %             F    E

    % Giving initial values for these points -- setting them as the four 
    % corners of the first region
    PointA = [min(RegionsToCombine(1).MotorVertexList(:, 1)); max(RegionsToCombine(1).MotorVertexList(:, 2))];
    PointB = [max(RegionsToCombine(1).MotorVertexList(:, 1)); max(RegionsToCombine(1).MotorVertexList(:, 2))];
    PointC = [max(RegionsToCombine(1).MotorVertexList(:, 1)); max(RegionsToCombine(1).MotorVertexList(:, 2))];
    PointD = [max(RegionsToCombine(1).MotorVertexList(:, 1)); min(RegionsToCombine(1).MotorVertexList(:, 2))];
    PointE = [max(RegionsToCombine(1).MotorVertexList(:, 1)); min(RegionsToCombine(1).MotorVertexList(:, 2))];
    PointF = [min(RegionsToCombine(1).MotorVertexList(:, 1)); min(RegionsToCombine(1).MotorVertexList(:, 2))];
    PointG = [min(RegionsToCombine(1).MotorVertexList(:, 1)); min(RegionsToCombine(1).MotorVertexList(:, 2))];
    PointH = [min(RegionsToCombine(1).MotorVertexList(:, 1)); max(RegionsToCombine(1).MotorVertexList(:, 2))];
    for n = 1:NumRegions
        % Points for the current region
        PointMatrix = RegionsToCombine(n).MotorVertexList;
        assert(all(size(PointMatrix) == [4 2]), "The MotorVertexList for the current region should contain 4 points of dimension 2, but it contains " + size(PointMatrix, 1) + " points of dimension " + size(PointMatrix, 2));
        CurrentUpperRight = [max(PointMatrix(:, 1)); max(PointMatrix(:, 2))];
        CurrentUpperLeft = [min(PointMatrix(:, 1)); max(PointMatrix(:, 2))];
        CurrentLowerRight = [max(PointMatrix(:, 1)); min(PointMatrix(:, 2))];
        CurrentLowerLeft = [min(PointMatrix(:, 1)); min(PointMatrix(:, 2))];
        UpperRightValues(:, n) = CurrentUpperRight;
        UpperLeftValues(:, n) = CurrentUpperLeft;
        LowerRightValues(:, n) = CurrentLowerRight;
        LowerLeftValues(:, n) = CurrentLowerLeft;
        % If CurrentUpperLeft is above PointA
        if CurrentUpperLeft(2) > PointA(2)
            PointA = CurrentUpperLeft;
            PointB = CurrentUpperRight;
        % If CurrentUpperLeft is the same height as PointA
        elseif CurrentUpperLeft(2) == PointA(2)
            PointA = [min(CurrentUpperLeft(1), PointA(1)); CurrentUpperLeft(2)];
            PointB = [max(CurrentUpperRight(1), PointB(1)); CurrentUpperRight(2)];
        end
        % If CurrentUpperRight is to the right of PointC
        if CurrentUpperRight(1) > PointC(1)
            PointC = CurrentUpperRight;
            PointD = CurrentLowerRight;
        % If CurrentUpperRight lies on the same vertical line as PointC
        elseif CurrentUpperRight(1) == PointC(1)
            PointC = [CurrentUpperRight(1); max(CurrentUpperRight(2), PointC(2))];
            PointD = [CurrentLowerRight(1); min(CurrentLowerRight(2), PointD(2))];
        end
        % If CurrentLowerRight is below PointE
        if CurrentLowerRight(2) < PointE(2)
            PointE = CurrentLowerRight;
            PointF = CurrentLowerLeft;
        % If CurrentLowerRight is the same height as PointE
        elseif CurrentLowerRight(2) == PointE(2)
            PointE = [max(CurrentLowerRight(1), PointE(1)); CurrentLowerRight(2)];
            PointF = [min(CurrentLowerLeft(1), PointF(1)); CurrentLowerLeft(2)];
        end
        % If CurrentLowerLeft is to the left of PointG
        if CurrentLowerLeft(1) < PointG(1)
            PointG = CurrentLowerLeft;
            PointH = CurrentUpperLeft;
        % If CurrentLowerLeft lies on the same vertical line as PointG
        elseif CurrentLowerLeft(1) == PointG(1)
            PointG = [CurrentLowerLeft(1); min(CurrentLowerLeft(2), PointG(2))];
            PointH = [CurrentUpperLeft(1); max(CurrentUpperLeft(2), PointH(2))];
        end
    end
    %% TO DO: I've replaced A, B, C, ... and now I need to build the 
    % outside of the convex hull by placing the points in between them
    % Find the upper right points between B and C, in order from left
    % to right (or it could be up to down....I think I'll do left to
    % right).  They only need to be included if they rise above
    % the...highest line connecting the others...?  Go from left to
    % right and if the point is above the current line emanating from
    % C, then make it be the new endpoint of the line emanating from C.
    %% Upper right
    % So we start with the line B-C.
    OuterPointSequence = [PointA PointB]; % A to B
    % If B and C aren't the same...
    if PointB ~= PointC
        % Find the line going from B to C
        VectorToC = PointC - PointB;

        % Find the upper right points between B and C going left to right, 
        % not including B and C
        PointsLeftToRightAll = sort(UpperRightValues, 2);
        PointsLeftToRight = PointsLeftToRightAll(:, 2:length(PointsLeftToRightAll) - 1);

        % Go through all the points between B and C
        for p = 1:size(PointsLeftToRight, 2)
            % Upper right point that is furthest left, other than B
            NextPoint = PointsLeftToRight(:, p); 
            % Find the line going from the new point to C
            NewVectorToC = PointC - NextPoint;
            % If it's vertical, stop the process
            if NewVectorToC(1) == 0
                break
            end
            
            % Find the slopes of the old line and the new line, which will
            % be compared
            SlopeOfLineToC = VectorToC(2)/VectorToC(1);
            NewSlopeOfLineToC = NewVectorToC(2)/NewVectorToC(1);

            % If the new line is steeper (slope is more negative) than
            % the current line, then the new point is added
            if NewSlopeOfLineToC < SlopeOfLineToC
                VectorToC = NewVectorToC;
                OuterPointSequence = [OuterPointSequence NextPoint]; % A to B to ?
            end
        end
        OuterPointSequence = [OuterPointSequence PointC]; % Add PointC only if it's not the same as PointB
    end
    CIndex = size(OuterPointSequence, 2);
    %% Lower right
    OuterPointSequence = [OuterPointSequence PointD]; % Add PointD
    if PointE ~= PointD
        % Find the line going from D to E
        VectorToE = PointE - PointD;

        % Find the lower right points between D and E going from right to
        % left, not including D and E
        PointsRightToLeftAll = sort(LowerRightValues, 2, "descend");
        PointsRightToLeft = PointsRightToLeftAll(:, 2:length(PointsRightToLeftAll) - 1);

        % Go through all the points between D and E
        for p = 1:size(PointsRightToLeft, 2)
            % Lower right point that is furthest right, other than D
            NextPoint = PointsRightToLeft(:, p);
            % Find the line going from the new point to E
            NewVectorToE = PointE - NextPoint;
            % If it's vertical, stop the process
            if NewVectorToE(1) == 0
                break
            end
            % Find the slopes of the old line and the new line, which will
            % be compared
            SlopeOfLineToE = VectorToE(2)/VectorToE(1);
            NewSlopeOfLineToE = NewVectorToE(2)/NewVectorToE(1);

            % If the new line is less steep (smaller slope) than
            % the current line, then the new point is added
            if NewSlopeOfLineToE < SlopeOfLineToE
                VectorToE = NewVectorToE;
                OuterPointSequence = [OuterPointSequence NextPoint];
            end
        end
        OuterPointSequence = [OuterPointSequence PointE]; % Add PointE only if it's not the same as PointD
    end
    EIndex = size(OuterPointSequence, 2);
    %% Lower left
    OuterPointSequence = [OuterPointSequence PointF]; % Add PointF
    if PointG ~= PointF
        % Find the line going from F to G
        VectorToG = PointG - PointF;

        % Find the lower left points between F and G going from right to
        % left, not including F and G
        PointsRightToLeftAll = sort(LowerLeftValues, 2, "descend");
        PointsRightToLeft = PointsRightToLeftAll(:, 2:length(PointsRightToLeftAll) - 1);

        % Go through all the points between F and G
        for p = 1:size(PointsRightToLeft, 2)
            % Lower left point that is furthest right other than F
            NextPoint = PointsRightToLeft(:, p);
            % Find the line going from the new point to G
            NewVectorToG = PointG - NextPoint;
            % If it's vertical, stop the process
            if NewVectorToG(1) == 0
                break
            end

            % Find the slopes of the old line and the new line, which will
            % be compared
            SlopeOfLineToG = VectorToG(2)/VectorToG(1);
            NewSlopeOfLineToG = NewVectorToG(2)/NewVectorToG(1);
            % If the new line is steeper (slope is more negative) than
            % the current line, then the new point is added
            if NewSlopeOfLineToG < SlopeOfLineToG
                VectorToG = NewVectorToG;
                OuterPointSequence = [OuterPointSequence NextPoint];
            end
        end
        OuterPointSequence = [OuterPointSequence PointG]; % Add PointG only if it's not the same as PointF
    end
    GIndex = size(OuterPointSequence, 2);
    %% Upper left
    if PointH ~= PointA
        % Add PointH only if it's not the same as PointA
        OuterPointSequence = [OuterPointSequence PointH];
        % Find the line going from H to A
        VectorToA = PointA - PointH;

        % Find the upper left points between H and H going from left to
        % right, not including H and A
        PointsLeftToRightAll = sort(UpperLeftValues, 2);
        PointsLeftToRight = PointsLeftToRightAll(:, 2:length(PointsLeftToRightAll) - 1);

        % Go through all the points between H and A
        for p = 1:size(PointsLeftToRight, 2)
            % Upper left point that is furthest left, other than H
            NextPoint = PointsLeftToRight(:, p);
            % Find the line going from the new point to A
            NewVectorToA = PointA - NextPoint;
            % If it's vertical, stop the process
            if NewVectorToA(1) == 0
                break
            end

            % Find the slopes of the old line and the new line, which will
            % be compared
            SlopeOfLineToA = VectorToA(2)/VectorToA(1);
            NewSlopeOfLineToA = NewVectorToA(2)/NewVectorToA(1);
            % If the new line is less steep (smaller slope) than
            % the current line, then the new point is added
            if NewSlopeOfLineToA < SlopeOfLineToA
                VectorToA = NewVectorToA;
                OuterPointSequence = [OuterPointSequence NextPoint];
            end
        end
    end
    LastIndex = size(OuterPointSequence, 2);
end
