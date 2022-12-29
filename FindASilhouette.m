%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ClosestSequences, ASilhouette] = FindASilhouette( ...
    SequenceVocabulary, SilhouetteVocabulary, ...
    ExemplarVocabulary, GoalExemplar, NumNeighbors)
    ExemplarDistances = nan(size(ExemplarVocabulary));
    for e = 1:length(ExemplarDistances)
        ExemplarDistances(e) = GoalExemplar.DistanceToTrajectory(ExemplarVocabulary(e));
    end
    [~, ExemplarIndices] = sort(ExemplarDistances);
    ClosestExemplarIndices = ExemplarIndices(1:NumNeighbors);
    ClosestSilhouettes = SilhouetteVocabulary(ClosestExemplarIndices);
    ClosestSequences = SequenceVocabulary(ClosestExemplarIndices, :);
    ASilhouette = CombineSilhouettes(ClosestSilhouettes);
end

% This assumes they are all the same length and they are aligned normally,
% and that all the regions are rectangles
function CombinedSilhouette = CombineSilhouettes(SilhouettesToCombine)
    NumSilhouettes = length(SilhouettesToCombine);
    % Make sure all the silhouettes have the same length
    for n = 1:NumSilhouettes - 1
        assert(length(SilhouettesToCombine(n).Regions) == length( ...
            SilhouettesToCombine(n + 1).Regions), "All of the " + ...
            "silhouettes have to have the same length (number of " + ...
            "regions), but silhouette #" + n + " has " + ...
            length(SilhouettesToCombine(n).Regions) + " regions and " + ...
            "silhouette #" + n + 1 + " has " + ...
            length(SilhouettesToCombine(n + 1).Regions) + " regions.");
    end
    NumRegions = length(SilhouettesToCombine(1).Regions);
    Regions = WeightedMotorSimplicialComplex.empty(0, NumRegions);
    % Go through each time step, n
    for n = 1:NumRegions
        RegionsToCombine = WeightedMotorSimplicialComplex.empty( ...
            0, NumSilhouettes);
        % Go through each silhouette, and add the region from silhouette s
        % at time n to the list of regions
        for s = 1:NumSilhouettes
            RegionsToCombine(s) = SilhouettesToCombine(s).Regions(n);
        end
        % Combine all the regions at time n from all the silhouettes
        Regions(n) = CombineRectangularRegions(RegionsToCombine);
    end
    CombinedSilhouette = MotorSilhouette(Regions);
end

