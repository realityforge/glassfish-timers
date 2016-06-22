## Using NetCDF files

[NetCDF](http://www.unidata.ucar.edu/software/netcdf/) is a set of software libraries and self-describing,
machine-independent data formats that support the creation, access, and sharing of array-oriented scientific
data. We consume and generate data in this format when writing simulation software.

## Panopoly

If you want to look at a NetCDF file then [Panoply](http://www.giss.nasa.gov/tools/panoply/) works well.

Open the file, you will see a number of variables: Lat/Long/time/some-thing-of-interest

Right-click on the something of interest, choose 'Create standard Plot'.

If you want to have it zoom to Victoria you can do this after the plot has opened, or by changing the default preferences:

In preferences, on the 'Lon-Lat Plots' tab, in the 'Map Plots' section:

- Projection: Equirectangular (Regional)
- Centre on 146, -36.5
- Width: 15
- Height: 6
