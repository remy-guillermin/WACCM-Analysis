# Description of the scripts
## Testhdf5.ipynb
The purpose of this file is purely to understand the structure of the hdf5 file. EISCAT gives us two different structure to work with, the file that starts with 'MAD6***` is those that we will use for EISCAT data and they are structured like that:
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
## Testnc.ipynb
