# Visualisation-Cross-Recurrence-Quantification-Analysis


**Lorenz_Attractor_Demo**

In 1963, Edward Lorenz developed a simplified mathematical model for atmospheric convection.[1] The model is a system of three ordinary differential equations now known as the Lorenz equations:

![](Lorenz_Attractor_Equation.svg)

Using the values ![equation](http://www.sciweavers.org/tex2img.php?eq=\sigma&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=) =10, (http://www.sciweavers.org/tex2img.php?eq=\beta&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=) =8/3 and (http://www.sciweavers.org/tex2img.php?eq=\rho&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=) =28

We got the chaotic motion:

![](Lorenz_Attractor_Point.gif)

**Lorenz_Attractor_Demo(Trajectory On)**

![](Lorenz_Attractor_Trajectory.gif)

**Resolve_Lorenz_Attractor**

We can get the three-dimensional time series.

![](Resolve_Lorenz_Attractor.gif)

**Phase_Space_Reconstruction**

Assumming that we only have one dimensional time series, we can still reconstruct the movement with time lagged embedding method based on Takens's embedding theory[2].

Here we use Embedding Dimension = 3, Time Lag = 5. The Embedding Dimension can be found with False Nearest Neighhood function. And Time Lag can be found with Average Mutual Information function.

![](Phase_Space_Reconstruct.gif)

**Recurrent_Plot_Distance**

We can calculate the distance between every two point in the trajectory.

![](Recurrent_Plot_Distance.gif)

**Recurrent_Plot_Thresholding**

By thresholding the distances, we can produce the Recurrence Plot[3].

![](Recurrent_Plot_Thresholding.gif)




**Reference**

[1] Lorenz, Edward Norton (1963). "Deterministic nonperiodic flow". Journal of the Atmospheric Sciences. 20 (2): 130–141. Bibcode:1963JAtS...20..130L. doi:10.1175/1520-0469(1963)020<0130:DNF>2.0.CO;2.

[2] F. Takens (1981). "Detecting strange attractors in turbulence". In D. A. Rand and L.-S. Young (ed.). Dynamical Systems and Turbulence, Lecture Notes in Mathematics, vol. 898. Springer-Verlag. pp. 366–381.

[3] J. P. Eckmann, S. O. Kamphorst, D. Ruelle (1987). "Recurrence Plots of Dynamical Systems". Europhysics Letters. 5 (9): 973–977. Bibcode:1987EL......4..973E. doi:10.1209/0295-5075/4/9/004.