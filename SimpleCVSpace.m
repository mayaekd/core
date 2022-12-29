%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SimpleCVSpace

function space = SimpleCVSpace()
    spaceTransformation = SpaceTransformation(@MPTransformation);
    Clusters = MakeManyHyperCubeClusters([0 0], [1 1], [3 3], ...
        [2 15], [6 2], spaceTransformation);
    space = Space(Clusters, spaceTransformation);
end

function PCoord = MPTransformation(MCoord)
    % If it's a consonant
    if MCoord(2) < 10.5
        if MCoord(1) < 10
            PCoord = [10; 0] + MCoord;
        elseif MCoord(1) < 20
            PCoord = [-10; 0] + MCoord;
        else
            PCoord = MCoord;
        end
    % Otherwise, it's a vowel
    else
        if MCoord(1) < 10
            PCoord = [20; 0] + MCoord;
        elseif MCoord(1) < 20
            PCoord = [-10; 0] + MCoord;
        else
            PCoord = [-10; 0] + MCoord;
        end
    end
end
