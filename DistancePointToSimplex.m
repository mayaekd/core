%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FUNCTION LIST
%  DistancePointToSimplex
%  DistanceOriginToSimplex

%% FUNCTIONS

function SmallestDistance = DistancePointToSimplex(Point, SimplexVertices)
    SmallestDistance = DistanceOriginToSimplex(SimplexVertices - Point);
end

function SmallestDistance = DistanceOriginToSimplex(SimplexVertices)
    % Vertex coordinates are stacked
    [NumVertices, SpaceDimension] = size(SimplexVertices);
    assert(NumVertices <= SpaceDimension + 1)
    % The number of vertices of the highest dimension simplices we'll try
    % MaxNumVertices = min(NumVertices, SpaceDimension);
    MaxNumVertices = NumVertices;
    AllDistances = nan(1, 2^NumVertices - 1);
    DistanceIndex = 1;
    % n is the number of vertices
    for n = MaxNumVertices:-1:1
        % All possible combinations of n vertices from the set of all the
        % vertices (given by their indices here)
        VertexCombinations = nchoosek(1:NumVertices, n);
        for vc = 1:size(VertexCombinations, 1)
            VertexCombination = VertexCombinations(vc, :);
            VertexSet = SimplexVertices(VertexCombination, :);
            
            if (n == 1)
                Distance = norm(VertexSet(1,:));
                AllDistances(DistanceIndex) = Distance;
            else
                PointToReach = - VertexSet(1,:);
                LinIndSet = VertexSet(2:size(VertexSet,1),:) + PointToReach;
                OrthogonalSpace = null(LinIndSet);
                CoeffsInOrthogSpace = PointToReach * OrthogonalSpace; % Is this the same as the dot product?
                ComponentInOrthogSpace = OrthogonalSpace * transpose(CoeffsInOrthogSpace); 
                PointInNPlane = transpose(PointToReach) - ComponentInOrthogSpace;
                PointInNPlaneInBasis = transpose(PointInNPlane)/LinIndSet;
        
                CheckedPointInNPlaneShifted = (PointInNPlaneInBasis * LinIndSet);
                CheckedPointInNPlane = CheckedPointInNPlaneShifted - PointToReach;
                ExpectedOrigin = CheckedPointInNPlane + transpose(ComponentInOrthogSpace);
                assert(max(ExpectedOrigin) < 0.000001);
                NormalToSimplex = (min(PointInNPlaneInBasis) >= 0) && ...
                    (sum(PointInNPlaneInBasis) <= 1);
                if NormalToSimplex
                    Distance = norm(CheckedPointInNPlane);
                    if (Distance == 0)
                        SmallestDistance = 0;
                        return;
                    end
                    AllDistances(DistanceIndex) = Distance;
                end
            end
            DistanceIndex = DistanceIndex + 1;
        end
    end
    % disp(AllDistances)
    SmallestDistance = min(AllDistances);
end