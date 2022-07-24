********************************************
********************************************
                  README
********************************************
********************************************

NOT ALL COMMENTS IN CODE ARE UP TO DATE.  This file and README_EXAMPLE 
are currently the best guides.

The program is intended primarily to be used for finding, according to 
our model, the outcome of the execution of a speech goal, where the 
user provides:
Motor space and perceptual space, populated with clusters
The motor goal i.e. the silhouette
The perceptual goal i.e. the exemplar
Optionally, a few parameters

This model can be used with real data, or it can be used with made-up 
values as a demonstration of how it works/visualization of the model.  
A few sets of made-up values are provided for the convenience of the user.

Additionally, parameters that are embedded deeper in the model, or more 
fundemental aspects of how the model works, may be changed by changing 
the code directly.  An effort has been made to make the code 
straightforward, readable, and heavily commented so that this is possible.

A more narrative description is given below; if you would prefer to 
start exploring by running code immediately, checkout the file 
README_EXAMPLE.m

If someone wants to use this program to find the outcome of the 
execution of a speech goal according to our model, they will need to 
first decide what the Space is.  A Space object is the computational 
model's representation of motor space and perceptual space as well as 
the link between them.  In particular, the Space consists of 
- A Cluster array
- A SpaceTransformation
That is, to make an instance space of type Space, we write:

space = Space(clusterArray, spaceTransformation)

Each Cluster is defined in terms of the motor and perceptual 
coordinates of its Junctures -- so the user must decide what the motor 
dimensions andthe perceptual dimensions are, and then what the 
Junctures in each Clusterare in terms of these coordinates.  We write:

cluster = Cluster(MotorCoordinateMatrix, PerceptualCoordinateMatrix).  
There are also some optional arguments that will determine which 
dimensions of the Cluster are used when graphing (detailed in the 
Cluster file).

The SpaceTransformation is the function that takes a motor coordinates 
as an input and gives the corresponding perceptual coordinates as the 
output. This transformation is not known to the speaker, but it must be 
known to the modeler in order to model the consequences of perceptual 
outcomes from motor actions (essentially in order to simulate the 
perceptual consequences of speaking).

spaceTransformation = SpaceTransformation(@TransformationFunction)

where TransformationFunction is a matlab function.  The "@" in the 
front is necessary since it is a function.  TransformationFunction must 
be defined in a place that is accessible to the above definition -- in 
the same file, or as the main function in a file in the path.  That 
definition will look like:

function PerceptualCoordinates = TransformationFunction(MotorCoordinates)
    % definition goes here -- e.g.
    % PerceptualCoordinates = MotorCoordinates;
    % OR    
    % PerceptualCoordinates = (2 * MotorCoordinates) - 5;
    % OR    
    % PerceptualCoordinates(1) = MotorCoordinates(1) * MotorCoordinates(2);
    % PerceptualCoordinates(2) = MotorCoordinates(3)^2 - MotorCoordinates(2);
end

A specific space will be specified for each goal, since a goal cannot 
exist without the context of the space (linked perceptual and motor 
spaces) in which the goal lies.  Other than the space, the other two 
things that a goal consists of are
- a silhouette (MotorSilhouette object; the motor goal)
- an exemplar (PerceptualTrajectory object; the percdeptual goal).
That is, we write
goal = Goal(space, silhouette, exemplar)

We've covered what space looks like.  Now we'll describe the 
silhouette.  The silhouette consists of a series of T regions, where 
each region corresponds to a particular time in the silhouette.  We 
write
silhouette = MotorSilhouette(MotorRegions)
where, for example, MotorRegions = [Region1 Region2 Region3] (with more 
or fewer regions). Region1, Region2, and Region3 are all objects of 
type WeightedMotorSimplicialComplex, which is an object that specifies 
a homogenous simplicial complex in motor space along with a weight 
assigned to each simplex.

Finally, the exemplar is a perceptual trajectory -- that is, a series 
of points in perceptual space.  We write exemplar = 
PerceptualTrajectory(PerceptualCoordinateMatrix), and there are also 
some optional arguments, detailed in the PerceptualTrajectory file.

Once the goal is defined, now it is possible to use the program to find 
the results of executing that goal.  There are just a few more 
parameters that need to be chosen first, and this will be done by 
creating an ExecutionParameters object:

executionParameters = ExecutionParameters(LookBackAmount, LookAheadAmount)

If the code were to be modified to include more global-speaking-setting 
type parameters (for example, speaking rate, clarity of speech, etc.) 
this object would be the appropriate place to add those parameters 
to -- they don't belong in the space itself, and they don't belong in 
the goal -- they really are external to those things, and they belong 
in the set of parameters that are independent from those things and 
that could be chosen differently for different utterances based on the 
same goal.

To find the final results, we write
[AverageJunctureEstimates, FinalJunctureActivationValues] = 
goal.SimpleMacroEstimates(executionParameters)

FinalJunctureActivationValues is a matrix where 
FinalJunctureActivationValues(j, t) is the activation of the jth 
juncture at the tth time step.  AverageJunctureEstimates is a vector 
where AverageJunctureEstimates(t) is the estimated location in motor 
space and perceptual space at time t, written in juncture format.  That 
is, AverageJunctureEstimates(t) is a juncture J such that 
J.MotorPoint.Coordinates is the estimated motor coordinates at time t, 
and J.PerceptualPoint.Coordinates is the estimated perceptual 
coordinates at time t.

This is all the information that is necessary to plot the results, 
which can be plotted using a FullFigureData object -- this is done in 
the README_EXAMPLE file.
