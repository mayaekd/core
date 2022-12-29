%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
% 

%% TESTS

function tests = TestFirstWordAttemptSampleIncreasingVocab()
    tests = functiontests(localfunctions);
end


function TestFunctionSuperSimpleCV(testCase)
    space = SimpleIdentityCVSpace();
    CMins = [3 5 10; 4 6 12];
    CMaxes = [3 5 10; 4 6 12];
    VMins = [15; 18];
    VMaxes = [15; 18];
    CVPattern = "CV";
    SilhouetteRadius = 1;
    VocabularySizes = [1 2];
    NumNeighbors = 1;
    NumTrials = 3;
    [actVocabularySequences, actGoalSequences, actAllSelectedSequences, ...
        actVocabularySizes, actAllDistanceVectors, ...
        actDistanceVectorsAveraged, actAllAverageDistances, ...
        actAverageDistancesAveraged] = ...
        FirstWordAttemptSampleIncreasingVocab(space, CMins, CMaxes, ...
        VMins, VMaxes, CVPattern, SilhouetteRadius, VocabularySizes, ...
        NumNeighbors, NumTrials);

    expGoalSequencesA = {[1 1] [1 1]};
    expVocabularySequencesA = {[2 1] [2 1; 3 1]};
    expAllSelectedSequencesA = {[2 1] [2 1]};

    expGoalSequencesB = {[1 1] [1 1]};
    expVocabularySequencesB = {[3 1] [3 1; 2 1]};
    expAllSelectedSequencesB = {[3 1] [2 1]};

    expGoalSequencesC = {[2 1] [2 1]};
    expVocabularySequencesC = {[1 1] [1 1; 3 1]};
    expAllSelectedSequencesC = {[1 1] [1 1]};

    expGoalSequencesD = {[2 1] [2 1]};
    expVocabularySequencesD = {[3 1] [3 1; 1 1]};
    expAllSelectedSequencesD = {[3 1] [1 1]};

    expGoalSequencesE = {[3 1] [3 1]};
    expVocabularySequencesE = {[1 1] [1 1; 2 1]};
    expAllSelectedSequencesE = {[1 1] [2 1]};

    expGoalSequencesF = {[3 1] [3 1]};
    expVocabularySequencesF = {[2 1] [2 1; 1 1]};
    expAllSelectedSequencesF = {[2 1] [2 1]};

    expVocabularySizes = [1 2];

    for trial = 1:NumTrials
        OptionAVocab1 = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesA{1}) < 0.000001, "all");
        OptionAGoal1 = all(abs(actGoalSequences{trial, 1} - expGoalSequencesA{1}) < 0.000001, "all");
        OptionASelected1 = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesA{1}) < 0.000001, "all");
        OptionAVocab2 = all(abs(actVocabularySequences{trial, 2} - expVocabularySequencesA{2}) < 0.000001, "all");
        OptionAGoal2 = all(abs(actGoalSequences{trial, 2} - expGoalSequencesA{2}) < 0.000001, "all");
        OptionASelected2 = all(abs(actAllSelectedSequences{trial, 2} - expAllSelectedSequencesA{2}) < 0.000001, "all");
    
        OptionBVocab1 = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesB{1}) < 0.000001, "all");
        OptionBGoal1 = all(abs(actGoalSequences{trial, 1} - expGoalSequencesB{1}) < 0.000001, "all");
        OptionBSelected1 = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesB{1}) < 0.000001, "all");
        OptionBVocab2 = all(abs(actVocabularySequences{trial, 2} - expVocabularySequencesB{2}) < 0.000001, "all");
        OptionBGoal2 = all(abs(actGoalSequences{trial, 2} - expGoalSequencesB{2}) < 0.000001, "all");
        OptionBSelected2 = all(abs(actAllSelectedSequences{trial, 2} - expAllSelectedSequencesB{2}) < 0.000001, "all");
    
        OptionCVocab1 = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesC{1}) < 0.000001, "all");
        OptionCGoal1 = all(abs(actGoalSequences{trial, 1} - expGoalSequencesC{1}) < 0.000001, "all");
        OptionCSelected1 = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesC{1}) < 0.000001, "all");
        OptionCVocab2 = all(abs(actVocabularySequences{trial, 2} - expVocabularySequencesC{2}) < 0.000001, "all");
        OptionCGoal2 = all(abs(actGoalSequences{trial, 2} - expGoalSequencesC{2}) < 0.000001, "all");
        OptionCSelected2 = all(abs(actAllSelectedSequences{trial, 2} - expAllSelectedSequencesC{2}) < 0.000001, "all");
    
        OptionDVocab1 = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesD{1}) < 0.000001, "all");
        OptionDGoal1 = all(abs(actGoalSequences{trial, 1} - expGoalSequencesD{1}) < 0.000001, "all");
        OptionDSelected1 = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesD{1}) < 0.000001, "all");
        OptionDVocab2 = all(abs(actVocabularySequences{trial, 2} - expVocabularySequencesD{2}) < 0.000001, "all");
        OptionDGoal2 = all(abs(actGoalSequences{trial, 2} - expGoalSequencesD{2}) < 0.000001, "all");
        OptionDSelected2 = all(abs(actAllSelectedSequences{trial, 2} - expAllSelectedSequencesD{2}) < 0.000001, "all");
    
        OptionEVocab1 = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesE{1}) < 0.000001, "all");
        OptionEGoal1 = all(abs(actGoalSequences{trial, 1} - expGoalSequencesE{1}) < 0.000001, "all");
        OptionESelected1 = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesE{1}) < 0.000001, "all");
        OptionEVocab2 = all(abs(actVocabularySequences{trial, 2} - expVocabularySequencesE{2}) < 0.000001, "all");
        OptionEGoal2 = all(abs(actGoalSequences{trial, 2} - expGoalSequencesE{2}) < 0.000001, "all");
        OptionESelected2 = all(abs(actAllSelectedSequences{trial, 2} - expAllSelectedSequencesE{2}) < 0.000001, "all");
    
        OptionFVocab1 = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesF{1}) < 0.000001, "all");
        OptionFGoal1 = all(abs(actGoalSequences{trial, 1} - expGoalSequencesF{1}) < 0.000001, "all");
        OptionFSelected1 = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesF{1}) < 0.000001, "all");
        OptionFVocab2 = all(abs(actVocabularySequences{trial, 2} - expVocabularySequencesF{2}) < 0.000001, "all");
        OptionFGoal2 = all(abs(actGoalSequences{trial, 2} - expGoalSequencesF{2}) < 0.000001, "all");
        OptionFSelected2 = all(abs(actAllSelectedSequences{trial, 2} - expAllSelectedSequencesF{2}) < 0.000001, "all");

        OptionATrueFalse = ...
            OptionAVocab1 && OptionAGoal1 && OptionASelected1 && ...
            OptionAVocab2 && OptionAGoal2 && OptionASelected2;
        OptionBTrueFalse = ...
            OptionBVocab1 && OptionBGoal1 && OptionBSelected1 && ...
            OptionBVocab2 && OptionBGoal2 && OptionBSelected2;
        OptionCTrueFalse = ...
            OptionCVocab1 && OptionCGoal1 && OptionCSelected1 && ...
            OptionCVocab2 && OptionCGoal2 && OptionCSelected2;
        OptionDTrueFalse = ...
            OptionDVocab1 && OptionDGoal1 && OptionDSelected1 && ...
            OptionDVocab2 && OptionDGoal2 && OptionDSelected2;
        OptionETrueFalse = ...
            OptionEVocab1 && OptionEGoal1 && OptionESelected1 && ...
            OptionEVocab2 && OptionEGoal2 && OptionESelected2;
        OptionFTrueFalse = ...
            OptionFVocab1 && OptionFGoal1 && OptionFSelected1 && ...
            OptionFVocab2 && OptionFGoal2 && OptionFSelected2;
    
        verifyTrue(testCase, (OptionATrueFalse || OptionBTrueFalse || ...
            OptionCTrueFalse || OptionDTrueFalse || ...
            OptionETrueFalse || OptionFTrueFalse));
    end
    verifyEqual(testCase, actVocabularySizes, expVocabularySizes);
