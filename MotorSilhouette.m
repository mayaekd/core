%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% METHOD LIST
%
%  MotorSilhouette
%
%  DROPOFF FUNCTIONS FOR LOOKBACK & LOOKAHEAD WINDOWS
%  DropoffScalar
%  DropoffScalarConcave
%
%  EXPAND MOTOR SILHOUETTE
%  ExpandSilhouette
%
%  PLOTTING INFO AND PLOTTING
%  TemporalActivationInfo
%  PlottingInfo3D
%  PlottingInfo
%  Plot

%% CLASS DEFINITION
classdef MotorSilhouette
    % A motor silhouette consists of its timestamps & region at each time
    
    %% PROPERTIES
    properties
        Regions;
    end
    
    %% METHODS
    methods
        % Creating an object
        function obj = MotorSilhouette(MotorRegions)
            obj.Regions = MotorRegions;
        end
        
        %% DROPOFF FUNCTIONS FOR LOOKBACK & LOOKAHEAD WINDOWS
        %  DropoffScalar
        %  DropoffScalarConcave
        % Takes a time distance as an input, and gives as an output a
        % scalar that represents the weight that should be given to the
        % part of the motor silhouette that is that time distance away from
        % the present.

        % Default dropoff function -- references one of the ones below
        function ScalarMultiplier = DropoffScalar(obj, TimeDistance, ...
                LookAheadWindow, LookBackWindow)
            ScalarMultiplier = obj.DropoffScalarConcave(TimeDistance, ...
                LookAheadWindow, LookBackWindow, 2);
        end
        
        % Drops off concavely, i.e. faster at first and then slower.  The
        % higher Power is, the closer the dropoff is to just a step 
        % function that goes from 1 to 0.  If Power = 1, then it just drops
        % off linearly.
        function ScalarMultiplier = DropoffScalarConcave(~, ...
                TimeDistance, LookAheadWindow, LookBackWindow, Power)
            % Adding one to these first is the easiest way to run this
            % algorithm
            LookAheadWindow = LookAheadWindow + 1;
            LookBackWindow = LookBackWindow + 1;
            % TimeDistance is positive if we're looking forward in time and
            % negative if we're looking backward in time
            if TimeDistance > -LookBackWindow
                if TimeDistance > 0
                    if TimeDistance < LookAheadWindow
                        % TimeDistance is between 0 and LookAheadWindow
                        ScalarMultiplier = ...
                            (1 - (TimeDistance/LookAheadWindow))^Power;
                    else
                        % TimeDistance is greater than or equal to
                        % LookAheadWindow
                        ScalarMultiplier = 0;
                    end
                else
                    % TimeDistance is between -LookBackWindow and 0
                    ScalarMultiplier = ...
                        (1 - (-TimeDistance/LookBackWindow))^Power;
                end
            else
                % TimeDistance is less than or equal to -LookBackWindow
                ScalarMultiplier = 0;
            end
        end

        %% EXPAND MOTOR SILHOUETTE
        %  ExpandSilhouette
        function ExpandedSilhouette = ExpandSilhouette(obj, motorTrajectory)
            % For now, the motorTrajectory has to have the same length as
            % the silhouette
            assert(size(motorTrajectory.CoordinateMatrix, 2) == length( ...
                obj.Regions), "The motor silhouette is " + ...
                length(obj.Regions) + " time steps long but the " + ...
                "trajectory is " + ...
                size(motorTrajectory.CoordinateMatrix, 2) + ...
                " time steps long");
            NewRegions = WeightedMotorSimplicialComplex.empty(0, length(obj.Regions));
            for t = 1:length(obj.Regions)
                NewRegion = obj.Regions(t).Expand(motorTrajectory.CoordinateMatrix(:, t));
                NewRegions(t) = NewRegion;
            end
            ExpandedSilhouette = MotorSilhouette(NewRegions);
        end

        %% PLOTTING INFO AND PLOTTING
        %  TemporalActivationInfo
        %  PlottingInfo3D
        %  PlottingInfo
        %  Plot
        % Time-varying activation info: the output, ActivationValuesCell is
        % a cell array such that ActivationValuesCell{t,1} will be 
        % something like [0; 0.5; 1; 0.5; 0; 0], which would mean that at 
        % time t, the motor silhouette is fully active at the third region, 
        % half active at the 2nd and 4th regions, and not active at the 
        % 1st, 5th, and 6th regions.  This activation would be determined 
        % by the dropoff function.
        function ActivationValuesMatrix = ...
                TemporalActivationInfo(obj, LookBackAmt, LookAheadAmt)
            % Inititalize ActivationValuesCell to the right size -- the 
            % number of time steps.  
            ActivationValuesMatrix = nan(length(obj.Regions), length(obj.Regions));
            for t = 1:size(ActivationValuesMatrix, 1)
                % Find the span of the window for which the activation is 
                % nonzero -- will be a little tricky at the beginning and 
                % end -- a is the beginning of the window and b is the end
                a = max(1, t - LookBackAmt);
                b = min(length(ActivationValuesMatrix), t + LookAheadAmt);
                
                % Initialize the set of activation values that will go in
                % these units in the cells; t is the index of the main
                % region (maximal activation, unless we're using an unusual
                % dropoff function), and then we'll go from t - LookBackAmt
                % to t + LookAheadAmt, but making sure not to go past the 
                % end of the silhouette on either side.  Note: we'll have 
                % zeros for activation values outside of the range a to b
                CurrentActivationValues = zeros(length(obj.Regions),1);
                % Fill in the values according to the DropoffScalar
                % function
                for RegionIndex = a:b
                    Distance = RegionIndex - t;
                    Activation = obj.DropoffScalar(Distance, ...
                        LookAheadAmt, LookBackAmt);
                    CurrentActivationValues(RegionIndex, 1) = Activation; 
                end
                ActivationValuesMatrix(t,:) = CurrentActivationValues;
            end
        end
        
        % Vertex and face data for plotting the silhouette using the patch
        % function -- this will be the plotting info for plotting it as a
        % sequence of polygons, with the number of vertices specified as an
        % input.
        % EXAMPLE: If we want to plot a triangle with vertices (1,1) (2,2)
        % and (2,1) and a square with vertices (3,3) (4,3) (4,4) and (3,4),
        % then we want:
        % VertexData = [1 1; 2 2; 2 1; 3 3; 4 3; 4 4; 3 4]
        % FaceData = [1 2 3 NaN; 4 5 6 7]
        function [VertexData, FaceData, AlphaData] = PlottingInfo3D(obj, AlphaMin, AlphaMax)
            TotalNumVertices = 0;
            TotalNumFaceRows = 0;
            MaxNumVertices = 0;
            for t = 1:length(obj.Regions)
                CurrentNumVertices = size(obj.Regions(t).MotorVertexList, 1);
                TotalNumVertices = TotalNumVertices + CurrentNumVertices;
                MaxNumVertices = max(MaxNumVertices, CurrentNumVertices);
                CurrentNumFaceRows = size(obj.Regions(t).SimplexMatrix, 1);
                TotalNumFaceRows = TotalNumFaceRows + CurrentNumFaceRows;
            end
            NumCoordinates = size(obj.Regions(1).MotorVertexList, 2);

            % Initializing outputs to be the right sizes
            VertexData = zeros(TotalNumVertices, NumCoordinates);
            FaceData = nan(TotalNumFaceRows, MaxNumVertices);
            AlphaData = zeros(TotalNumFaceRows, 1);

            % Starting filling in outputs
            StartingVertexIndex = 1;
            StartingFaceIndex = 1;
            NumVerticesSoFar = 0;
            for t = 1:length(obj.Regions)
                [CurrentFaceData, CurrentVertexData, CurrentAlphaData] = ...
                    obj.Regions(t).PlottingInfo("AlphaMin", AlphaMin, "AlphaMax", AlphaMax);

                % Vertex stuff
                CurrentNumVertices = size(CurrentVertexData, 1);
                EndingVertexIndex = StartingVertexIndex + CurrentNumVertices - 1;
                VertexData(StartingVertexIndex:EndingVertexIndex,:) = CurrentVertexData;

                % Face stuff
                ModifiedFaceData = CurrentFaceData + NumVerticesSoFar;
                CurrentNumFaceRows = size(ModifiedFaceData, 1);
                EndingFaceIndex = StartingFaceIndex + CurrentNumFaceRows - 1;
                FaceData(StartingFaceIndex:EndingFaceIndex, 1:size(ModifiedFaceData, 2)) = ModifiedFaceData;

                % Alpha stuff (based on face indices)
                AlphaData(StartingFaceIndex:EndingFaceIndex) = CurrentAlphaData;

                % Incrementing indices
                NumVerticesSoFar = NumVerticesSoFar + CurrentNumVertices;
                StartingVertexIndex = EndingVertexIndex + 1;
                StartingFaceIndex = EndingFaceIndex + 1;
            end
        end

        % Vertex and face data for plotting the silhouette using the patch
        % function -- this will be the plotting info for plotting it as a
        % sequence of polygons, with the number of vertices specified as an
        % input.
        % EXAMPLE: If we want to plot a triangle with vertices (1,1) (2,2)
        % and (2,1) and a square with vertices (3,3) (4,3) (4,4) and (3,4),
        % then we want:
        % VertexData = [1 1; 2 2; 2 1; 3 3; 4 3; 4 4; 3 4]
        % FaceData = [1 2 3 NaN; 4 5 6 7]
        function [VertexData, FaceData, AlphaData] = PlottingInfo(obj, AlphaMin, AlphaMax)
            % Finding necessary sizes of things
            TotalNumVertices = 0;
            TotalNumFaceRows = 0;
            MaxNumVertices = 0;
            for t = 1:length(obj.Regions)
                CurrentNumVertices = size(obj.Regions(t).MotorVertexList, 1);
                TotalNumVertices = TotalNumVertices + CurrentNumVertices;
                MaxNumVertices = max(MaxNumVertices, CurrentNumVertices);
                CurrentNumFaceRows = size(obj.Regions(t).SimplexMatrix, 1);
                TotalNumFaceRows = TotalNumFaceRows + CurrentNumFaceRows;
            end
            NumCoordinates = size(obj.Regions(1).MotorVertexList, 2);

            % Initializing outputs to be the right sizes
            VertexData = zeros(TotalNumVertices, NumCoordinates);
            FaceData = nan(TotalNumFaceRows, MaxNumVertices);
            AlphaData = zeros(TotalNumFaceRows, 1);

            % Starting filling in outputs
            StartingVertexIndex = 1;
            StartingFaceIndex = 1;
            NumVerticesSoFar = 0;
            for t = 1:length(obj.Regions)
                [CurrentFaceData, CurrentVertexData, CurrentAlphaData] = ...
                    obj.Regions(t).PlottingInfo("AlphaMin", AlphaMin, "AlphaMax", AlphaMax);

                % Vertex stuff
                CurrentNumVertices = size(CurrentVertexData, 1);
                EndingVertexIndex = StartingVertexIndex + CurrentNumVertices - 1;
                VertexData(StartingVertexIndex:EndingVertexIndex,:) = CurrentVertexData;

                % Face stuff
                ModifiedFaceData = CurrentFaceData + NumVerticesSoFar;
                CurrentNumFaceRows = size(ModifiedFaceData, 1);
                EndingFaceIndex = StartingFaceIndex + CurrentNumFaceRows - 1;
                FaceData(StartingFaceIndex:EndingFaceIndex, 1:size(ModifiedFaceData, 2)) = ModifiedFaceData;

                % Alpha stuff (based on face indices)
                AlphaData(StartingFaceIndex:EndingFaceIndex) = CurrentAlphaData;

                % Incrementing indices
                NumVerticesSoFar = NumVerticesSoFar + CurrentNumVertices;
                StartingVertexIndex = EndingVertexIndex + 1;
                StartingFaceIndex = EndingFaceIndex + 1;
            end
        end
        
        % Plotting the whole silhouette with full opacity, on axes (input), 
        % as a series of polygons with NumberOfVertices vertices (input), 
        % the color given by ColorRBG (input)
        % FIX
        function WholeSilhouettePlot = Plot(obj, axes, ColorRBG)
            % Plots the silhouette 

            % Expand ColorRBG into a larger array that is the appropriate
            % length
            ColorArray = zeros(length(obj.Regions),3);
            for t = 1:length(obj.Regions)
                ColorArray(t,:) = ColorRBG;
            end

            % Vertex & Face Data
            [VertexData, FaceData, AlphaData] = obj.PlottingInfo();

            % AlphaArray are the opacity values, which are all 1 (fully
            % opaque) in this case
            AlphaArray = ones(length(obj.Regions),1);
            
            % Plotting
            hold(axes, "on");
            for t = 1:length(VertexData)
                CurrentVertexData = VertexData(t);
                WholeSilhouettePlot = patch(axes, ...
                    "Vertices", CurrentVertexData, ...
                    "Faces", ...
                    "FaceVertexCData", ColorArray, ...
                    "FaceColor", "flat", "EdgeColor", "none", ...
                    "FaceVertexAlphaData", AlphaArray, "FaceAlpha", ...
                    "flat", "AlphaDataMapping", "none");
            end
        end
        
    end
end
