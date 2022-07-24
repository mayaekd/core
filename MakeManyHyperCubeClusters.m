%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ClusterList = MakeManyHyperCubeClusters(StartingValues, StepSizes, ...
    SideLengths, DistancesBetweenClusters, NumClustersPerSides, ...
    SpaceMPTransformation, CoordinateOptions)
    arguments
        StartingValues {mustBeNumeric}
        StepSizes {mustBeNumeric}
        SideLengths {mustBeNumeric}
        DistancesBetweenClusters {mustBeNumeric}
        NumClustersPerSides {mustBeNumeric}
        SpaceMPTransformation
        CoordinateOptions.xMotorRowIndex {mustBeNumeric} = 1
        CoordinateOptions.yMotorRowIndex {mustBeNumeric} = 2
        CoordinateOptions.zMotorRowIndex {mustBeNumeric} = nan
        CoordinateOptions.xPerceptualRowIndex {mustBeNumeric} = 1
        CoordinateOptions.yPerceptualRowIndex {mustBeNumeric} = 2
        CoordinateOptions.zPerceptualRowIndex {mustBeNumeric} = nan
    end
    NumDimensions = length(StartingValues);
    NumClusters = prod(NumClustersPerSides);
    ClusterList = Cluster.empty(0, NumClusters);
    
    % Create grids for finding the MinVector which is basically the "lower
    % left"/"minimum" corner of each cluster.  If 
    % StartingValues = [1 2 3] and
    % SideLengths = [10 20 30] and 
    % DistanceBetweenClusters = [100 200 300] and
    % NumClustersPerSide = [2 3 4], 
    % then our vectors for making the grids should be 
    % [1 111], [2 222 442], [3 333 663 993],
    % which will give us clusters that start at the following points:
    % (1, 2, 3), (111, 2, 3)
    % (1, 222, 3), (111, 222, 3)
    % (1, 442, 3), (111, 442, 3)
    % (1, 2, 333), (111, 2, 333)
    % (1, 222, 333), (111, 222, 333)
    % (1, 442, 333), (111, 442, 333)
    % (1, 2, 663), (111, 2, 663)
    % (1, 222, 663), (111, 222, 663)
    % (1, 442, 663), (111, 442, 663)
    % (1, 2, 993), (111, 2, 993)
    % (1, 222, 993), (111, 222, 993)
    % (1, 442, 993), (111, 442, 993)
    
    ClusterStartingValueVectors = cell(1, NumDimensions);
    for d = 1:NumDimensions
        StartingValue = StartingValues(d);
        SideLength = SideLengths(d);
        DistanceBetweenClusters = DistancesBetweenClusters(d);
        NumClustersPerSide = NumClustersPerSides(d);
        CurrentValue = StartingValue;

        CurrentVector = nan(NumClustersPerSide, 1);
        for c = 1:NumClustersPerSide
            CurrentVector(c) = CurrentValue;
            CurrentValue = CurrentValue + SideLength + DistanceBetweenClusters;
        end
        ClusterStartingValueVectors{d} = CurrentVector;
    end

    % Making the grids for the min values
    MinVectorGrids = cell(1, NumDimensions);
    [MinVectorGrids{:}] = ndgrid(ClusterStartingValueVectors{:});

    for clusterIndex = 1:NumClusters
        % Initial values
        MinVector = nan(1, NumDimensions);
        MaxVector = nan(1, NumDimensions);
        StepVector = nan(1, NumDimensions);
        for d = 1:NumDimensions
            MinVector(d) = MinVectorGrids{d}(clusterIndex);
            MaxVector(d) = MinVector(d) + SideLengths(d);
            StepVector(d) = StepSizes(d);
        end
        
        % Find current cluster & put in list
        CubeCluster = MakeHyperCubeCluster(MinVector, MaxVector, ...
            StepVector, SpaceMPTransformation, ...
        "xMotorRowIndex", CoordinateOptions.xMotorRowIndex, ...
        "yMotorRowIndex", CoordinateOptions.yMotorRowIndex, ...
        "zMotorRowIndex", CoordinateOptions.zMotorRowIndex, ...
        "xPerceptualRowIndex", CoordinateOptions.xPerceptualRowIndex, ...
        "yPerceptualRowIndex", CoordinateOptions.yPerceptualRowIndex, ...
        "zPerceptualRowIndex", CoordinateOptions.zPerceptualRowIndex);
        ClusterList(clusterIndex) = CubeCluster;
    end
