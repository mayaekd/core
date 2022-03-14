%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Model, 2022
% Written by Maya Davis
% Concept by Maya Davis and Melissa A. Redford
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Standard PlottingParameters

green1 = [0 1 0];
green2 = [0 0.9 0];
green3 = [0 0.8 0];
forestgreen1 = [0 0.8 0.1];
forestgreen2 = [0 0.8 0.2];
forestgreen3 = [0 0.8 0.3];
turquoise1 = [0 0.8 0.4];
turquoise2 = [0 0.9 0.5];
turquoise3 = [0 1 0.5];
teal1 = [0 1 0.6];
teal2 = [0 1 0.7];
teal3 = [0 1 0.8];
cyan1 = [0 1 0.9];
cyan2 = [0 1 1];
cyan3 = [0 0.9 1];
skyblue1 = [0 0.8 1];
skyblue2 = [0 0.7 1];
skyblue3 = [0 0.6 1];
magicdust1 = [0 0.5 1];
magicdust2 = [0 0.4 1];
magicdust3 = [0 0.3 1];
blue1 = [0 0.2 1];
blue2 = [0 0.1 1];
blue3 = [0 0 1];
violet1 = [0.1 0.1 1];
violet2 = [0.2 0.2 1];
violet3 = [0.3 0.3 1];
periwinkle1 = [0.4 0.4 1];
periwinkle2 = [0.5 0.5 1];
periwinkle3 = [0.5 0.6 1];
babyblue1 = [0.5 0.7 1];
babyblue2 = [0.5 0.8 1];
babyblue3 = [0.5 0.9 1];
ice1 = [0.5 1 1];
ice2 = [0.6 0.9 1];
ice3 = [0.7 0.8 1];
babypink1 = [0.8 0.7 1];
babypink2 = [0.9 0.6 1];
babypink3 = [1 0.5 1];
pink1 = [1 0.4 1];
pink2 = [1 0.3 1];
pink3 = [1 0.2 1];
magenta1 = [1 0.1 1];
magenta2 = [1 0 1];
magenta3 = [1 0 0.9];
fuschia1 = [1 0 0.8];
fuschia2 = [1 0 0.7];
fuschia3 = [1 0 0.6];
hibiscus1 = [1 0 0.5];
hibiscus2 = [1 0 0.4];
hibiscus3 = [1 0 0.3];
strawberry1 = [1 0 0.2];
strawberry2 = [1 0 0.1];
strawberry3 = [1 0 0];
red1 = [1 0.1 0];
red2 = [1 0.2 0];
red3 = [1 0.3 0];
orange1 = [1 0.4 0];
orange2 = [1 0.5 0];
orange3 = [1 0.6 0];
salmon1 = [1 0.7 0];
salmon2 = [1 0.7 0.1];
salmon3 = [1 0.7 0.2];
salmon4 = [1 0.7 0.3];
coral1 = [1 0.4 0.2];
coral2 = [1 0.4 0.4];
coral3 = [1 0.4 0.6];


clusterColorArray = [green1; green2; green3; forestgreen1; forestgreen2; 
    forestgreen3; turquoise1; turquoise2; turquoise3; teal1; teal2; 
    teal3; cyan1; cyan2; cyan3; skyblue1; skyblue2; skyblue3; magicdust1; 
    magicdust2; magicdust3; blue1; blue2; blue3; violet1; violet2; violet3; 
    periwinkle1; periwinkle2; periwinkle3; babyblue1; babyblue2; babyblue3; 
    ice1; ice2; ice3; babypink1; babypink2; babypink3; pink1; pink2; pink3; 
    magenta1; magenta2; magenta3; fuschia1; fuschia2; fuschia3; hibiscus1; 
    hibiscus2; hibiscus3; strawberry1; strawberry2; strawberry3; red1; 
    red2; red3; orange1; orange2; orange3; salmon1; salmon2; salmon3; 
    salmon4];

% clusterColorArray = [green1; coral3; babyblue2; blue1; magenta1; ...
%     skyblue2; ice1; strawberry1; cyan1; violet2; babypink3; hibiscus3; ...
%     teal1; magicdust2; periwinkle3; pink2; hibiscus2; turquoise2; ...
%     skyblue3; periwinkle1; babypink2; salmon1; fuschia3; orange1; turquoise1; ...
%     cyan3; blue3; babyblue3; pink3; hibiscus1; red3; forestgreen2; ...
%     teal2; skyblue1; blue2; periwinkle2; salmon2; babypink1; magenta3; ...
%     strawberry2; red2; orange2; green2; forestgreen1; turquoise3; ...
%     cyan2; magicdust3; violet3; ice2; pink1; fuschia1; strawberry3; ...
%     coral1; green3; forestgreen3; teal3; salmon3; magicdust1; violet1; ...
%     babyblue1; ice3; magenta2; fuschia2; red1; orange3; coral2];


motorSilhouetteColor1 = magicdust3;
motorSilhouetteColor2 = magicdust3;
perceptualTrajectoryColor1 = blue2;
perceptualTrajectoryColor2 = pink3;
resultTrajectoryColor1 = hibiscus1;
resultTrajectoryColor2 = salmon1;
visiblePointsPerStep = 10;
junctureSizes = 100;
resultPointSizes = 150;
numberOfSilhouetteVertices = 8;

standardPlottingParameters = PlottingParameters(clusterColorArray, ...
                motorSilhouetteColor1, motorSilhouetteColor2, ...
                perceptualTrajectoryColor1, perceptualTrajectoryColor2, ...
                resultTrajectoryColor1, resultTrajectoryColor2, ...
                visiblePointsPerStep, junctureSizes, resultPointSizes, ...
                numberOfSilhouetteVertices);
