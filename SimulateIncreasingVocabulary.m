%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

space = SimpleCVSpace();
ConsonantMins = [0 5 10 15 20 25; 0 0 0 0 0 0];
ConsonantMaxes = [3 8 13 18 23 28; 3 3 3 3 3 3];
VowelMins = [0 5 10 15 20 25; 18 18 18 18 18 18];
VowelMaxes = [3 8 13 18 23 28; 23 23 23 23 23 23];
CVPattern = "CVCV";
SilhouetteRadius = 2;
VocabularySizes = [5 10 20 40 70 100 150 200 300 400 500 600 700 800 900 1000 1100 1200];
NumNeighbors = 3;
NumTrials = 1;


SeedBase = 20;
RandSeed = 100 * SeedBase;
rng(RandSeed);

[VocabularySequences20, GoalSequences20, AllSelectedSequences20, ...
    VocabularySizes20, AllDistanceVectors20, DistanceVectorsAveraged20, ...
    AllAverageDistances20, AverageDistancesAveraged20] = ...
    FirstWordAttemptSampleIncreasingVocab(space, ConsonantMins, ...
    ConsonantMaxes, VowelMins, VowelMaxes, CVPattern, SilhouetteRadius, ...
    VocabularySizes, NumNeighbors, NumTrials);

% scatter(VocabularySizes, AverageDistancesAveraged);