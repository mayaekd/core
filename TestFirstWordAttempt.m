%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
% 

%% TESTS

function tests = TestFirstWordAttempt()
    tests = functiontests(localfunctions);
end


function TestFunctionSuperSimple(testCase)
    space = SimpleIdentityCVSpace();
    Silhouette1 = MotorSilhouette([WeightedMotorSimplicialComplex( ...
        [1 2; 4 2; 1 5; 4 5], [1 2 3; 2 3 4], [1 1]) WeightedMotorSimplicialComplex( ...
        [1 2; 4 2; 1 5; 4 5], [1 2 3; 2 3 4], [1 1])]);
    Silhouette2 = MotorSilhouette([WeightedMotorSimplicialComplex( ...
        [1 2; 4 2; 1 5; 4 5], [1 2 3; 2 3 4], [1 1]) WeightedMotorSimplicialComplex( ...
        [1 2; 4 2; 1 5; 4 5], [1 2 3; 2 3 4], [1 1])]);
    Exemplar1 = PerceptualTrajectory([3 4; 20 21]);
    Exemplar2 = PerceptualTrajectory([6 8; 20 25]);
    SequenceVocabulary = [1 3 3 4; 1 2 3 3];
    SilhouetteVocabulary = [Silhouette1 Silhouette2];
    ExemplarVocabulary = [Exemplar1 Exemplar2];
    GoalExemplar = PerceptualTrajectory([10 10; 12 15]);
    GoalSequence = [1 2 3 4];
    NumNeighbors = 2;
    [actClosestSequences, actGoalSequence, actASilhouette, ...
        actResultingJunctures, actDistanceVector, ...
        actAverageDistance] = FirstWordAttempt(space, ...
        SequenceVocabulary, SilhouetteVocabulary, ExemplarVocabulary, ...
        GoalExemplar, GoalSequence, NumNeighbors);
    actASilhouetteRegion1MV = actASilhouette.Regions(1).MotorVertexList;
    expASilhouetteRegion1MV = [1 2; 1 5; 4 2; 4 5];
    expASilhouetteRegion2MV = [];
    expASilhouetteRegion1SM = [1 3 4; 2 1 4];
    expASilhouetteRegion2SM = [];
    expASilhouetteRegion1Weights = [2 2];
    expASilhouetteRegion2Weights = [];
    expResultingJuncture1 = [];
    expResultingJuncture2 = [];
    expDistanceVector = [];
    expAverageDistance = [];
    verifyEqual(testCase, actASilhouetteRegion1MV, expASilhouetteRegion1MV, "AbsTol", 0.00001);
end

function TestFunctionSimple(testCase)
    space = SimpleIdentityCVSpace();
    Silhouette1 = MotorSilhouette([WeightedMotorSimplicialComplex( ...
        [1 2; 4 2; 1 5; 4 5], [1 2 3; 2 3 4], [1 1]) ...
        WeightedMotorSimplicialComplex( ...
        [20 10; 25 10; 20 12; 25 12], [1 2 3; 2 3 4], [1 1])]);
    Silhouette2 = MotorSilhouette([WeightedMotorSimplicialComplex( ...
        [3 3; 8 3; 3 6; 8 6], [1 2 3; 2 3 4], [1 1]) ...
        WeightedMotorSimplicialComplex( ...
        [21 8; 27 8; 21 12; 27 12], [1 2 3; 2 3 4], [1 1])]);
    Exemplar1 = PerceptualTrajectory([3 3; 21 11]);
    Exemplar2 = PerceptualTrajectory([6 4; 25 10]);
    SequenceVocabulary = [1 3 3 4; 1 2 3 3];
    SilhouetteVocabulary = [Silhouette1 Silhouette2];
    ExemplarVocabulary = [Exemplar1 Exemplar2];
    GoalExemplar = PerceptualTrajectory([10 10; 12 15]);
    GoalSequence = [1 2 3 4];
    NumNeighbors = 2;
    [actClosestSequences, actGoalSequence, actASilhouette, ...
        actResultingJunctures, actDistanceVector, ...
        actAverageDistance] = FirstWordAttempt(space, ...
        SequenceVocabulary, SilhouetteVocabulary, ExemplarVocabulary, ...
        GoalExemplar, GoalSequence, NumNeighbors);
    actASilhouetteRegion1MV = actASilhouette.Regions(1).MotorVertexList;
    expASilhouetteRegion1MV = [1 2;1 3; 1 5; 3 2; 3 3; 3 5; 3 6; 4 2; ...
        4 3; 4 5; 4 6; 8 3; 8 5; 8 6];
    expASilhouetteRegion2MV = [];
    expASilhouetteRegion1SM = [1 2 5; 1 4 5; 2 3 6; 2 5 6; 3 6 7; ...
        4 5 9; 4 8 9; 5 6 10; 5 9 10; 6 7 11; 6 10 11; 8 9 12; ...
        9 10 13; 9 12 13; 10 11 14; 10 13 14];
    expASilhouetteRegion2SM = [];
    expASilhouetteRegion1Weights = [1 1 1 1 1 1 1 2 2 1 1 1 1 1 1 1];
    expASilhouetteRegion2Weights = [];
    expResultingJuncture1 = [];
    expResultingJuncture2 = [];
    expDistanceVector = [];
    expAverageDistance = [];
    verifyEqual(testCase, actASilhouetteRegion1MV, expASilhouetteRegion1MV, "AbsTol", 0.00001);
end

