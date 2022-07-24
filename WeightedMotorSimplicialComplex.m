%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS
%
%  WeightedMotorSimplicialComplex
%
%  CONTAINMENT
%  Contains
%
%  DISTANCES
%  DistancesToCoordinates
%
%  ACTIVATION
%  ActivationOfMotorMatrix
%  DistanceToActivationFunction
%
%  EXPAND REGION
%  Expand
%  AddPointToSimplicialComplex
%
%  PLOTTINGINFO
%  PlottingInfo

classdef WeightedMotorSimplicialComplex
    properties
        MotorVertexList;
        SimplexMatrix;
        Weights;
        NumSimplices;
        SpaceDimension;
        SimplexDimension;
        Full;
        BoundaryFaceList;
        DigitsToRoundTo;
    end
    methods
        % Creating an object
        function obj = WeightedMotorSimplicialComplex(MotorVertexList, SimplexMatrix, Weights)
            assert(size(Weights, 1) == 1);
            obj.DigitsToRoundTo = 4;
            obj.MotorVertexList = round(MotorVertexList, obj.DigitsToRoundTo);
            obj.SimplexMatrix = SimplexMatrix;
            obj.Weights = Weights;
            obj.NumSimplices = length(Weights);
            obj.SimplexDimension = rank(MotorVertexList - MotorVertexList(1,:));
            obj.SpaceDimension = size(MotorVertexList, 2);
            % Is the object of max dimension
            obj.Full = (obj.SimplexDimension == obj.SpaceDimension);
