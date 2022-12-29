function CombinedRegion = CombineRectangularRegions(RegionsToCombine)
    NumRegions = length(RegionsToCombine);
    % Making sure we're rounding to the same number of digits
    for n = 1:NumRegions - 1
        assert(RegionsToCombine(n).DigitsToRoundTo == RegionsToCombine(n + 1).DigitsToRoundTo, "The digits to round to have to be the same for the various regions but they are not equal")
    end
    DigitsToRoundTo = RegionsToCombine(1).DigitsToRoundTo;
    xValuesAll = nan(1, 4 * NumRegions);
    yValuesAll = nan(1, 4 * NumRegions);
    for n = 1:NumRegions
        PointMatrix = RegionsToCombine(n).MotorVertexList;
        StartIndex = 4 * n - 3;
        EndIndex = 4 * n;
        xValuesAll(StartIndex:EndIndex) = [PointMatrix(:, 1)];
        yValuesAll(StartIndex:EndIndex) = [PointMatrix(:, 2)];
    end
    xValues = unique(round(xValuesAll, DigitsToRoundTo), "sorted");
    yValues = unique(round(yValuesAll, DigitsToRoundTo), "sorted");
    [PointA, PointB, PointC, PointD, PointE, PointF, PointG, PointH, ...
        OuterPointSequence, ...
        UpperRight, UpperLeft, LowerRight, LowerLeft, ...
        CIndex, EIndex, GIndex, LastIndex] = FindOuterPointSequence( ...
        RegionsToCombine);
    %% MOTOR VERTEX LIST
    % Now need to find all the points that go in the MotorVertexList; and 
    % we'll organize them in such a way that it's not too hard to figure 
    % out what the SimplexMatrix is based on the organization/order.  Then
    % We'll have to find the weights.
    LeftBorderPoints = [OuterPointSequence(:, EIndex + 1:LastIndex) ...
        OuterPointSequence(:, 1)];
    RightBorderPoints = flip(OuterPointSequence(:, 2:EIndex), 2);
    LeftBorderPointsExpanded = transpose(interp1(LeftBorderPoints(2, :), transpose(LeftBorderPoints), yValues));
    RightBorderPointsExpanded = transpose(interp1(RightBorderPoints(2, :), transpose(RightBorderPoints), yValues));
    FinalXValues = unique(round([LeftBorderPointsExpanded(1, :) xValues RightBorderPointsExpanded(1, :)], DigitsToRoundTo), "sorted");
    LowerBorderPoints = flip(OuterPointSequence(:, CIndex + 1:GIndex), 2);
    UpperBorderPoints = [OuterPointSequence(:, GIndex + 1:LastIndex) ...
        OuterPointSequence(:, 1:CIndex)];
    LowerBorderPointsExpanded = round(transpose(interp1(LowerBorderPoints(1, :), transpose(LowerBorderPoints), FinalXValues)), DigitsToRoundTo);
    UpperBorderPointsExpanded = round(transpose(interp1(UpperBorderPoints(1, :), transpose(UpperBorderPoints), FinalXValues)), DigitsToRoundTo);
    FinalYValues = unique(round([LowerBorderPointsExpanded(2, :) yValues UpperBorderPointsExpanded(2, :)], DigitsToRoundTo), "sorted");
    SizesOfVerticalLines = nan(size(FinalXValues));
    % There will be a triangle below between points F and G, no
    % triangle below between points E and F, and a triangle below
    % between points D and E.
    % There will be a triangle above between points H and A, no
    % triangle above between points A and B, and a triangle above
    % between points B and C
    MotorVertexList = [];
    % For each x value, we want to go from the lowest y value to the
    % highest y value, but such that those y values are between the lower
    % border and the upper border at the given x value
    for xIndex = 1:length(FinalXValues)
        % Lowest y value for the given x value is added
        AdditionalVertices = round([FinalXValues(xIndex); LowerBorderPointsExpanded(2, xIndex)], DigitsToRoundTo);
        yIndex = 1;
        % All the in between values for y, given the x value
        while FinalYValues(yIndex) < UpperBorderPointsExpanded(2, xIndex)
            if FinalYValues(yIndex) > LowerBorderPointsExpanded(2, xIndex)
                assert(any([FinalXValues(xIndex); FinalYValues(yIndex)] ~= AdditionalVertices(:, size(AdditionalVertices, 2))), "There is a repeat point in the MotorVertexMatrix -- this shouldn't happen, check the code")
                AdditionalVertices = [AdditionalVertices [FinalXValues(xIndex); FinalYValues(yIndex)]];
            end
            yIndex = yIndex + 1;
        end
        % The biggest value for y, given the x value
        assert(any([FinalXValues(xIndex); UpperBorderPointsExpanded(2, xIndex)] ~= AdditionalVertices(:, size(AdditionalVertices, 2))), "There is a repeat point in the MotorVertexMatrix -- this shouldn't happen, check the code")
        AdditionalVertices = [AdditionalVertices [FinalXValues(xIndex); UpperBorderPointsExpanded(2, xIndex)]];
        if ~isempty(MotorVertexList) 
            assert(any(MotorVertexList(:, size(MotorVertexList, 2)) ~= AdditionalVertices(:, 1)), "There is a repeat point in the MotorVertexMatrix -- this shouldn't happen, check the code")
        end
        MotorVertexList = [MotorVertexList AdditionalVertices];
        SizesOfVerticalLines(xIndex) = size(AdditionalVertices, 2);
    end
    MotorVertexList = transpose(round(MotorVertexList, DigitsToRoundTo));

    %% SIMPLEX MATRIX
    SimplexMatrix = [];
    MinPointLeftIndex = 1;
    for vLine = 1:length(SizesOfVerticalLines) - 1
        MaxPointLeftIndex = MinPointLeftIndex + SizesOfVerticalLines(vLine) - 1;
        MinPointRightIndex = MaxPointLeftIndex + 1;
        MaxPointRightIndex = MinPointRightIndex + SizesOfVerticalLines(vLine + 1) - 1;
