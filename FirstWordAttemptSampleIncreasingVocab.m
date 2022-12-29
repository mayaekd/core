%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [VocabularySequences, GoalSequences, AllSelectedSequences, ...
    VocabularySizes, AllDistanceVectors, DistanceVectorsAveraged, ...
    AllAverageDistances, AverageDistancesAveraged] = ...
    FirstWordAttemptSampleIncreasingVocab(space, ConsonantMins, ...
    ConsonantMaxes, VowelMins, VowelMaxes, CVPattern, SilhouetteRadius, ...
    VocabularySizes, NumNeighbors, NumTrials)
    % EX | CVPattern = "CVC"
    % EX | There are 2 consonants and 2 vowels
    % EX | SilhouetteRadius = 2
    % EX | VocabularySizes = [1 2 4 7]
    % EX | NumNeighbors = 2
    % EX | NumTrials = 3
    % Assume that the motor silhouettes are 2n - 1 time steps long
    TimeLength = 2 * length(char(CVPattern)) - 1;
    AllDistanceVectors = nan(length(VocabularySizes), TimeLength, NumTrials);
        % EX | AllDistanceVectors = nan(4, 5, 3)
    AllAverageDistances = nan(NumTrials, length(VocabularySizes));
        % EX | AllAverageDistances = nan(3, 4)
    DistanceVectorsAveraged = nan(length(VocabularySizes), TimeLength);
        % EX | DistanceVectorsAveraged = nan(5, 4)
    AverageDistancesAveraged = nan(1, length(VocabularySizes));
        % EX | AverageDistancesAveraged = nan(1, 4)
    VocabularySequences = cell(NumTrials, length(VocabularySizes));
        % EX | VocabularySequences = cell(3, 4)
    AllSelectedSequences = cell(NumTrials, length(VocabularySizes));
        % EX | AllSelectedSequences = cell(3, 2)
    GoalSequences = cell(NumTrials, length(VocabularySizes));
        % EX | GoalSequences = cell(3, 4)
    for n = 1:NumTrials
        fprintf("Starting trial %d\n", n);
        [VocabSequences, GoalSequence, SelectedSequences, ...
            ~, ~, DistanceVectors, AverageDistances] = ...
            FirstWordAttemptRandomVocabularyIncreasing(space, ...
            ConsonantMins, ConsonantMaxes, VowelMins, VowelMaxes, ...
            CVPattern, SilhouetteRadius, VocabularySizes, NumNeighbors);
            % EX | SUPPOSE EVERY TRIAL IS THE SAME:
            % EX | VocabSequences = {[1 1 1; 1 1 2] [1 1 1; 1 1 2; 1 2 1] 
            % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2] 
            % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2; 2 1 1; 2 1 2; 2 2 2]}
            % EX | GoalSequences = {[2 2 1] [2 2 1] [2 2 1] [2 2 1]}
            % EX | SelectedSequences = {[1 1 1; 1 1 2] [1 2 1; 1 1 1] 
            % EX | [1 2 1; 1 1 1] [2 1 1; 1 2 1]}
            % EX | DistanceVectors = [6 6 3; 6 3 0; 6 3 0; 3 3 0]
            % EX | AverageDistances = [5 3 3 2]
        VocabularySequences(n, :) = VocabSequences;
        AllSelectedSequences(n, :) = SelectedSequences;
        for v = 1:size(GoalSequences, 2)
            GoalSequences{n, v} = GoalSequence;
        end
        AllDistanceVectors(:, :, n) = DistanceVectors;
        AllAverageDistances(n, :) = AverageDistances;
        fprintf("Done with trial %d\n", n);
    end
        % EX | VocabularySequences = {[1 1 1; 1 1 2] [1 1 1; 1 1 2; 1 2 1]
        % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2] 
        % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2; 2 1 1; 2 1 2; 2 2 2];
        % EX | [1 1 1; 1 1 2] [1 1 1; 1 1 2; 1 2 1]
        % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2] 
        % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2; 2 1 1; 2 1 2; 2 2 2];
        % EX | [1 1 1; 1 1 2] [1 1 1; 1 1 2; 1 2 1]
        % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2] 
        % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2; 2 1 1; 2 1 2; 2 2 2]}
        % EX | 
        % EX | AllSelectedSequences = {
        % EX | [1 1 1; 1 1 2] [1 2 1; 1 1 1] [1 2 1; 1 1 1] [2 1 1; 1 2 1]; 
        % EX | [1 1 1; 1 1 2] [1 2 1; 1 1 1] [1 2 1; 1 1 1] [2 1 1; 1 2 1];
        % EX | [1 1 1; 1 1 2] [1 2 1; 1 1 1] [1 2 1; 1 1 1] [2 1 1; 1 2 1]}
        % EX | 
        % EX | GoalSequences = {[2 2 1] [2 2 1] [2 2 1] [2 2 1];
        % EX | [2 2 1] [2 2 1] [2 2 1] [2 2 1];
        % EX | [2 2 1] [2 2 1] [2 2 1] [2 2 1]}
        % EX | 
        % EX | AllDistanceVectors(:,:,1) = [6 6 6; 6 6 6; 6 6 6; 3 3 3]
        % EX | AllDistanceVectors(:,:,2) = [6 6 6; 3 3 3; 3 3 3; 3 3 3]
        % EX | AllDistanceVectors(:,:,2) = [3 3 3; 0 0 0; 3 3 3; 3 3 3]
        % EX | 
        % EX | AllAverageDistances = [5 3 3 2; 5 3 3 2; 5 3 3 2]
    for s = 1:length(VocabularySizes)
        DistanceVectorsAveraged(s, :) = mean(AllDistanceVectors(s, :, :), 3);
        AverageDistancesAveraged(s) = mean(AllAverageDistances(:, s));
    end
        % EX | DistanceVectorsAveraged = [6 6 3; 6 3 0; 6 3 3; 3 3 3]
        % EX | AverageDistancesAveraged = [5 3 3 2]