end

function CubeCluster = MakeHyperCubeCluster(MinVector, MaxVector, ...
    StepVector, SpaceMPTransformation, CoordinateOptions)
    arguments
        MinVector {mustBeNumeric}
        MaxVector {mustBeNumeric}
        StepVector {mustBeNumeric}
        SpaceMPTransformation
        CoordinateOptions.xMotorRowIndex {mustBeNumeric} = 1
        CoordinateOptions.yMotorRowIndex {mustBeNumeric} = 2
        CoordinateOptions.zMotorRowIndex {mustBeNumeric} = nan
        CoordinateOptions.xPerceptualRowIndex {mustBeNumeric} = 1
        CoordinateOptions.yPerceptualRowIndex {mustBeNumeric} = 2
        CoordinateOptions.zPerceptualRowIndex {mustBeNumeric} = nan
    end

    assert(length(MinVector) == length(MaxVector));
    assert(length(MaxVector) == length(StepVector));
    % Finding some parameters
    NumJunctures = int64(prod((MaxVector - MinVector)./StepVector + 1));
    NumDimensions = length(MinVector);

    % Setting up to find ndgrids
    DimensionValues = cell(1, NumDimensions);
    for d = 1:NumDimensions
        CurrentDimensionValues = MinVector(d):StepVector(d):MaxVector(d);
        DimensionValues{d} = CurrentDimensionValues;
    end

    % Finding grids that will allow us to get every combination of the
    % values in each dimension
    Grids = cell(1, NumDimensions);
    [Grids{:}] = ndgrid(DimensionValues{:});

    MotorCoordinateMatrix = nan(NumDimensions, NumJunctures);
    for d = 1:NumDimensions
        MotorCoordinateMatrix(d, :) = reshape(Grids{d}, [1 numel(Grids{d})]);
    end

    % If xMotorRowIndex or yMotorRowIndex is nan, override it
    if isnan(CoordinateOptions.xMotorRowIndex)
        xMotorRowIndex = 1;
    else
        xMotorRowIndex = CoordinateOptions.xMotorRowIndex;
    end
    if isnan(CoordinateOptions.yMotorRowIndex)
        yMotorRowIndex = 2;
    else
        yMotorRowIndex = CoordinateOptions.yMotorRowIndex;
    end
    zMotorRowIndex = CoordinateOptions.zMotorRowIndex;

    % If xPerceptualRowIndex or yPerceptualRowIndex is nan, override it
    if isnan(CoordinateOptions.xPerceptualRowIndex)
        xPerceptualRowIndex = 1;
    else
        xPerceptualRowIndex = CoordinateOptions.xPerceptualRowIndex;
    end
    if isnan(CoordinateOptions.yPerceptualRowIndex)
        yPerceptualRowIndex = 2;
    else
        yPerceptualRowIndex = CoordinateOptions.yPerceptualRowIndex;
    end
    zPerceptualRowIndex = CoordinateOptions.zPerceptualRowIndex;

    CubeCluster = SpaceMPTransformation.CreateCluster( ...
        MotorCoordinateMatrix, ...
        "xMotorRowIndex", xMotorRowIndex, ...
        "yMotorRowIndex", yMotorRowIndex, ...
        "zMotorRowIndex", zMotorRowIndex, ...
        "xPerceptualRowIndex", xPerceptualRowIndex, ...
        "yPerceptualRowIndex", yPerceptualRowIndex, ...
        "zPerceptualRowIndex", zPerceptualRowIndex);
end