end

function TestFunctionSuperSimpleCVC(testCase)
    space = SimpleIdentityCVSpace();
    CMins = [3 5; 4 6];
    CMaxes = [3 5; 4 6];
    VMins = [15; 18];
    VMaxes = [15; 18];
    CVPattern = "CVC";
    SilhouetteRadius = 1;
    VocabularySizes = [3];
    NumNeighbors = 2;
    NumTrials = 3;
    [actVocabularySequences, actGoalSequences, actAllSelectedSequences, ...
        actVocabularySizes, actAllDistanceVectors, ...
        actDistanceVectorsAveraged, actAllAverageDistances, ...
        actAverageDistancesAveraged] = ...
        FirstWordAttemptSampleIncreasingVocab(space, CMins, CMaxes, ...
        VMins, VMaxes, CVPattern, SilhouetteRadius, VocabularySizes, ...
        NumNeighbors, NumTrials);

    expGoalSequencesA = {[1 1 1]};
    expVocabularySequencesA = {[1 1 2; 2 1 1; 2 1 2]};
    expAllSelectedSequencesA = {[1 1 2; 2 1 1]};

    expGoalSequencesB = {[1 1 1]};
    expVocabularySequencesB = {[1 1 2; 2 1 2; 2 1 1]};
    expAllSelectedSequencesB = {[1 1 2; 2 1 1]};

    expGoalSequencesC = {[1 1 1]};
    expVocabularySequencesC = {[2 1 1; 1 1 2; 2 1 2]};
    expAllSelectedSequencesC = {[2 1 1; 1 1 2]};

    expGoalSequencesD = {[1 1 1]};
    expVocabularySequencesD = {[2 1 1; 2 1 2; 1 1 2]};
    expAllSelectedSequencesD = {[2 1 1; 1 1 2]};

    expGoalSequencesE = {[1 1 1]};
    expVocabularySequencesE = {[2 1 2; 1 1 2; 2 1 1]};
    expAllSelectedSequencesE = {[1 1 2; 2 1 1]};

    expGoalSequencesF = {[1 1 1]};
    expVocabularySequencesF = {[2 1 2; 2 1 1; 1 1 2]};
    expAllSelectedSequencesF = {[2 1 1; 1 1 2]};

    expGoalSequencesG = {[1 1 2]};
    expVocabularySequencesG = {[1 1 1; 2 1 1; 2 1 2]};
    expAllSelectedSequencesG = {[1 1 1; 2 1 2]};

    expGoalSequencesH = {[1 1 2]};
    expVocabularySequencesH = {[1 1 1; 2 1 2; 2 1 1]};
    expAllSelectedSequencesH = {[1 1 1; 2 1 2]};

    expGoalSequencesI = {[1 1 2]};
    expVocabularySequencesI = {[2 1 1; 1 1 1; 2 1 2]};
    expAllSelectedSequencesI = {[1 1 1; 2 1 2]};

    expGoalSequencesJ = {[1 1 2]};
    expVocabularySequencesJ = {[2 1 1; 2 1 2; 1 1 1]};
    expAllSelectedSequencesJ = {[2 1 2; 1 1 1]};

    expGoalSequencesK = {[1 1 2]};
    expVocabularySequencesK = {[2 1 2; 1 1 1; 2 1 1]};
    expAllSelectedSequencesK = {[2 1 2; 1 1 1]};

    expGoalSequencesL = {[1 1 2]};
    expVocabularySequencesL = {[2 1 2; 2 1 1; 1 1 1]};
    expAllSelectedSequencesL = {[2 1 2; 1 1 1]};

    expGoalSequencesM = {[2 1 1]};
    expVocabularySequencesM = {[1 1 1; 1 1 2; 2 1 2]};
    expAllSelectedSequencesM = {[2 1 1; 2 1 2]};

    expGoalSequencesN = {[2 1 1]};
    expVocabularySequencesN = {[1 1 1; 2 1 2; 1 1 2]};
    expAllSelectedSequencesN = {[1 1 1; 2 1 2]};

    expGoalSequencesO = {[2 1 1]};
    expVocabularySequencesO = {[1 1 2; 1 1 1; 2 1 2]};
    expAllSelectedSequencesO = {[1 1 1; 2 1 2]};

    expGoalSequencesP = {[2 1 1]};
    expVocabularySequencesP = {[1 1 2; 2 1 2; 1 1 1]};
    expAllSelectedSequencesP = {[2 1 2; 1 1 1]};

    expGoalSequencesQ = {[2 1 1]};
    expVocabularySequencesQ = {[2 1 2; 1 1 1; 1 1 2]};
    expAllSelectedSequencesQ = {[2 1 2; 1 1 1]};

    expGoalSequencesR = {[2 1 1]};
    expVocabularySequencesR = {[2 1 2; 1 1 2; 1 1 1]};
    expAllSelectedSequencesR = {[2 1 2; 1 1 1]};

    expGoalSequencesS = {[2 1 2]};
    expVocabularySequencesS = {[1 1 1; 1 1 2; 2 1 1]};
    expAllSelectedSequencesS = {[1 1 2; 2 1 1]};

    expGoalSequencesT = {[2 1 2]};
    expVocabularySequencesT = {[1 1 1; 2 1 1; 1 1 2]};
    expAllSelectedSequencesT = {[2 1 1; 1 1 2]};

    expGoalSequencesU = {[2 1 2]};
    expVocabularySequencesU = {[1 1 2; 1 1 1; 2 1 1]};
    expAllSelectedSequencesU = {[1 1 2; 2 1 1]};

    expGoalSequencesV = {[2 1 2]};
    expVocabularySequencesV = {[1 1 2; 2 1 1; 1 1 1]};
    expAllSelectedSequencesV = {[1 1 2; 2 1 1]};

    expGoalSequencesW = {[2 1 2]};
    expVocabularySequencesW = {[2 1 1; 1 1 1; 1 1 2]};
    expAllSelectedSequencesW = {[2 1 1; 1 1 2]};

    expGoalSequencesX = {[2 1 2]};
    expVocabularySequencesX = {[2 1 1; 1 1 2; 1 1 1]};
    expAllSelectedSequencesX = {[2 1 1; 1 1 2]};

    expVocabularySizes = [3];

    for trial = 1:NumTrials
        OptionAVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesA{1}) < 0.000001, "all");
        OptionAGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesA{1}) < 0.000001, "all");
        OptionASelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesA{1}) < 0.000001, "all");

        OptionBVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesB{1}) < 0.000001, "all");
        OptionBGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesB{1}) < 0.000001, "all");
        OptionBSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesB{1}) < 0.000001, "all");

        OptionCVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesC{1}) < 0.000001, "all");
        OptionCGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesC{1}) < 0.000001, "all");
        OptionCSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesC{1}) < 0.000001, "all");

        OptionDVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesD{1}) < 0.000001, "all");
        OptionDGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesD{1}) < 0.000001, "all");
        OptionDSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesD{1}) < 0.000001, "all");

        OptionEVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesE{1}) < 0.000001, "all");
        OptionEGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesE{1}) < 0.000001, "all");
        OptionESelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesE{1}) < 0.000001, "all");

        OptionFVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesF{1}) < 0.000001, "all");
        OptionFGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesF{1}) < 0.000001, "all");
        OptionFSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesF{1}) < 0.000001, "all");

        OptionGVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesG{1}) < 0.000001, "all");
        OptionGGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesG{1}) < 0.000001, "all");
        OptionGSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesG{1}) < 0.000001, "all");

        OptionHVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesH{1}) < 0.000001, "all");
        OptionHGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesH{1}) < 0.000001, "all");
        OptionHSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesH{1}) < 0.000001, "all");

        OptionIVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesI{1}) < 0.000001, "all");
        OptionIGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesI{1}) < 0.000001, "all");
        OptionISelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesI{1}) < 0.000001, "all");

        OptionJVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesJ{1}) < 0.000001, "all");
        OptionJGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesJ{1}) < 0.000001, "all");
        OptionJSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesJ{1}) < 0.000001, "all");

        OptionKVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesK{1}) < 0.000001, "all");
        OptionKGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesK{1}) < 0.000001, "all");
        OptionKSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesK{1}) < 0.000001, "all");

        OptionLVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesL{1}) < 0.000001, "all");
        OptionLGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesL{1}) < 0.000001, "all");
        OptionLSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesL{1}) < 0.000001, "all");

        OptionMVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesM{1}) < 0.000001, "all");
        OptionMGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesM{1}) < 0.000001, "all");
        OptionMSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesM{1}) < 0.000001, "all");

        OptionNVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesN{1}) < 0.000001, "all");
        OptionNGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesN{1}) < 0.000001, "all");
        OptionNSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesN{1}) < 0.000001, "all");

        OptionOVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesO{1}) < 0.000001, "all");
        OptionOGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesO{1}) < 0.000001, "all");
        OptionOSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesO{1}) < 0.000001, "all");

        OptionPVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesP{1}) < 0.000001, "all");
        OptionPGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesP{1}) < 0.000001, "all");
        OptionPSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesP{1}) < 0.000001, "all");

        OptionQVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesQ{1}) < 0.000001, "all");
        OptionQGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesQ{1}) < 0.000001, "all");
        OptionQSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesQ{1}) < 0.000001, "all");

        OptionRVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesR{1}) < 0.000001, "all");
        OptionRGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesR{1}) < 0.000001, "all");
        OptionRSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesR{1}) < 0.000001, "all");

        OptionSVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesS{1}) < 0.000001, "all");
        OptionSGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesS{1}) < 0.000001, "all");
        OptionSSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesS{1}) < 0.000001, "all");

        OptionTVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesT{1}) < 0.000001, "all");
        OptionTGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesT{1}) < 0.000001, "all");
        OptionTSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesT{1}) < 0.000001, "all");

        OptionUVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesU{1}) < 0.000001, "all");
        OptionUGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesU{1}) < 0.000001, "all");
        OptionUSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesU{1}) < 0.000001, "all");

        OptionVVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesV{1}) < 0.000001, "all");
        OptionVGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesV{1}) < 0.000001, "all");
        OptionVSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesV{1}) < 0.000001, "all");

        OptionWVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesW{1}) < 0.000001, "all");
        OptionWGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesW{1}) < 0.000001, "all");
        OptionWSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesW{1}) < 0.000001, "all");

        OptionXVocab = all(abs(actVocabularySequences{trial, 1} - expVocabularySequencesX{1}) < 0.000001, "all");
        OptionXGoal = all(abs(actGoalSequences{trial, 1} - expGoalSequencesX{1}) < 0.000001, "all");
        OptionXSelected = all(abs(actAllSelectedSequences{trial, 1} - expAllSelectedSequencesX{1}) < 0.000001, "all");

        OptionATrueFalse = OptionAVocab && OptionAGoal && OptionASelected;
        OptionBTrueFalse = OptionBVocab && OptionBGoal && OptionBSelected;
        OptionCTrueFalse = OptionCVocab && OptionCGoal && OptionCSelected;
        OptionDTrueFalse = OptionDVocab && OptionDGoal && OptionDSelected;
        OptionETrueFalse = OptionEVocab && OptionEGoal && OptionESelected;
        OptionFTrueFalse = OptionFVocab && OptionFGoal && OptionFSelected;
        OptionGTrueFalse = OptionGVocab && OptionGGoal && OptionGSelected;
        OptionHTrueFalse = OptionHVocab && OptionHGoal && OptionHSelected;
        OptionITrueFalse = OptionIVocab && OptionIGoal && OptionISelected;
        OptionJTrueFalse = OptionJVocab && OptionJGoal && OptionJSelected;
        OptionKTrueFalse = OptionKVocab && OptionKGoal && OptionKSelected;
        OptionLTrueFalse = OptionLVocab && OptionLGoal && OptionLSelected;
        OptionMTrueFalse = OptionMVocab && OptionMGoal && OptionMSelected;
        OptionNTrueFalse = OptionNVocab && OptionNGoal && OptionNSelected;
        OptionOTrueFalse = OptionOVocab && OptionOGoal && OptionOSelected;
        OptionPTrueFalse = OptionPVocab && OptionPGoal && OptionPSelected;
        OptionQTrueFalse = OptionQVocab && OptionQGoal && OptionQSelected;
        OptionRTrueFalse = OptionRVocab && OptionRGoal && OptionRSelected;
        OptionSTrueFalse = OptionSVocab && OptionSGoal && OptionSSelected;
        OptionTTrueFalse = OptionTVocab && OptionTGoal && OptionTSelected;
        OptionUTrueFalse = OptionUVocab && OptionUGoal && OptionUSelected;
        OptionVTrueFalse = OptionVVocab && OptionVGoal && OptionVSelected;
        OptionWTrueFalse = OptionWVocab && OptionWGoal && OptionWSelected;
        OptionXTrueFalse = OptionXVocab && OptionXGoal && OptionXSelected;
    
        verifyTrue(testCase, (OptionATrueFalse || OptionBTrueFalse || ...
            OptionCTrueFalse || OptionDTrueFalse || OptionETrueFalse || ...
            OptionFTrueFalse || OptionGTrueFalse || OptionHTrueFalse || ...
            OptionITrueFalse || OptionJTrueFalse || OptionKTrueFalse || ...
            OptionLTrueFalse || OptionMTrueFalse || OptionNTrueFalse || ...
            OptionOTrueFalse || OptionPTrueFalse || OptionQTrueFalse || ...
            OptionRTrueFalse || OptionSTrueFalse || OptionTTrueFalse || ...
            OptionUTrueFalse || OptionVTrueFalse || OptionWTrueFalse || ...
            OptionXTrueFalse));
    end
    verifyEqual(testCase, actVocabularySizes, expVocabularySizes);