end

function [VocabSequences, GoalSequence, SelectedSequences, ASilhouette, ...
    ResultingJunctures, DistanceVectors, AverageDistances] = ...
    FirstWordAttemptRandomVocabularyIncreasing(space, ConsonantMins, ...
    ConsonantMaxes, VowelMins, VowelMaxes, CVPattern, SilhouetteRadius, ...
    VocabularySizes, NumNeighbors)
    % EX | space.SpaceTransformation is the identity
    % EX | ConsonantMins = [3 5; 4 6]
    % EX | ConsonantMaxes = [3 5; 4 6]
    % EX | VowelMins = [15 20; 18 25]
    % EX | VowelMaxes = [15 20; 18 25]
    % EX | CVPattern = "CVC"
    % EX | SilhouetteRadius = 1
    % EX | VocabularySizes = [2 3 4 7]
    % EX | NumNeighbors = 2
    for n = 1:length(VocabularySizes) - 1
        assert(VocabularySizes(n) < VocabularySizes(n + 1), "The " + ...
            "vocabulary sizes need to be listed in increasing order")
    end
    BiggestSize = VocabularySizes(length(VocabularySizes));
        % EX | BiggestSize = 7
    [space, AllSequences, MotorSilhouetteList, ExemplarList, ...
        GoalExemplar, GoalSequence] = Make2DCVWords(space, ...
        ConsonantMins, ConsonantMaxes, VowelMins, VowelMaxes, ...
        CVPattern, SilhouetteRadius, BiggestSize);
        % EX | AllSequences = [1 1 1; 1 1 2; 1 2 1; 1 2 2; 
        % EX | 2 1 1; 2 1 2; 2 2 2]
        % EX | MotorSilhouetteList is of length 7 such that, for example,
        % EX | MotorSilhouetteList(4) is the motor silhouette corresponding
        % EX | to the sequence 1 2 2 
        % EX | ExemplarList is of length 7 such that, for example,
        % EX | ExemplarList(4) is the exemplar corresponding to the
        % EX | sequence 1 2 2
        % EX | GoalExemplar is the trajectory w/ matrix 
        % EX | [5 12. 5 20 11.5 3; 6 15.5 25 14.5 4]
        % EX | GoalSequence = [2 2 1]
    VocabSequences = cell(1, length(VocabularySizes));
        % EX | VocabSequences = cell(1, 4)
    SelectedSequences = cell(1, length(VocabularySizes));
        % EX | SelectedSequences = cell(1, 2)
    GoalSequences = cell(1, length(VocabularySizes));
        % EX | GoalSequences = cell(1, 4)
    DistanceVectors = nan(length(VocabularySizes), ...
        length(MotorSilhouetteList(1).Regions));
        % EX | DistanceVectors = [nan nan nan nan; nan nan nan nan; 
        % EX | nan nan nan nan; nan nan nan nan; nan nan nan nan]
    AverageDistances = nan(1, length(VocabularySizes));
        % EX | AllAverageDistances = [nan nan nan nan]
    for s = 1:length(VocabularySizes)
        % EX | s = 1
        % EX | s = 2
        % EX | s = 3
        % EX | s = 4
        vSize = VocabularySizes(s);
            % EX | vSize = 2
            % EX | vSize = 3
            % EX | vSize = 4
            % EX | vSize = 7
        CurrentVocabSequences = AllSequences(1:vSize, :);
            % EX | CurrentVocabSequences = [1 1 1; 1 1 2]
            % EX | CurrentVocabSequences = [1 1 1; 1 1 2; 1 2 1]
            % EX | CurrentVocabSequences = [1 1 1; 1 1 2; 1 2 1; 1 2 2]
            % EX | CurrentVocabSequences = [1 1 1; 1 1 2; 1 2 1; 1 2 2; 
            % EX | 2 1 1; 2 1 2; 2 2 2]
        CurrentMotorSilhouetteList = MotorSilhouetteList(1:vSize);
            % EX | CurrentMotorSilhouetteList = [MS1]
            % EX | CurrentMotorSilhouetteList = [MS1 MS2]
            % EX | CurrentMotorSilhouetteList = [MS1 MS2 MS3 MS4]
            % EX | CurrentMotorSilhouetteList = [MS1 MS2 MS3 MS4 MS5 MS6 MS7]
        CurrentExemplarList = ExemplarList(1:vSize);
            % EX | CurrentExemplarList = [E1 E2]
            % EX | CurrentExemplarList = [E1 E2 E3]
            % EX | CurrentExemplarList = [E1 E2 E3 E4]
            % EX | CurrentExemplarList = [E1 E2 E3 E4 E5 E6 E7]
        [CurrentSelectedSequences, GoalSequence, ASilhouette, ...
            ResultingJunctures, DistanceVector, AverageDistance] = ...
            FirstWordAttempt(space, CurrentVocabSequences, ...
            CurrentMotorSilhouetteList, CurrentExemplarList, ...
            GoalExemplar, GoalSequence, NumNeighbors);
            % EX | Closest sequences to [2 2 1] in order of decreasing
            % EX | closeness: 2 1 1, 1 2 1, 2 2 2, 1 1 1, 2 1 2, 1 2 2, 1 1 2
            % EX | CurrentSelectedSequences = [1 1 1; 1 1 2]
            % EX | GoalSequence = [2 2 1]
            % EX | ASilhouette = 11 - btwn - 11 - btwn - 12
            % EX | ResultingJunctures = [JC1 JB11 JV1 JB21 JC2]
            % EX | DistanceVector = [6 6 6 4.5 3]
            % EX | AverageDistance = 5
            % EX | 
            % EX | CurrentSelectedSequences = [1 2 1; 1 1 1]
            % EX | GoalSequence = [2 2 1]
            % EX | ASilhouette = 11 - btwn - 12 - btwn - 11
            % EX | ResultingJunctures = [JC1 JB12 JV2 JB12 JC1]
            % EX | DistanceVector = [6 4.5 3 1.5 0]
            % EX | AverageDistance = 3
            % EX | 
            % EX | CurrentSelectedSequences = [1 2 1; 1 1 1]
            % EX | GoalSequence = [2 2 1]
            % EX | ASilhouette = 11 - btwn - 12 - btwn - 11
            % EX | ResultingJunctures = [JC1 JB12 JV2 JB12 JC1]
            % EX | DistanceVector = [6 4.5 3 1.5 0]
            % EX | AverageDistance = 3
            % EX | 
            % EX | CurrentSelectedSequences = [2 1 1; 1 2 1]
            % EX | GoalSequence = [2 2 1]
            % EX | ASilhouette = 12 - btwn - 12 - btwn - 11
            % EX | ResultingJunctures = [JC2 JB22 JV2 JB12 JC1]
            % EX | DistanceVector = [3 3 3 1.5 0]
            % EX | AverageDistance = 2
        VocabSequences{1, s} = CurrentVocabSequences;
            % EX | VocabSequences = {[1 1 1; 1 1 2] [1 1 1; 1 1 2; 1 2 1] 
            % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2] 
            % EX | [1 1 1; 1 1 2; 1 2 1; 1 2 2; 2 1 1; 2 1 2; 2 2 2]}
        SelectedSequences{1, s} = CurrentSelectedSequences;
            % EX | SelectedSequences = {[1 1 1; 1 1 2] [1 2 1; 1 1 1] 
            % EX | [1 2 1; 1 1 1] [2 1 1; 1 2 1]}
        GoalSequences{1, s} = GoalSequence;
            % EX | GoalSequences = {[2 2 1] [2 2 1] [2 2 1] [2 2 1]}
        DistanceVectors(s, :) = DistanceVector;
            % EX | DistanceVectors = [6 6 6 4.5 3; 6 4.5 3 1.5 0; 6 4.5 3 1.5 0; 3 3 3 1.5 0]
        AverageDistances(1, s) = AverageDistance;
            % EX | AverageDistances = [5.1 3 3 2.1]
        fprintf("Done with vocabulary #%d\n", s);
    end
end