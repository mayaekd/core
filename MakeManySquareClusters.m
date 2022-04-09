%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ClusterList = MakeManySquareClusters(xStart_h, StepSize_h, ...
    SideLength_h, DistanceBetweenClusters_h, NumClustersPerSide_h, ...
    yStart_v, StepSize_v, SideLength_v, DistanceBetweenClusters_v, ...
    NumClustersPerSide_v, ...
    SpaceMPTransformation)
    ClusterList = cell(NumClustersPerSide_h*NumClustersPerSide_v,1);
    ClusterIndex = 1;
    yMin = yStart_v;
    yMax = yStart_v + SideLength_v;
    yStep = StepSize_v;
    for w = 1:NumClustersPerSide_v
        xMin = xStart_h;
        xMax = xStart_h + SideLength_h;
        xStep = StepSize_h;
        for h = 1:NumClustersPerSide_h
            CurrentCluster = MakeSquareCluster(xMin, xMax, yMin, yMax, ...
                xStep, yStep, SpaceMPTransformation);
            ClusterList{ClusterIndex, 1} = CurrentCluster;
            xMin = xMax + DistanceBetweenClusters_h;
            xMax = xMin + SideLength_h;
            ClusterIndex = ClusterIndex + 1;
        end
        yMin = yMax + DistanceBetweenClusters_v;
        yMax = yMin + SideLength_v;
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