end

function TestFunctionSimple(testCase)
    space = SimpleIdentityCVSpace();
    CMins = [3 5; 4 6];
    CMaxes = [3 5; 4 6];
    VMins = [15; 18];
    VMaxes = [15; 18];
    CVPattern = "CVCVC";
    SilhouetteRadius = 1;
    VocabularySizes = [1 2 4 7];
    NumNeighbors = 1;
    NumTrials = 2;
    [actVocabularySequences, actGoalSequences, actAllSelectedSequences, ...
        actVocabularySizes, actAllDistanceVectors, ...
        actDistanceVectorsAveraged, actAllAverageDistances, ...
        actAverageDistancesAveraged] = ...
        FirstWordAttemptSampleIncreasingVocab(space, CMins, CMaxes, ...
        VMins, VMaxes, CVPattern, SilhouetteRadius, VocabularySizes, ...
        NumNeighbors, NumTrials);

    expVocabularySizes = [1 2 4 7];

    verifyEqual(testCase, size(actVocabularySequences{1, 1}), [1 9]);
    verifyEqual(testCase, size(actVocabularySequences{1, 2}), [2 9]);
    verifyEqual(testCase, size(actVocabularySequences{1, 3}), [4 9]);
    verifyEqual(testCase, size(actVocabularySequences{1, 4}), [7 9]);
    verifyEqual(testCase, size(actVocabularySequences{2, 1}), [1 9]);
    verifyEqual(testCase, size(actVocabularySequences{2, 2}), [2 9]);
    verifyEqual(testCase, size(actVocabularySequences{2, 3}), [4 9]);
    verifyEqual(testCase, size(actVocabularySequences{2, 4}), [7 9]);
    verifyEqual(testCase, actVocabularySizes, expVocabularySizes);
end