%             if obj.Full
%                 obj.BoundaryFaceSize = obj.SimplexDimension - 1;
%             else
%                 obj.BoundaryFaceSize = obj.SimplexDimension;
%             end
%             obj.MaxOverlapNonBoundary = 1;
            % If the object is of max dimension
            if obj.Full
                AllIndexListWithRepeats = [];
                for s = 1:size(SimplexMatrix, 1)
                    AllMotorVertexIndices = SimplexMatrix(s, :);
                    for ov = 1:length(AllMotorVertexIndices)
                        if ov == 1
                            IndexSubset = (ov + 1):length(AllMotorVertexIndices);
                        elseif ov == length(AllMotorVertexIndices)
                            IndexSubset = 1:(ov - 1);
                        else
                            IndexSubset = [1:(ov - 1), (ov + 1):length(AllMotorVertexIndices)];
                        end
                        AllIndexListWithRepeats = [AllIndexListWithRepeats; AllMotorVertexIndices(IndexSubset)];
                        SortedListWithRepeats = sortrows(sort(AllIndexListWithRepeats, 2));

                        % The indices that get used when making a list of
                        % the unique row vectors
                        [~, UniqueIndexIndices, ~] = unique(SortedListWithRepeats, "rows");

                        % The indices that DON'T get used when making a
                        % list of the unique row vectors -- i.e. repeats
                        AllIndexIndices = 1:size(SortedListWithRepeats, 1);
                        RepeatIndexIndices = setdiff(AllIndexIndices, UniqueIndexIndices);


                        Faces = setdiff(SortedListWithRepeats, ...
                            SortedListWithRepeats(RepeatIndexIndices, :), ...
                            "rows");
                    end
                end
                obj.BoundaryFaceList = Faces;
            % Otherwise, if it's not of max dimension, then it's just equal
            % to the SimplexMatrix -- i.e. every simplex is a boundary
            % simplex.
            else
                obj.BoundaryFaceList = SimplexMatrix;
            end
        end
        
        %% CONTAINTMENT
        %  FUNCTIONS
        %  Contains
        
        % Finding whether a motor point is contained in one or more of the
        % simplices.  If so, the indices of the simplices is returned.  If 
        % not, [] is returned.
        function SimplexIndices = Contains(obj, MotorCoordinates)
            % This will really only have been tested for like 2 dimensions,
            % maybe 3, but I'm trying to make it so it works in general
            MinDistances = round(obj.DistancesToCoordinates(MotorCoordinates), obj.DigitsToRoundTo);
            SimplexIndices = find(~MinDistances);
        end

        %% DISTANCES
        %  FUNCTIONS
        %  DistancesToCoordinates

        % NEEDS TO BE FURTHER TESTED
        % TO MAKE SURE IT ACTUALLY WORKS!!!!!!!!!!
        function MinDistances = DistancesToCoordinates(obj, ...
                MotorCoordinates)
            MinDistances = nan(size(MotorCoordinates, 2), ...
                obj.NumSimplices);
            for p = 1:size(MinDistances, 1)
                Point = transpose(MotorCoordinates(:, p));
                for s = 1:size(MinDistances, 2)
                    SimplexVertices = obj.MotorVertexList( ...
                        obj.SimplexMatrix(s, :), :);
                    MinDistance = DistancePointToSimplex(Point, ...
                        SimplexVertices);
                    MinDistances(p, s) = MinDistance;
                end
            end
        end

        %% ACTIVATION
        %  FUNCTIONS
        %  ActivationOfMotorMatrix
        %  DistanceToActivationFunction

        % EXAMPLE
        % EX| obj.MotorVertexList = [0 0; 0 3; 4 3; 4 0]
        % EX| obj.SimplexMatrix = [1 2 3; 1 3 4]
        % EX| obj.Weights = [2 6]
        function Activation = ActivationOfMotorMatrix(obj, MotorMatrix, ...
                HighestActivation, DropoffSlope)
                % EX| HighestActivation = 1
                % EX| DropoffSlope = 0.1
                % EX| MotorMatrix = [5 0 4; 3 0 3]
            MinDistances = obj.DistancesToCoordinates(MotorMatrix);
                % EX| MinDistances = [1 1; 0 0; 0 0]
            CurrentActivations = obj.DistanceToActivationFunction( ...
                MinDistances, HighestActivation, DropoffSlope);
                % EX| CurrentActivations = [0.9 0.9; 1 1; 1 1]
            ActivationVector = transpose(CurrentActivations);
                % EX| ActivationVector = [0.9 1 1; 0.9 1 1]
            Activations = (obj.Weights * ActivationVector)/sum(obj.Weights);
                % EX| Activations = [7.2 8 8]/8 = [0.9 1 1]
            Activation = mean(Activations);
                % EX| Activation = 0.9666667
        end
        
        function ActivationFromDistance = DistanceToActivationFunction( ...
                obj, Distance, HighestActivation, DropoffSlope)
            ActivationFromDistance = max(0, HighestActivation - ( ...
                DropoffSlope * Distance));
        end

        %% EXPAND REGION
        %  FUNCTIONS
        %  Expand
        %  AddPointToSimplicialComplex
        function NewSimplicialComplex = Expand(obj, NewCoordinates)
            % If the point is already contained we just return the current 
            % object with weights changed
            NewCoordinates = round(NewCoordinates, obj.DigitsToRoundTo);
            RegionsContaining = obj.Contains(NewCoordinates);
            if RegionsContaining
                NewSimplicialComplex = obj;
                NewSimplicialComplex.Weights(RegionsContaining) = NewSimplicialComplex.Weights(RegionsContaining) + 1;
                return;
            else
                NewVertex = transpose(NewCoordinates);
                [NewMotorVertexList, NewSimplexMatrix, NewWeights] = ...
                    obj.AddPointToSimplicialComplex(NewVertex);
                NewSimplicialComplex = WeightedMotorSimplicialComplex( ...
                    NewMotorVertexList, NewSimplexMatrix, NewWeights);
            end
        end

        % RIGHT NOW THE SIMPLICES ARE GOING TO OVERLAP AND I NEED TO FIX THAT

        function [NewSimplexVertices, NewSimplexMatrix, NewWeights] = ...
            AddPointToSimplicialComplex(obj, Point)
            % ROUND THINGS FIRST TO NOT HAVE PROBLEMS
            Point = round(Point, obj.DigitsToRoundTo);
            SimplexVertices = round(obj.MotorVertexList, obj.DigitsToRoundTo);
            assert(size(obj.SimplexMatrix, 1) == length(obj.Weights));
            for v = 1:size(SimplexVertices, 1)
                assert(any(SimplexVertices(v, :) ~= Point));
            end
            NewSimplexVertices = [SimplexVertices; Point];
            NewSimplexMatrix = [];
            NewWeights = [];
            NewIndex = size(SimplexVertices, 1) + 1;
            % Are the simplices already of max dimension?
            if obj.Full
                % This is the case where we're going to be adding more simplices
                % rather than expanding INTO simplices -- it doesn't increase the 
                % dimension

                % Initialize
                NewSimplexMatrix = obj.SimplexMatrix;
                NewWeights = obj.Weights;

                % Go through all the boundary faces
                for n = 1:size(obj.BoundaryFaceList, 1)
                    % Only use boundary faces to expand w/ new point -- not
                    % interior faces
                    CurrentVertexIndices = obj.BoundaryFaceList(n, :);
                    % Combine the new point with the current boundary face
                    PotentialShiftedVertexSet = SimplexVertices(CurrentVertexIndices, :) - Point;
                    % See if it creates a new simplex (i.e. the new point
                    % isn't .... collinear I think? .... with the points
                    % already on the face
                    CreatesNewSimplex = isempty(null(transpose(PotentialShiftedVertexSet)));
                    % See if it overlaps with a simplex we already have --
                    % if so, we don't want to add it...
                    % If it only overlaps at a point or a face or something
                    % I think it's fine, but it's more overlap than that
                    % that we're concerned about.
                    if CreatesNewSimplex
                        OverlapsWithExistingSimplex = false;
                        % For each simplex in the list
                        for s = 1:size(obj.SimplexMatrix, 1)
                            % If the current vertex indices we're using are a
                            % face of this simplex
                            if all(ismember(CurrentVertexIndices, obj.SimplexMatrix(s, :)))
                                % See if this simplex and the new simplex
                                % intersect
                                AdditionalPointInExistingSimplex = ...
                                    SimplexVertices(setdiff( ...
                                    obj.SimplexMatrix(s, :), ...
                                    CurrentVertexIndices), :);
                                OverlapsWithExistingSimplex = ...
                                    DoSimplicesIntersect(SimplexVertices( ...
                                    CurrentVertexIndices, :), Point, ...
                                    AdditionalPointInExistingSimplex);
                                if OverlapsWithExistingSimplex
                                    break;
                                end
                            end
                        end
                        if ~OverlapsWithExistingSimplex
                            NewSimplexMatrix = [NewSimplexMatrix; [CurrentVertexIndices NewIndex]];
                            NewWeights = [NewWeights 1];
                        end
                    end
                end
            else
                % If it's not already max dimension, then does it increase the 
                % dimension of the simplices?
                FirstSet = SimplexVertices(obj.SimplexMatrix(1, :), :);
                ShiftedFirstSet = FirstSet - Point;
                if isempty(null(transpose(ShiftedFirstSet)))
                    % This is if it does increase the dimension
                    for n = 1:size(obj.SimplexMatrix, 1)
                        PotentialVertexIndexSet = obj.SimplexMatrix(n, :);
                        CorrespondingWeight = obj.Weights(n);
                        PotentialShiftedVertexSet = SimplexVertices(PotentialVertexIndexSet, :) - Point;
                        CreatesNewSimplex = isempty(null(transpose(PotentialShiftedVertexSet)));
                        if CreatesNewSimplex
                            NewSimplexMatrix = [NewSimplexMatrix; [PotentialVertexIndexSet NewIndex]];
                            NewWeights = [NewWeights CorrespondingWeight + 1];
                        end
                    end
                else
                    % Otherwise, if it doesn't increase the dimension, then
                    % find all the sets of vertices of size one fewer than
                    % the max dimension; e.g. if our vertex lists are
                    % currently 3 long, find all possible pairs of
                    % vertices.
                    % Then we'll go through and see if each of these pairs
                    % is actually already in a threesome.  If not, it's
                    % because they're not meant to be in any group
                    % together, so we won't try to use them.  If they do,
                    % then they're allowed to be in a group together, but
                    % then we have to test if adding this new vertex we
                    % have would create a simplex that overlaps with an
                    % already existing one -- if so, then this is also a
                    % problem and this new threesome won't be added
                    PossibleVertexCombinations = nchoosek(1:size(SimplexVertices, 1), obj.SimplexDimension - 1);
                    for vc = 1:size(PossibleVertexCombinations, 1)
                        PotentialVertexIndexSet = PossibleVertexCombinations(vc);
                        AdditionalVertices = [];
                        for s = 1:size(obj.SimplexMatrix, 1)
                            if all(ismember(PotentialVertexIndexSet, obj.SimplexMatrix(s, :)))
                                AdditionalVertex = setdiff( ...
                                    obj.SimplexMatrix(s, :), ...
                                    PotentialVertexIndexSet);
                                AdditionalVertices = [AdditionalVertices; AdditionalVertex];
                            end
                        end
                        if AdditionalVertices
                            for v = 1:length(AdditionalVertices)
                                AdditionalPointInExistingSimplex = ...
                                    SimplexVertices(AdditionalVertices(v), :);
                                OverlapsWithExistingSimplex = ...
                                    DoSimplicesIntersect(SimplexVertices( ...
                                    PotentialVertexIndexSet, :), Point, ...
                                    AdditionalPointInExistingSimplex);
                                if OverlapsWithExistingSimplex
                                    break;
                                end
                            end
                            if ~OverlapsWithExistingSimplex
                                NewSimplexMatrix = [NewSimplexMatrix; [PotentialVertexIndexSet NewIndex]];
                                NewWeights = [NewWeights 1];
                            end
                        end
                    end
                end
            end
        end
        
        %% PLOTTING INFO
        %  FUNCTIONS
        %  PlottingInfo

        % Plotting info -- gives a matrix where each row is the vertices of
        % the polygon that will represent this motor region -- it will be a
        % regular polygon with the NumberOfVertices given as input
        function [FaceData, VertexData, AlphaData] = PlottingInfo(obj, AlphaRangeOptions)
            arguments
                obj
                AlphaRangeOptions.AlphaMin {mustBeNumeric} = 0.1;
                AlphaRangeOptions.AlphaMax {mustBeNumeric} = 0.3;
            end
            VertexData = obj.MotorVertexList;
            FaceData = obj.SimplexMatrix;
            AlphaDataRaw = transpose(obj.Weights/sum(obj.Weights));
            RawMin = min(AlphaDataRaw);
            RawMax = max(AlphaDataRaw);
            if (RawMax - RawMin == 0)
                AlphaData = AlphaRangeOptions.AlphaMax * ones(size(AlphaDataRaw));
            else
                StretchFactor = (AlphaRangeOptions.AlphaMax - AlphaRangeOptions.AlphaMin)/(RawMax - RawMin);
                StretchedAlphaData = StretchFactor * AlphaDataRaw;
                ShiftFactor = AlphaRangeOptions.AlphaMax - max(StretchedAlphaData);
                AlphaData = StretchedAlphaData + ShiftFactor;
            end
        end
    end
end