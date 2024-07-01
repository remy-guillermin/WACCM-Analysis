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
data = f['Data']['Table Layout'][:]
metadata = f['Metadata']['Data Parameters'][:]
parameters = [parameter[0] for parameter in metadata]
data = np.array([np.array(tuple.tolist()) for tuple in data])
dataframe = pd.DataFrame(data, columns=parameters)
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

# DST.ipynb
Because we can only find DST index values for one year, we need to regroup the three years into one file, this can be done easily with the `panda` package.

# Hp30.ipynb
We need to do the same with Hp30 index, but we use the `json`package here.

# Create_CSV.ipynb
This script must be used only to create the global data files named like `global_data_4_0.5.csv`, where in this case `4` is the value of one altitude slot and `0.5` the value of one time slot. 

It's important to note that we can only use EISCAT files from either Tromsø or Svalbard experiment with this script.

Here is the structure of one global data file :

Date | Hours | Altitude | Svalbard | Tromso | Geo Event | SP Event | EXP Density | EXP Density Error | WACCM Density | EXP Magnitude | EXP Magnitude Error | WACCM Magnitude | DST Index | DST Index Gradient | Hp30 Index | Hp30 Index Gradient
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
2004-01-14 | 9.0 | 90 | 1 | 0 | 0 | 0 | 659456637 | 1681254727 | 2479583097 | 8.81 | 9.22 | 9.39 | -6.0 | 0.0 | 3.0 | -1.33
2004-01-14 | 9.5 | 90 | 1 | 0 | 0 | 0 | 682141246 | 1154373994 | 2460064336 | 8.83 | 9.06 | 9.39 | -10.0 | -8.0 | 2.333 | 0.0
2004-01-14 | 10.0 | 90 | 1 | 0 | 0 | 0 | 696178246 | 866611309 | 2465102573 | 8.84 | 8.93 | 9.39 | -14.0 | 0.0 | 2.333 | 0.66
2004-01-14 | 10.5 | 90 | 1 | 0 | 0 | 0 | 702768122 | 1140190903 | 2475819042 | 8.84 | 9.05 | 9.39 | -15.5 | -3.0 | 2.667 | -1.33
2004-01-14 | 11.0 | 90 | 1 | 0 | 0 | 0 | 703778803 | 1117979387 | 2526585708 | 8.84 | 9.04 | 9.4 | -17.0 | 0.0 | 2.0 | -0.66
2004-01-14 | 11.5 | 90 | 1 | 0 | 0 | 0 | 699140435 | 665202103 | 2501844736 | 8.84 | 8.82 | 9.39 | -18.0 | -2.0 | 1.667 | 0.0

Experiment value files have location indicator in their name which allows us to simply search them in the file name.

```python
bins = len(time_save) * len(H_save)

if 'uhf' in file:
  mask_location = mask_tromso
  Tromso_Data = np.concatenate((Tromso_Data, np.repeat(True, bins)))
  Svalbard_Data = np.concatenate((Svalbard_Data, np.repeat(False, bins)))
elif '42m' in file:
  mask_location = mask_svalbard
  Tromso_Data = np.concatenate((Tromso_Data, np.repeat(False, bins)))
  Svalbard_Data = np.concatenate((Svalbard_Data, np.repeat(True, bins)))
```

In this script, we see that we add `[False]*bins` or `[True]*bins` depending on the location, it is only to allows us to isolate Svalbard or Tromsø event afterwards.

Next we need to check if the current date is during a Geomagnetic Storm or a Solar Proton event, for that we have to manually add an indicator at the end of the folder name, either `-GEO` or `-SOL`. Next we just check the name of the folder, for that we first split the folder path so it's just the folder name and not the whole path and then check for either condition. We add `[False]*bins` or `[True]*bins` depending on the event type for the same reason as before.

```python
folder = '../../DataSorted/2004-01-22-GEO'
date = folder.split('/')[-1]

if 'GEO' in date and 'SOL' in date:
  date = date.replace('-GEO', '')
  date = date.replace('-SOL', '')
  Geo_Event = np.concatenate((Geo_Event, np.repeat(True, bins)))
  Solar_Event = np.concatenate((Solar_Event, np.repeat(True, bins)))
elif 'GEO' in date and 'SOL' not in date:
  date = date.replace('-GEO', '')
  Geo_Event = np.concatenate((Geo_Event, np.repeat(True, bins)))
  Solar_Event = np.concatenate((Solar_Event, np.repeat(False, bins)))
elif 'GEO' not in date and 'SOL' in date:
  date = date.replace('-SOL', '')
  Geo_Event = np.concatenate((Geo_Event, np.repeat(False, bins)))
  Solar_Event = np.concatenate((Solar_Event, np.repeat(True, bins)))
else:
  Geo_Event = np.concatenate((Geo_Event, np.repeat(False, bins)))
  Solar_Event = np.concatenate((Solar_Event, np.repeat(False, bins)))
```

