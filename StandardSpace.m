%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Standard Space
StandardSpaceTransformation;
CurrentSpaceTransformation = standardSpaceTransformation;
MaxDistanceWithActivation = 10;

MotorBounds = [0 40; 0 40];

Cluster1 = MakeSquareCluster(2, 8, 2, 8, 2, 2, CurrentSpaceTransformation);
Cluster2 = MakeSquareCluster(12, 18, 2, 8, 2, 2, CurrentSpaceTransformation);
Cluster3 = MakeSquareCluster(22, 28, 2, 8, 2, 2, CurrentSpaceTransformation);
Cluster4 = MakeSquareCluster(32, 38, 2, 8, 2, 2, CurrentSpaceTransformation);

Cluster5 = MakeSquareCluster(2, 8, 12, 18, 2, 2, CurrentSpaceTransformation);
Cluster6 = MakeSquareCluster(12, 18, 12, 18, 2, 2, CurrentSpaceTransformation);
Cluster7 = MakeSquareCluster(22, 28, 12, 18, 2, 2, CurrentSpaceTransformation);
Cluster8 = MakeSquareCluster(32, 38, 12, 18, 2, 2, CurrentSpaceTransformation);

Cluster9 = MakeSquareCluster(2, 8, 22, 28, 2, 2, CurrentSpaceTransformation);
Cluster10 = MakeSquareCluster(12, 18, 22, 28, 2, 2, CurrentSpaceTransformation);
Cluster11 = MakeSquareCluster(22, 28, 22, 28, 2, 2, CurrentSpaceTransformation);
Cluster12 = MakeSquareCluster(32, 38, 22, 28, 2, 2, CurrentSpaceTransformation);

Cluster13 = MakeSquareCluster(2, 8, 32, 38, 2, 2, CurrentSpaceTransformation);
Cluster14 = MakeSquareCluster(12, 18, 32, 38, 2, 2, CurrentSpaceTransformation);
Cluster15 = MakeSquareCluster(22, 28, 32, 38, 2, 2, CurrentSpaceTransformation);
Cluster16 = MakeSquareCluster(32, 38, 32, 38, 2, 2, CurrentSpaceTransformation);

ClusterArray = {Cluster1; Cluster2; Cluster3; Cluster4; Cluster5; ...
    Cluster6; Cluster7; Cluster8; Cluster9; Cluster10; Cluster11; ...
    Cluster12; Cluster13; Cluster14; Cluster15; Cluster16};

standardSpace = Space(ClusterArray, CurrentSpaceTransformation, ...
    MotorBounds, MaxDistanceWithActivation);


function SquareCluster = MakeSquareCluster(xMin, xMax, yMin, yMax, xStep, yStep, SpaceMPTransformation)
    NumJunctures = ((xMax - xMin)/xStep + 1)*((yMax - yMin)/yStep + 1);
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
