%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [space, SequenceList, MotorSilhouetteList, ExemplarList, GoalExemplar, GoalSequence] = ...
    CreateRandomVocabulary(NumWords)
    space = SimpleCVSpace();
    ConsonantMins = [0 5 10 15 20 25; 0 0 0 0 0 0];
    ConsonantMaxes = [3 8 13 18 23 28; 3 3 3 3 3 3];
    VowelMins = [0 5 10 15 20 25; 18 18 18 18 18 18];
    VowelMaxes = [3 8 13 18 23 28; 23 23 23 23 23 23];
    
    [AllSequenceList, AllMotorSilhouetteList, AllExemplarList] = Make2DCVWords( ...
            space.SpaceTransformation, ConsonantMins, ConsonantMaxes, ...
            VowelMins, VowelMaxes, "CVCV", 3, NumWords + 1);
    MotorSilhouetteList = AllMotorSilhouetteList(1:NumWords);
    ExemplarList = AllExemplarList(1:NumWords);
    GoalExemplar = AllExemplarList(NumWords + 1);
    SequenceList = AllSequenceList(1:NumWords, :);
    GoalSequence = AllSequenceList(NumWords + 1, :);
end
