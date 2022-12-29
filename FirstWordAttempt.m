%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ClosestSequences, GoalSequence, ASilhouette, ResultingJunctures, DistanceVector, ...
    AverageDistance] = FirstWordAttempt(space, SequenceVocabulary, SilhouetteVocabulary, ...
    ExemplarVocabulary, GoalExemplar, GoalSequence, NumNeighbors)
    % Given a random vocabulary, and a random extra word, it finds the n 
    % closest trajectories to extra word, and finds the ASilhouette 
    % corresponding to extra word, and computes the resulting trajectories 
    % that come from using that ASilhouette and the perceptual trajectory, 
    % and measures the distance between the resulting trajectory and the 
    % goal exemplar
    [ClosestSequences, ASilhouette] = FindASilhouette(SequenceVocabulary, SilhouetteVocabulary, ...
        ExemplarVocabulary, GoalExemplar, NumNeighbors);
    % Creating a goal from the space, silhouette, and exemplar
    goal = Goal(space, ASilhouette, GoalExemplar);
    
    executionParameters = ExecutionParameters(0, 0);
        % There is no anticipatory or perseveratory window
    
    % Finding the result of executing the Goal goal with the
    % ExecutionParameters executionParameters
    [ResultingJunctures, ~] = ...
        goal.SimpleMacroEstimates(executionParameters);
    
    % Finding the distance between the resulting perceptual points and the
    % goal exemplar
    PerceptualCoordinates = nan(length( ...
        ResultingJunctures(1).PerceptualPoint.Coordinates), ...
        length(ResultingJunctures));
    for p = 1:length(ResultingJunctures)
        PerceptualCoordinates(:, p) = ResultingJunctures( ...
            p).PerceptualPoint.Coordinates;
    end
    ResultingPerceptualTrajectory = PerceptualTrajectory( ...
        PerceptualCoordinates);
    DistanceVector = GoalExemplar.DistanceVectorToTrajectory( ...
        ResultingPerceptualTrajectory);
    AverageDistance = mean(DistanceVector, "all");
end
