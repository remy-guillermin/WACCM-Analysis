# WACCM-Analysis
Analysis of the WACCM[^1] Model of particle precipitation in the ionosphere.

## Goals of the project
- Plot measured electron density profiles together with approximately simultaneous model electron density profiles.
- Describe differences in active and quiet ionospheric conditions.
- Find relation with different values (DST index[^2], hp30 Index[^3], IMF[^4], Wind Speed, SML[^5], SMU[^6], SME[^7], Densities value, Densities gradient and Height have been tested) (Latitude of the instrument might be possible)

## Informations
### Global informations
1) Experiments data
   - Mostly EISCAT[^8] measurements.
   - _May be possible to use data from other organisation_.
   - Sporadic measurements with variable height and time resolution.
   - Data is downloaded through the EISCAT website.
2) WACCM data
   - Data exist for more than 30 years and saved into ~250 MB files.
   - 3 Differents runs
     - NOSPE: Without energetic electrons or protons.
     - SPE: With energetic solar protons only.
     - EEPSPE: With both energetic protons and electrons.
   - Mixing ratio as a function of pressure levels as input.
   - No height resolution and half an hour time resolution.
3) Starting point
   - Years 2004, 2008 and 2011 have Geomagnetic Storms[^9] and Solar Proton[^10] events (See [here](Event-Informations.md)).
   - Convert both datasets into comparable format (i.e. height and time grid with fixed bins)
4) Code explanation and Analysis
   - Code explanation [here](Scripts/Description.md)
   - Analysis [here](Output/Analysis.md)
5) Known improvements
   - Currently,
      - a day is considered a geomagnetic or a solar proton event even if only 1 hour is the actual event.
      - an EISCAT measurements is accounted into a bin only if its starting height is within the bin.
   - Only 15 out of 338 events are active events, we need more data on other year to get more precise comparison with indices.
   - If the output `csv` file becomes too large, it is possible to remove all zeros rows but this would mean to change all analysis after.
  
## Sources
- EISCAT: [EISCAT website](https://portal.eiscat.se/schedule/?year=2004&month=1&A=on&TRO=on&ESR=on)
- DST Index: [Kyoto Dst index service](https://wdc.kugi.kyoto-u.ac.jp/dst_final/index.html)
- Hp30 Index: [GFZ website](https://kp.gfz-potsdam.de/en/data#c222)
- IMF & Wind Speed: [Omniweb website](https://omniweb.gsfc.nasa.gov/form/omni_min_def.html)
- SML & SMU: [SuperMAG website](https://supermag.jhuapl.edu/indices/?fidelity=low&layers=SME.UL&start=2001-01-29T23%3A00%3A00.000Z&step=14400&tab=plot)
  
## Contributors
- Rémy Guillermin (University Centre in Svalbard, 2024) supervised by Noora Partamies


> [!IMPORTANT]  
> If you were to work on this project, email me at [remy.guillermin.73\@gmail.com](mailto:remy.guillermin.73@gmail.com?subject=WACCM%20Github%20Access%20Request) with your Github username, full name, or email so I can give you writing access to the github.

[^1]: Whole Atmosphere Community Climate Model.
[^2]: Disturbance Storm Time index, 1 hour resolution.
[^3]: Geomagnetic activity index, 30 minutes resolution.
[^4]: Interplanetary Magnetic Field.
[^5]: Maximum westward auroral electrojets strength.
[^6]: Maximum eastward auroral electrojets strength.
[^7]: SMU - SML
[^8]: European Incoherent Scatter Scientific Association.
[^9]: Temporary disturbance of the Earth's magnetosphere caused by a solar wind shock wave.
[^10]: Emission of protons by the Sun, accelerated either in the Sun's atmosphere during a solar flare or in interplanetary space by a coronal mass ejection shock.
