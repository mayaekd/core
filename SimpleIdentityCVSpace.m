%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SimpleCVSpace

function space = SimpleIdentityCVSpace()
    spaceTransformation = SpaceTransformation(@MPTransformation);
    Clusters = MakeManyHyperCubeClusters([0 0], [1 1], [3 3], ...
        [2 15], [6 2], spaceTransformation);
    space = Space(Clusters, spaceTransformation);
end

function PCoord = MPTransformation(MCoord)
    PCoord = MCoord;
end