Another part in the script that need further explanation is the conversion of mixing ratio no electron density for the model. The mixing ratio array `Ne_array` are inhomogenous nested arrays structured as follows (these are arbitrary values):
```python
[[1.7e-2, 3.6e-1, 1.1e-1, 2.7e-2, ..., 3.9e-3], #10.5
 [2.1e-2, 4.0e-1, 2.3e-1, 3.2e-2, ..., 3.8e-3], #10.7
 ...,
 [9.9e-3, 3.4e-1, 2.7e-1, 2.1e-2, ..., 4.6e-3]] #13.2
#[82 km,  97 km,  105 km, 109 km, ..., 134 km]  hours
```
As we can see, we can have multiple mixing ratio for the same time bin (for example 9.5 -> 10.0) or the same altitude bin (90 km -> 100 km).

The temperature array needs one more index because they are not structured in the same order than the mixing ratio one. At the beginning of the script we remove all pressure level below 0.01 hPa for the mixing ratio but we can not do it for the pressure levels themselves.

```python
k = 1.38*10**(-23)
def Ne_convert(E,P,T):
    return E*P/(k*T)

Ne_array = NeWACCM[t_mask_WACCM][index][h_mask_WACCM]
T_array = T[t_mask_WACCM][index][lev_mask][h_mask_WACCM]
Ne2_WACCM_array = np.concatenate((Ne2_WACCM_array, Ne_convert(Ne_array,P[h_mask_WACCM]*100,T_array))) 
```
We can convert the mixing ratio to electron density with the relation: concentration = (mixing ratio * pressure) / (boltzmann constant * temperature)

Next we want to retrieve the DST index value from from the dataframe we loaded. Here is how the `DST_global.csv` looks like:
DATE | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---  | ---  | ---  | ---  | ---  | ---  | ---  | ---  | ---  | --- 
2004-01-01 | -23 | -25.0 | -34 | -33 | -31 | -28 | -25.0 | -31 | -30.0 | -26 | -24.0 | -16.0 | -12.0 | -22 | -26.0 | -27 | -26.0 | -32.0 | -30.0 | -20.0 | -18.0 | -19.0 | -21.0 | -16.0
2004-01-02 | -12 | -16.0 | -18 | -19 | -13 | -12 | -12.0 | -13 | -15.0 | -15 | -14.0 | -8.0 | -7.0 | -7 | -10.0 | -10 | -9.0 | -7.0 | -6.0 | -4.0 | -9.0 | -1.0 | -2.0 | -1.0

When we load it we have 25 columns, one for the date and 24 for the hours of the day. The hour indexing starts at 1 because the DST index file show the value for the whole hour before that time.

About the `if` loop, we first do the case where the time bin is 1 hour or is in the first half of the hour, and the current time slot is not 24:00 (this condition will be here for the three first tests) which is the easier. We can then add the dst value along with the dst gradient.
Then we test if the hour value of the time slot we are currently in is different than the next one. If both statements are verified, this mean that we are in the second half of the hour, for example 06:30, and we cen interpolate the current dst value, along with its gradient.
The last case is when the hour is 24:00, in this case we need to get the first DST value of the next day but we performe the same operation.

```python
int_hour_str = str(int(time_slot) + 1)
next_int_hour_str = str(int(time_slot + time_bin) + 1)
dst = dst_index_file[int_hour_str][dst_mask].values[0]

if  (time_bin == 1 or int_hour_str == next_int_hour_str) and int_hour_str != '24':
  dst_list.append(dst)
  next_dst = dst_index_file[next_int_hour_str][dst_mask].values[0]
  ddst_list.append((next_dst - dst)/time_bin)
elif int_hour_str != next_int_hour_str and int_hour_str != '24':
  next_dst = dst_index_file[next_int_hour_str][dst_mask].values[0] 
  dst_list.append((dst + next_dst)/2)
  ddst_list.append((next_dst - dst)/4)
elif int_hour_str == next_int_hour_str and int_hour_str != '24':
  dst_list.append(dst)
  next_dst = dst_index_file[next_int_hour_str][dst_mask].values[0]
  ddst_list.append((next_dst - dst)/time_bin)
else:
  dst_list.append(dst)
  next_dst = dst_index_file['1'][dst_shifted].values[0]
  ddst_list.append((next_dst - dst)/4)
```

It is important to note that currently this script only supports one hour or half an hour time bin, but this is not really a problem as Hp30 index come with a 30 minutes time interval aswell as the model that predicts for the next 30 minutes.

# DST_comparison.ipynb
This script use the global data file to plot informations about the DST index. In our case we use it to plot the relation between density magnitude difference and the DST index for different altitude value.

![image](https://github.com/remy-guillermin/WACCM-Analysis/assets/100087560/23045a71-2b26-4842-af27-8c75743254d2)

# Hp30_comparison.ipynb
This script does the same but for the Hp30 index.

![image](https://github.com/remy-guillermin/WACCM-Analysis/assets/100087560/a1d77042-0027-4835-b4a8-ff79e8e59dbc)



