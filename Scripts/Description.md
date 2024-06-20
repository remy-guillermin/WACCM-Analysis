# Description of the scripts
## TESThdf5.ipynb
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
## TESTnc.ipynb
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
Next we want to produce 


