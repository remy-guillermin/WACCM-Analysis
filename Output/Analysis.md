# Differences between Locations
First we can tell by looking at two plots (in `Output/Figures/`) comparing the same index that the two locations (Longyearbyen and Tromsø) have similar error magnitude for each height interval.

# Using the different indexes
For the analysis, we will both study the impact of the index itself and its gradient over time. We will also divide the measurements over 4 equals interval of 10 km in order to see the impact of the height on the error magnitude.


### DST Index
First let's define the DST Index (*Disturbance Storm Time Index*) is an index of magnetic activity derived from a network of near-equatorial geomagnetic observatories that measures the intensity of the globally symmetrical equatorial electrojet (the "ring current").[^1]

<div align="center">
  <img src="Figures/DST-all.png" alt="DST index" width="500">
  <p><strong>Index Visualization - DST</strong></p>
</div>

Here we can see that the DST index value itself doesn't seem to impact on the error magnitude. We can indeed tell that the higher we are, the lower the error is.

<div align="center">
  <img src="Figures/DST-gradient-all.png" alt="DST gradient index" width="500">
  <p><strong>Gradient Visualization - DST</strong></p>
</div>

The DST gradient is the only one that is not symetrical, we can clearly see that if the value is positive the error magnitude is way lower than if it is negative.

> [!IMPORTANT]
> Find more positive value of DST gradient to see if this behavior become more and more visible.
> 
> This might be hard to do because positive DST gradient dont go really high into positive as geomagnetic disturbance come back to normal state slowly compared top fast change when a geomagnetic storm occurs.

### Hp30 index
The geomagnetic Hp30 index is a Kp-like index with a time resolution of 30 minutes (another one exists with a time resolution of 60 minutes named Hp60). The main differences with Kp index is the time resolution (30 minutes against 3 hours) and the open scale for Hp30 compared to the capped at 9 Kp.[^2]

<div align="center">
  <img src="Figures/Hp30vsKp.png" alt="Comparison of Hpo indexes and Kp index." width="500">
  <p><strong> Comparison between indexes - Hp30 & DST</strong></p>
</div>

This plot shows that with Hpo indexes we get more precise informations about the magnitude of the geomagnetic event happening.

<div align="center">
  <img src="Figures/HP30-all.png" alt="Hp30 index" width="500">
  <p><strong>Index Visualization - Hp30</strong></p>
</div>

We can see a tendency for the error magnitude to be lower when the index is high, i.e. the geomagnetic storm is strong. 

> [!IMPORTANT]
> Add more different strong geomagnetic events to see if this tendency became more or less visible.
>
> It is possible to add either different years apart from 2004, 2008 and 2011 that I used in the first place, or different location for the known geomagnetic storms during these years.

<div align="center">
  <img src="Figures/HP30-gradient-all.png" alt="Hp30 gradient" width="500">
  <p><strong>Gradient Visualization - Hp30</strong></p>
</div>

Not a lot of things to say about the gradient, this is a common thing for all gradients beside the DST gradient.

### Auroral Electrojets Strength (SML, SMU & SME)
The SML, SMU and SME indices describe the same phenomenon, the only difference is that SML measure maximun Westward strength, where SMU measures Eastward strength and SME is the difference between Eastward and Westward. Both come from stations between 40° and 80° magnetic north but SML is from the lower envelope and SMU the upper envelope.[^3]

<div align="center">
  <img src="Figures/SMU-all.png" alt="SMU index" width="300">
  <img src="Figures/SML-all.png" alt="SML index" width="300">
  <p><strong>Index Visualization - SMU & SML</strong></p>
</div>

We can see a lower error magnitude when the electrojet strength is high (positive for SMU and negative for SML).
<div align="center">
  <img src="Figures/SML-all.png" alt="SME index" width="300">
  <p><strong>Index Visualization - SME</strong></p>
</div>

The same analysis can be done for SME.
<div align="center">
  <img src="Figures/SMU-gradient-all.png" alt="SMU gradient" width="300">
  <img src="Figures/SML-gradient-all.png" alt="SML gradient" width="300">
  <p><strong>Gradient Visualization - SMU & SML</strong></p>
</div>

We can see that we have a really strong presence around zero, meaning that the gradient for these two indices are really low, but for any stronger gradient the error magnitude is still lower.

<div align="center">
  <img src="Figures/SME-gradient-all.png" alt="SME Gradient" width="300">
  <p><strong>Gradient Visualization - SME</strong></p>
</div>

We can still tell that the height has an impact on the error magnitude, the higher the better, but we can also see that for high altitude we have a slope looking like $f(x) = A/|x|$.

> [!IMPORTANT]
> This assumption must be verified with more data from different year and/or observatories.

### Interplanetary Magnetic Field
The IMF is the Magnetic Field dragged out of the sun by the solar wind. [^4]

<div align="center">
  <img src="Figures/IMF-all.png" alt="IMF index" width="300">
  <p><strong>Index Visualization - IMF</strong></p>
</div>


[^1]: [National Oceanic and Atmospheric Administration](https://www.ngdc.noaa.gov/stp/geomag/dst.html#:~:text=The%20Disturbance%20Storm%20Time%20Index,the%20%22ring%20current%22).)

[^2]: [Solar Influences Data Analysis Center](https://www.sidc.be/article/hpo)

[^3]: [SuperMAG](https://supermag.jhuapl.edu/indices/?fidelity=low&layers=SME.UL&start=2001-01-29T23%3A00%3A00.000Z&step=14400&tab=about)

[^4]: [National Aeronautics and Space Administration](https://solarscience.msfc.nasa.gov/people/suess/Interstellar_Probe/IMF/IMF.html)
