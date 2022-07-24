%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FUNCTION LIST
%  DoSimplicesIntersect

%% FUNCTIONS

function TrueOrFalse = DoSimplicesIntersect(SharedVertices, VertexA, VertexB)
    % The assumption here is that the two simplices are made up of 1.
    % SharedVertices and VertexA; 2. SharedVertices and VertexB
    % Can only do right now when SharedVertices has 1, 2, or 3 vertices.
    assert(size(SharedVertices, 1) <= 3)
    ShiftedSharedVertices = SharedVertices - SharedVertices(1,:);
    ShiftedVertexA = VertexA - SharedVertices(1,:);
    ShiftedVertexB = VertexB - SharedVertices(1,:);
    LinIndSet = ShiftedSharedVertices(2:size(ShiftedSharedVertices,1),:);
    OrthogonalSpace = null(LinIndSet);
    CoeffsInOrthogSpaceA = ShiftedVertexA * OrthogonalSpace;
    CoeffsInOrthogSpaceB = ShiftedVertexB * OrthogonalSpace;
    
    % Doing a sanity check
    OriginalDistance = sqrt(sum((VertexA - VertexB).^2));
    OrthogSpaceDistance = sqrt(sum((CoeffsInOrthogSpaceA - CoeffsInOrthogSpaceB).^2));
    assert(round(OriginalDistance, 4) >= round(OrthogSpaceDistance, 4));

    DotProduct = dot(CoeffsInOrthogSpaceA, CoeffsInOrthogSpaceB);
    if (DotProduct > 0)
        TrueOrFalse = true;
    else
        TrueOrFalse = false;
    end
end