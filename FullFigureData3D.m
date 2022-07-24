classdef FullFigureData3D
    properties
        AxesList; % All the axes
        ClusterXList; % All the Cluster x data, across axes, in the same
        % order as the axes are listed
        ClusterYList;
        ClusterZList;
        ClusterColorList;
        ClusterAlphaList;
        SilhouetteFaceList;
        SilhouetteVertexList;
        SilhouetteColorList;
        SilhouetteAlphaList;
        PerceptualTrajectoryXList;
        PerceptualTrajectoryYList;
        PerceptualTrajectoryZList;
        PerceptualTrajectoryColorList;
        ResultXList;
        ResultYList;
        ResultZList;
        ResultColorList;
        JunctureSizes;
        ResultPointSizes;
    end
    methods
        function obj = FullFigureData3D(axesList, clusterXList, ...
                clusterYList, clusterZList, clusterColorList, clusterAlphaList, ...
                silhouetteFaceList, silhouetteVertexList, ...
                silhouetteColorList, silhouetteAlphaList, ...
                trajectoryXList, trajectoryYList, trajectoryZList, trajectoryColorList, ...
                resultXList, resultYList, resultZList, resultColorList, ...
                junctureSizes, resultPointSizes)
            obj.AxesList = axesList;
            obj.ClusterXList = clusterXList;
            obj.ClusterYList = clusterYList;
            obj.ClusterZList = clusterZList;
            obj.ClusterColorList = clusterColorList;
            obj.ClusterAlphaList = clusterAlphaList;
            obj.SilhouetteFaceList = silhouetteFaceList;
            obj.SilhouetteVertexList = silhouetteVertexList;
            obj.SilhouetteColorList = silhouetteColorList;
            obj.SilhouetteAlphaList = silhouetteAlphaList;
            obj.PerceptualTrajectoryXList = trajectoryXList;
            obj.PerceptualTrajectoryYList = trajectoryYList;
            obj.PerceptualTrajectoryZList = trajectoryZList;
            obj.PerceptualTrajectoryColorList = trajectoryColorList;
            obj.ResultXList = resultXList;
            obj.ResultYList = resultYList;
            obj.ResultZList = resultZList;
            obj.ResultColorList = resultColorList;
            obj.JunctureSizes = junctureSizes;
            obj.ResultPointSizes = resultPointSizes;
        end

        function PlotFigures(obj)

            % For each axes, plot the appropriate things -- clusters first,
            % then silhouette, then perceptual trajectory, then result

            for ax = 1:length(obj.AxesList)
                CurrentAxes = obj.AxesList{ax,1};
                hold(CurrentAxes, "on");
            end
            for n = 1:length(obj.AxesList)
                % Clusters
                if ~isempty(obj.ClusterXList{n,1})
                    scatter3(obj.AxesList{n,1}, obj.ClusterXList{n,1}, ...
                        obj.ClusterYList{n,1}, obj.ClusterZList{n,1}, ...
                        obj.JunctureSizes, ...
                        obj.ClusterColorList{n,1}, "filled", ...
                        "MarkerFaceAlpha", "flat", ...
                        "MarkerEdgeAlpha", "flat", ...
                        "AlphaDataMapping", "none", ...
                        "AlphaData", obj.ClusterAlphaList{n,1});
                end
                % Silhouette
                if ~isempty(obj.SilhouetteFaceList{n,1})
                    patch(obj.AxesList{n,1}, "Faces", ...
                        obj.SilhouetteFaceList{n,1}, "Vertices", ...
                        obj.SilhouetteVertexList{n,1}, "FaceVertexCData", ...
                        obj.SilhouetteColorList{n,1}, ...
                        "FaceColor", "flat", "EdgeColor", [1 1 1], ...
                        "FaceVertexAlphaData", obj.SilhouetteAlphaList{n,1}, ...
                        "FaceAlpha", "flat", "AlphaDataMapping", "none");
                end
                % PerceptualTrajectory
                if ~isempty(obj.PerceptualTrajectoryXList{n,1})
                    scatter3(obj.AxesList{n,1}, obj.PerceptualTrajectoryXList{n,1}, ...
                        obj.PerceptualTrajectoryYList{n,1}, obj.PerceptualTrajectoryZList{n,1}, ...
                        obj.ResultPointSizes, ...
                        obj.PerceptualTrajectoryColorList{n,1}, "filled");
                end
                % Results
                if ~isempty(obj.ResultXList{n,1})
                    scatter3(obj.AxesList{n,1}, obj.ResultXList{n,1}, ...
                        obj.ResultYList{n,1}, obj.ResultZList{n,1}, obj.ResultPointSizes, ...
                        obj.ResultColorList{n,1}, "filled");
                end
            end
        end

        function EnterInteractionMode(obj)
            fprintf("Type a, enter to rotate left\n d, enter to rotate right \n exit, enter to exit this mode\n");
            rotation = input("< a | d > : ", "s");
            while (rotation ~= "exit")
                if rotation == "a"
                    obj.RotateLeft();
                elseif rotation == "d"
                    obj.RotateRight();
                else
                    fprintf("%s is not an allowed input", rotation);
                end
                rotation = input("< a | d > : ", "s");
            end
        end

        function RotateLeft(obj)
            for axesIndex = 1:length(obj.AxesList)
                obj.AxesList{axesIndex}.View = obj.AxesList{axesIndex}.View + [-15 0];
            end
        end

        function RotateRight(obj)
            for axesIndex = 1:length(obj.AxesList)
                obj.AxesList{axesIndex}.View = obj.AxesList{axesIndex}.View + [15 0];
            end
        end

        function RotateUp(obj)
            for axesIndex = 1:length(obj.AxesList)
                obj.AxesList{axesIndex}.View = obj.AxesList{axesIndex}.View + [0 15];
            end
        end

        function RotateDown(obj)
            for axesIndex = 1:length(obj.AxesList)
                obj.AxesList{axesIndex}.View = obj.AxesList{axesIndex}.View + [0 -15];
            end
        end
    end
end