%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Standard Space Transformation

standardSpaceTransformation = SpaceTransformation(@MPTransformation);

function PCoord = MPTransformation(MCoord)
    xMin = 0;
    xMax = 40;
    yMin = 0;
    yMax = 40;
    a = MCoord(1,1);
    b = MCoord(2,1);
    % If the point is in the top half of the range
    if b >= (yMin + yMax)/2
        % If the point is in the right half of the range
        if a >= (xMin + xMax)/2
            % The x value is shifted left by 1/2 the width of the space
            c = a - ((xMax - xMin)/2);
            % The y value is shifted down by 1/2 the height of the space
            d = (yMin - yMax + (2 * b))/2;
            % d = (yMin - yMax)/2 + b = b - (yMax - yMin)/2
        else
        % If the point is in the left half of the range
            % The x value is shifted right by 1/2 the width of the space
            c = a + ((xMax - xMin)/2);
            % The y value is shifted down by 1/2 the height of the space
            d = (yMin - yMax + (2 * b))/2;
        end
    else
    % If the point is in the bottom half of the range
        % The x value stays the same
        c = a;
        % The y value is flipped across the horizontal line cutting the 
        % space in half
        d = yMin + yMax - b;
    end
    PCoord(1,1) = c;
    PCoord(2,1) = d;
end
