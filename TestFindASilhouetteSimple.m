%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHODS TESTED
%
% 

%% TESTS

function tests = TestFindASilhouetteSimple()
    tests = functiontests(localfunctions);
end

function TestFunctionSimple(testCase)
    verifyEqual(testCase, actLastIndex, expLastIndex, "AbsTol", 0.00001);
end

