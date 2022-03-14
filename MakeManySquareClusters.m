%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ClusterList = MakeManySquareClusters(xStart, yStart, ...
    StepSize, SideLength, DistanceBetweenClusters, NumClustersPerSide, ...
    SpaceMPTransformation)
    ClusterList = cell(NumClustersPerSide^2,1);
    ClusterIndex = 1;
    yMin = yStart;
    yMax = yStart + SideLength;
    yStep = StepSize;
    for w = 1:NumClustersPerSide
        xMin = xStart;
        xMax = xStart + SideLength;
        xStep = StepSize;
        for h = 1:NumClustersPerSide
            CurrentCluster = MakeSquareCluster(xMin, xMax, yMin, yMax, ...
                xStep, yStep, SpaceMPTransformation);
            ClusterList{ClusterIndex, 1} = CurrentCluster;
            xMin = xMax + DistanceBetweenClusters;
            xMax = xMin + SideLength;
            ClusterIndex = ClusterIndex + 1;
        end
        yMin = yMax + DistanceBetweenClusters;
        yMax = yMin + SideLength;
    end
end

function SquareCluster = MakeSquareCluster(xMin, xMax, yMin, yMax, xStep, yStep, SpaceMPTransformation)
    NumJunctures = int64(((xMax - xMin)/xStep + 1)*((yMax - yMin)/yStep + 1));
    ListOfJunctures = cell(NumJunctures,1);
    JunctureIndex = 1;
    for x = xMin:xStep:xMax
        for y = yMin:yStep:yMax
            Coordinates = [x; y];
            MPoint = MotorPoint(Coordinates);
            CurrentJuncture = MPoint.MakeJuncture(SpaceMPTransformation);
            ListOfJunctures{JunctureIndex, 1} = CurrentJuncture;
            JunctureIndex = JunctureIndex + 1;
        end
    end
    SquareCluster = Cluster(ListOfJunctures);
end