# Differences between Locations
First we can tell by looking at two plots (in `Output/Figures/`) comparing the same index that the two locations (Longyearbyen and Tromsø) have similar error magnitude for each height interval.

# Using the different indexes
For the analysis, we will both study the impact of the index itself and its gradient over time. We will also divide the measurements over 4 equals interval of 10 km in order to see the impact of the height on the error magnitude.


### DST Index
First let's define the DST Index (*Disturbance Storm Time Index*) is an index of magnetic activity derived from a network of near-equatorial geomagnetic observatories that measures the intensity of the globally symmetrical equatorial electrojet (the "ring current").[^1]

<p align="center">
  <img src="Figures/DST-all.png" alt="DST index" width="500">
</p>

Here we can see that the DST index value itself doesn't seem to impact on the error magnitude. We can indeed tell that the higher we are, the lower the error is.

<p align="center">
  <img src="Figures/DST-gradient-all.png" alt="DST gradient index" width="500">
</p>

The DST gradient is the only one that is not symetrical, we can clearly see that if the value is positive the error magnitude is way lower than if it is negative.





[^1]: [National Oceanic and Atmospheric Administration](https://www.ngdc.noaa.gov/stp/geomag/dst.html#:~:text=The%20Disturbance%20Storm%20Time%20Index,the%20%22ring%20current%22).)
