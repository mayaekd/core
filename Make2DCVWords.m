%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [space, SelectedSequences, MotorSilhouetteList, ExemplarList, ...
        GoalExemplar, GoalSequence] = ...
    Make2DCVWords(space, ConsonantMins, ConsonantMaxes, ...
    VowelMins, VowelMaxes, CVPattern, SilhouetteRadius, NumWords)
    % If there are 3 consonants, C1, C2, C3, such that:
    % For C1:
    % DIMENSION ||| MIN VALUE | MAX VALUE
    % Dimension 1 |     1     |     3
    % Dimension 2 |     2     |     4
    % For C2:
    % DIMENSION ||| MIN VALUE | MAX VALUE
    % Dimension 1 |     3     |     5
    % Dimension 2 |     4     |     6
    % For C3:
    % DIMENSION ||| MIN VALUE | MAX VALUE
    % Dimension 1 |     5     |     7
    % Dimension 2 |     6     |     8
    % And if there are 4 vowels, V1, V2, V3, V4, such that:
    % For V1:
    % DIMENSION ||| MIN VALUE | MAX VALUE
    % Dimension 1 |     20    |     25
    % Dimension 2 |     22    |     27
    % For V2:
    % DIMENSION ||| MIN VALUE | MAX VALUE
    % Dimension 1 |     24    |     25
    % Dimension 2 |     26    |     27
    % For V3:
    % DIMENSION ||| MIN VALUE | MAX VALUE
    % Dimension 1 |     30    |     35
    % Dimension 2 |     32    |     37
    % For V4:
    % DIMENSION ||| MIN VALUE | MAX VALUE
    % Dimension 1 |     34    |     39
    % Dimension 2 |     36    |     41
    % Then:
    % ConsonantMins = [1 3 5; 2 4 6]
    % ConsonantMaxes = [3 5 7; 4 6 8]
    % VowelMins = [20 24 30 34; 22 26 32 36]
    % VowelMaxes = [25 29 35 39; 27 31 37 41]
    CVPattern = char(CVPattern.upper()); % Putting this in the right format
    NumConsonants = size(ConsonantMins, 2);
    NumVowels = size(VowelMins, 2);
    NumLetters = length(CVPattern);

    % Initializing these sets
    MotorSilhouetteList = MotorSilhouette.empty(0, NumWords);
    ExemplarList = PerceptualTrajectory.empty(0, NumWords);

    ClusterSequenceValues = cell(1, NumLetters);
    for letter = 1:NumLetters
        if CVPattern(letter) == 'C'
            ClusterSequenceValues{letter} = 1:NumConsonants;
        elseif CVPattern(letter) == 'V'
            ClusterSequenceValues{letter} = 1:NumVowels;
        else
            error("CVPattern must be made up of only Cs and Vs " + ...
                    "but there is a " + CVPattern(letter));
        end
    end

    % Making the grids for the possible cluster sequences
    ClusterSequenceGrids = cell(1, NumLetters);
    [ClusterSequenceGrids{:}] = ndgrid(ClusterSequenceValues{:});
    % All possible cluster sequences
    NumSequences = numel(ClusterSequenceGrids{1});
    if NumSequences < NumWords
        error("The number of words requested to be in the " + ...
            "vocabulary is larger than the total possible number of " + ...
            "cluster sequences -- the vocabulary was requested " + ...
            "to be of size " + NumWords + " but there are only " + ...
            NumSequences + " possible cluster sequences")
    elseif NumSequences == NumWords
        warning("The number of words requested to be in the " + ...
            "vocabulary is the same as the total possible number of " + ...
            "cluster sequences -- the vocabulary was requested " + ...
            "to be of size " + NumWords + ", which is how many " + ...
            "cluster sequences there are.  The vocabulary will " + ...
            "include all possible cluster sequences.")
    end
    AllPossibleClusterSequences = nan(NumSequences, NumLetters);
    for letter = 1:NumLetters
        AllPossibleClusterSequences(:, letter) = reshape( ...
            ClusterSequenceGrids{letter}, [NumSequences 1]);
    end

    % Choosing NumWords distinct Cluster sequences
    SelectedSequenceIndices = randperm(NumSequences, NumWords + 1);
    SelectedSequences = nan(NumWords, NumLetters);
    for w = 1:NumWords + 1
        CurrentSequence = AllPossibleClusterSequences(SelectedSequenceIndices(w), :);
        if w <= NumWords
            SelectedSequences(w, :) = CurrentSequence;
        else
            GoalSequence = CurrentSequence;
        end
        % Initializing these sets
        MotorCenterList = nan(2, NumLetters);
        % Go through each letter in the specified pattern
        for letter = 1:length(CVPattern)
            % Randomly choose which consonant or vowel it's going to fall 
            % in (i.e. which region/cluster it's going to be in)
            ClusterNumber = CurrentSequence(letter);
            % If this letter is going to be a consonant...
            if CVPattern(letter) == 'C'
                % Then randomly choose WHERE in that consonant region it's
                % going to be
                MotorCenter = (ConsonantMaxes(:, ClusterNumber) ...
                    - ConsonantMins(:, ClusterNumber)) ...
                    .* rand(2, 1) ...
                    + ConsonantMins(:, ClusterNumber);
                    % EX | MotorCenter = [3 4]
            elseif CVPattern(letter) == 'V'
                % Then randomly choose WHERE in that consonant region it's
                % going to be
                MotorCenter = (VowelMaxes(:, ClusterNumber) ...
                    - VowelMins(:, ClusterNumber)) ...
                    .* rand(2, 1) ...
                    + VowelMins(:, ClusterNumber);
                    % EX | MotorCenter = [30 36]
            else
                error("CVPattern must be made up of only Cs and Vs " + ...
                    "but there is a " + CVPattern(letter));
            end
            MotorCenterList(:, letter) = MotorCenter;
        end

        TimeLength = 2 * NumLetters - 1;
        FullMotorCenterList = interp1(1:2:TimeLength, transpose(MotorCenterList), ...
            1:TimeLength);
        MotorRegionList = WeightedMotorSimplicialComplex.empty(0, TimeLength);
        for letter = 1:TimeLength
            MotorCenter = FullMotorCenterList(letter, :);
            MotorVertexList = MotorCenter + SilhouetteRadius * ...
                [-1 -1; 1 -1; -1 1; 1 1];
                % EX | MotorCenter = [3 4] & SilhouetteRadius = 2
            SimplexMatrix = [1 2 4; 1 3 4];
            Weights = [1 1];
            MotorRegion = WeightedMotorSimplicialComplex( ...
                MotorVertexList, SimplexMatrix, Weights);
            MotorRegionList(letter) = MotorRegion;
        end
        CurrentSilhouette = MotorSilhouette(MotorRegionList);
        CurrentExemplar = MotorTrajectory(transpose(FullMotorCenterList)).FindPerceptualTrajectory(space.SpaceTransformation);
        if w <= NumWords
            MotorSilhouetteList(w) = CurrentSilhouette;
            ExemplarList(w) = CurrentExemplar;
        else
            GoalExemplar = CurrentExemplar;
        end
    end
end