% 
%         % The bounds of this vertical column
%         MinPointLeftX = MotorVertexList(MinPointLeftIndex, 1);
%         MaxPointLeftX = MotorVertexList(MaxPointLeftIndex, 1);
%         MinPointRightX = MotorVertexList(MinPointRightIndex, 1);
%         MaxPointRightX = MotorVertexList(MaxPointRightIndex, 1);

        MinRectangleLeftIndex = MinPointLeftIndex;
        MaxRectangleLeftIndex = MaxPointLeftIndex;
        MinRectangleRightIndex = MinPointRightIndex;
        MaxRectangleRightIndex = MaxPointRightIndex;

        while MotorVertexList(MinRectangleLeftIndex, 2) ~= MotorVertexList(MinRectangleRightIndex, 2)
            if MotorVertexList(MinRectangleLeftIndex, 2) > MotorVertexList(MinRectangleRightIndex, 2)
                % The left min is above the right min
                MinRectangleRightIndex = MinRectangleRightIndex + 1;
            else
                % The right min is above the left min
                MinRectangleLeftIndex = MinRectangleLeftIndex + 1;
            end
        end

        while MotorVertexList(MaxRectangleLeftIndex, 2) ~= MotorVertexList(MaxRectangleRightIndex, 2)
            if MotorVertexList(MaxRectangleLeftIndex, 2) > MotorVertexList(MaxRectangleRightIndex, 2)
                % The left max is above the right max
                MaxRectangleLeftIndex = MaxRectangleLeftIndex - 1;
            else
                % The right max is above the left max
                MaxRectangleRightIndex = MaxRectangleRightIndex - 1;
            end
        end
        assert(MaxRectangleLeftIndex - MinRectangleLeftIndex == MaxRectangleRightIndex - MinRectangleRightIndex, "Something has gone wrong and the left column and right column heights of the rectangles don't match each other -- check the code because this will cause problems")
        ColumnHeight = MaxRectangleLeftIndex - MinRectangleLeftIndex;

        LLIndex = MinPointLeftIndex;
        LRIndex = MinPointRightIndex;
        if MinPointRightIndex < MinRectangleRightIndex
            % Then there is a triangle below on the left half of the shape
            SimplexMatrix = [SimplexMatrix; LLIndex LRIndex MinRectangleRightIndex];
            LRIndex = MinRectangleRightIndex;
        elseif MinPointLeftIndex < MinRectangleLeftIndex
            % Then there is a triangle below on the right half of the shape
            SimplexMatrix = [SimplexMatrix; MinRectangleLeftIndex LLIndex LRIndex];
            LLIndex = MinRectangleLeftIndex;
        end

        % Doing the rectangles
        for row = 1:ColumnHeight
            SimplexMatrix = [SimplexMatrix; LLIndex LRIndex LRIndex + 1; LLIndex + 1 LLIndex LRIndex + 1];
            LLIndex = LLIndex + 1;
            LRIndex = LRIndex + 1;
        end

        assert(MaxRectangleRightIndex == LRIndex, "We're not at the right place in the iteration -- something has gone wrong")
        assert(MaxRectangleLeftIndex == LLIndex, "We're not at the right place in the iteration -- something has gone wrong")

        % Doing upper triangle if applicable
        if MaxPointRightIndex > MaxRectangleRightIndex
            % Then there is a triangle above on the left half of the shape
            SimplexMatrix = [SimplexMatrix; LLIndex LRIndex MaxPointRightIndex];
        elseif MaxPointLeftIndex > MaxRectangleLeftIndex
            % Then there is a triangle above on the right half of the shape
            SimplexMatrix = [SimplexMatrix; MaxPointLeftIndex LLIndex LRIndex];
        end

        % Incrementing for next loop
        MinPointLeftIndex = MinPointRightIndex;
    end

    %% WEIGHTS
    NumSimplices = size(SimplexMatrix, 1);
    Weights = zeros(1, NumSimplices);
    for s = 1:NumSimplices
        for r = 1:NumRegions
            RegionLowerLeft = transpose(LowerLeft(:, r));
            RegionUpperRight = transpose(UpperRight(:, r));
            % The vertices of the current simplex
            Point1 = MotorVertexList(SimplexMatrix(s, 1), :);
            Point2 = MotorVertexList(SimplexMatrix(s, 2), :);
            Point3 = MotorVertexList(SimplexMatrix(s, 3), :);
            % This is a point in the middle of this simplex
            CentralPoint = (Point1 + Point2 + Point3)/3;
            if (all(CentralPoint >= RegionLowerLeft) && all(CentralPoint <= RegionUpperRight))
                % If the selected point is in this region, 1 gets added to
                % the weight
                Weights(s) = Weights(s) + 1;
            end
        end
    end
    Weights = max(Weights, ones(size(Weights)));
    CombinedRegion = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights);
end

