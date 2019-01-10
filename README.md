# PoissonImageEditing
Solutions to questions using approaches stated in the paper Poisson Image Editing by P. Pérez, M. Gangnet, and A. Blake, Siggraph 2003

http://www.irisa.fr/vista/Papers/2003_siggraph_perez.pdf

Use help to find more information...


Questions:

Task 1
Select a grayscale image. 
Mark out a region using a polygon (you can use rpoly). 
Remove the selected region and fill it in using the Equation (2) in the paper. 
You are solving for unknown intensity values inside the region R. 
Test the method in smooth regions and also in regions with edges (high-frequency). 
Also report the behavior as the size of the selected region increases.

Task 2 
Now we are ready to try ‘seamless cloning’. The relevant Equations are (9) to (11). 
Perform both versions:
* (a) importing gradients 
* (b) mixing gradients.

Task 3 
Repeat task 2a for color images. You have to process R, G, B components separately.

Task 4 
Select images you like to edit and show interesting effects. 
Try to record the intermediate results; 
you can allow multiple strokes in this stage. 
Try to create some ‘cool’ effects.

Task 5 
Implement only one of the selection editing effects described in Section 4 of the paper. 
You can decide between: texture flattening, local illumination changes, local colour changes or seamless tiling.
... I chose texture flattening



