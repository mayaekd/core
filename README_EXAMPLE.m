%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%                      %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% SUPER SIMPLE EXAMPLE %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%                      %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This example can be run by opening MATLAB, making sure this file is in
% the path (or in the Current Folder), and either hitting the "Run"
% green-triangle button, or typing README_EXAMPLE.m into the CommandWindow
% in MATLAB and hitting enter.

% This is the SpaceTransformation that describes the map between motor
% space and perceptual space
spaceTransformation = SpaceTransformation(@TransformationFunction);
    % @TransformationFunction is a reference to TransformationFunction,
    % which is at the bottom of this file.  MATLAB requires any function
    % definitions to be placed at the END of the file.

% These are the clusters that we will use for the space, with an 
% illustration of them included below.
Cluster1 = Cluster([1 2 3 1 2 3; 1 1 1 2 2 2], ...
    [1 2 3 1 2 3; 1 1 1 2 2 2]);
Cluster2 = Cluster([11 10 11 12 11; 9 10 10 10 11], ...
    [11 10 11 12 11; 9 10 10 10 11]);
Cluster3 = Cluster([0 1 2 1 2 3 2 3 4; 14 14 14 15 15 15 16 16 16], ...
    [0 1 2 1 2 3 2 3 4; 14 14 14 15 15 15 16 16 16]);
ClusterList = [Cluster1 Cluster2 Cluster3];

% % %                       MOTOR SPACE & PERCEPTUAL SPACE
% % %             
% % %            17 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %            16 | *  *  *  3  3  3  *  *  *  *  *  *  *  *  *  *
% % %            15 | *  *  3  3  3  *  *  *  *  *  *  *  *  *  *  *
% % %            14 | *  3  3  3  *  *  *  *  *  *  *  *  *  *  *  *
% % %            13 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %            12 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %            11 | *  *  *  *  *  *  *  *  *  *  *  *  2  *  *  *
% % %            10 | *  *  *  *  *  *  *  *  *  *  *  2  2  2  *  *
% % %             9 | *  *  *  *  *  *  *  *  *  *  *  *  2  *  *  *
% % %             8 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %             7 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %             6 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %   second    5 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % % coordinate  4 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %    axis     3 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %             2 | *  *  1  1  1  *  *  *  *  *  *  *  *  *  *  *
% % %             1 | *  *  1  1  1  *  *  *  *  *  *  *  *  *  *  *
% % %             0 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %            -1 | *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *
% % %               -------------------------------------------------
% % %                -1  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14  
% % %                         first
% % %                      coordinate
% % %                         axes

% Creating the space
space = Space(ClusterList, spaceTransformation);

% Creating regions for a motor silhouette
% First region
Vertices1 = [0 0; 6 0; 2 4];
    % There are 3 vertices (0, 0), (3, 0), and (0, 3)
VertexConnections1 = [1 2 3];
    % The triangle with vertices #1, #2, #3 is the only simplex
Weights1 = 1;
    % The weight of the simplex is 1
Region1 = WeightedMotorSimplicialComplex(Vertices1, VertexConnections1, ...
    Weights1);

% Second region
Vertices2 = [1 11; 5 11; 5 19; 1 19];
    % There are 4 vertices (1, 4), (5, 4), (5, 8), and (1, 8)
VertexConnections2 = [1 2 3; 1 3 4];
    % The triangle with vertices #1, #2, #3 is one simplex, and the triangle
    % with vertices #1, #3, #4 is the other simplex.
Weights2 = [1 2];
    % The weights of the simplices are 1 and 2 respectively.
Region2 = WeightedMotorSimplicialComplex(Vertices2, VertexConnections2, ...
    Weights2);

% Third region
Vertices3 = [10 7; 14 5; 12 12];
    % There are 3 vertices (6, 2), (9, 5), and (6, 5)
VertexConnections3 = [1 2 3];
    % The triangle with vertices #1, #2, #3 is the only simplex
Weights3 = 1;
    % The weight of the simplex is 1
Region3 = WeightedMotorSimplicialComplex(Vertices3, VertexConnections3, ...
    Weights3);


% Creating the motor silhouette
motorSilhouette = MotorSilhouette([Region1 Region2 Region3]);

% Creating an exemplar
exemplar = PerceptualTrajectory([ ...
    1 1 1 1 1 1 1.2 1.4 1.6 1.8  2.0  2.2  2.4  2.6  2.8  3.0  3.2  3.6  4.0  4.4  4.8  5.2  5.6  6.0  6.4  6.8  7.2  7.6 8.0 8.4 8.8 9.2 9.6; ...
    1 2 3 4 5 6 7.0 8.0 9.0 10.0 10.9 11.7 12.4 13.0 13.5 13.9 14.2 14.5 14.0 13.5 13.0 12.5 12.0 11.5 11.0 10.5 10.0 9.5 9.0 8.5 8.0 7.5 7.0]);

% Creating a goal from the space, silhouette, and exemplar
goal = Goal(space, motorSilhouette, exemplar);

executionParameters = ExecutionParameters(0, 0);
    % There is no anticipatory or perseveratory window

% Finding the result of executing the Goal goal with the
% ExecutionParameters executionParameters
[AverageJunctureEstimates, FinalJunctureActivationValues] = ...
    goal.SimpleMacroEstimates(executionParameters);

% Setting a variable plottingParameters, of type PlottingParameters,
% which will specify details of how things will be plotted -- for example,
% what colors will be used for various things.
plottingParameters = READMEPlottingParameters();

WindowState = "normal";
    % This is plugged in to FullFigureDataMotorResults, and ends up making
    % the WindowState property of the figure be "normal".  Often it is
    % convenient to make it "maximized" so that this doesn't have to be
    % done manually

% Create a FullFigureData object with the space and results, which will
% contain all the plotting information for the various objects -- clusters,
% silhouette, trajectories, ...
fullFigureDataMotorResults = FullFigureDataMotorResults( ...
    plottingParameters, goal, {AverageJunctureEstimates}, ...
    {FinalJunctureActivationValues}, 0, 1, 1, WindowState);

% Plots the figure via the FullFigureData object
fullFigureDataMotorResults.PlotFigures();

function PerceptualCoordinates = TransformationFunction(MotorCoordinates)
    % This transformation function specifies that motor space and
    % perceptual space have the same layout as one another.
    PerceptualCoordinates = MotorCoordinates;
end


