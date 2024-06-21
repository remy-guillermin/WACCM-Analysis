# DST.ipynb
Because we can only find DST index values for one year, we need to regroup the three years into one file, this can be done easily with the `panda` package.

# Hp30.ipynb
We need to do the same with Hp30 index, but we use tje `json`package here.

# Create_CSV.ipynb
This script must be used only to create the global data files named like `global_data_5_48.csv`, where in this case `5` is the number of altitude slot and `48` the number of time slot. 

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

In this script, we see that we add `[False]*bins` or `[True]*bins` depending of the location, it is only to allows us to isolate Svalbard or Tromsø event afterwards.




