# sort.ipynb
This script shall be used first to sort all experiment data files into folder if this cannot be done by hand.

# TESThdf5.ipynb
The purpose of this script is purely to understand the structure of the hdf5 file. EISCAT gives us two different structure to work with, the files that start with `MAD6***` are the ones that we will use for EISCAT data and they are structured like the following:
```json
{
  "Data": {
    "Table Layout" : []
  },
  "Metadata": {
    "Data Parameters" : [],
    "Experiment Notes" : [],
    "Experiment Parameters" : [],
    "Independent Spatial Parameters" : [],
    "_record_layout" : []
  }
}
```

# TESTnc.ipynb
WACCM files are dictionaries that contains a lot of different variables and for the whole earth, this is why they are around 250 MB each. 
This script allows us first to print all the keys of the dictionary so we can visually see what the model produce.
We will only use the following keys.
```python
[
    "instr_lat": [],  # Latitude of the instrument
    "instr_lon": [],  # Longitude of the instrument
    "instr_num": [],  # Instrument number
    "obs_date": [],  # Observation date
    "obs_time": [],  # Observation time
    "lev": [],  # Pressure levels
    "e": [],  # Mixing ratio
    "T": []  # Temperature
]
```
Next we want to produce a graphe of the electron density to see if we can extract the data from the file, for that we need to get only data for either Svalbard or Tromsø Radar, for that we create a mask on the latitude because there is not another radar for each interval. After that we can produce the final plot:

![output](https://github.com/remy-guillermin/WACCM-Analysis/assets/100087560/c9ef7e5e-df7d-451e-80af-3110ccd44d61)

We need to take account of the fact that the model data extends for approximately 103 000 seconds, this means that we have more than one day (86 400 seconds) in each file and that a file can starts at any time of a day so we need to have the model file from the date before to have the full day coverage.

# GraphMAD.ipynb
Now we can plot some data from the EISCAT experiments, for that we need to load the data from the file but they are stored in a quite special way so we need to convert them to an array of array first:
```python
data = f['Data']['Table Layout'][:] # Get data from the file
metadata = f['Metadata']['Data Parameters'][:] # Get data parameters from the file
parameters = [parameter[0] for parameter in metadata] # Get the name of each parameters
data = np.array([np.array(tuple.tolist()) for tuple in data]) # Convert data to array
dataframe = pd.DataFrame(data, columns=parameters) # Create Panda dataframe for user sake
```

This creates a Panda dataframe structured as it follows (for readability some keys are not shown here):
```python
[
  b'YEAR' : [], # Year
  b'MONTH' : [], # Month
  b'DAY' : [], # Day
  b'HOUR' : [], # Hours
  b'MIN' : [], # Minutes
  ...
  b'GDALT' : [], # Altitude m 
  b'NE' : [], # Electron density m-3
  b'TI' : [], # Ion temperature K
  b'TR' : [], # Electron to ion temperature ratio
]
```

After this tricky part, we can plot the density profile as welle as the electron and ion temperature profiles:

![output](https://github.com/remy-guillermin/WACCM-Analysis/assets/100087560/96335abb-96d0-4989-b272-48272f958fe9)