# Helpful script templates for PanoplyCL

## Description
Helper shell script for generating automated plots of geolocated data using the command-line version of Panoply.

## Getting Started
### Pre-requisites:
You will need to be working on a *nix machine with a local, GUI version of Panoply as well as the beta version of PanoplyCL. To get [PanoplyCL](https://www.giss.nasa.gov/tools/panoply/), you must email Dr. [Robert B. Schmunk](mailto:robert.b.schmunk@nasa.gov) and request to be a beta tester. As a result, use at your own risk.

### Make a template panoply script
The best way to get started is to make a manual sample plot the exact way you want in standard Panoply. This mean you pick the data ranges (not changing the ranges defaults to auto), projections, and gridding.  
Once configured, go to File --> Export --> Save As PanoplyCL.
This will save a template of the formatting that was applied to the plot as a *.pcl file. You can inspect the final script, then copy/paste the new script into one of the existing \*.pcl scripts in the config directory of this repository.

#### Tips:
I suggest using the following options to yield the best-looking plots (with larger file sizes):

```
myplot.set ( "overlay-1-name", "MWDB_Coasts_1.cnob" );
myplot.set ( "size-factor", 300 );
```

If you want to swap variables on the fly, make sure your pcl file has the following:
```
var ncvar1 = ncdata1.getVariable ( varname );
myplot.set ( "scale-min", 0.0 );
myplot.set ( "scale-max", 2.0 );
```
In the panoply template, the first line will include hard-coded text for the variable name. You can leave it as is if you don't plan on plotting anything else with the same tempalte script. The scales will auto update by default, or you can include ranges here to keep it fixed.

Finally, I also suggest turning off interpolation, as this can produce unexpected artifacts in binary and VIIRS plots:
```
myplot.set ( "interpolate", false );
```

### Update the plotting shell script
* Open up plot\_ABI\_panoply.sh and update the paths to reflect the location of PanoplyCL, your input, and output files.
* Select the config file name and variable you wish to plot (if not hard coded in the pcl file)

## Running
Make sure the permissions are properly set (chmod u+x plot\_ABI\_panoply.sh), then open the terminal and run the bash script:
```
./plot_ABI_panoply.sh
```
Panoply will open/run for each file in the input directory. If you want to only select certain files, update the criteria set in the searchFor variable.

Panoply is quite verbose and will throw an error if anything is amiss.

## Author
* **Rebekah Bradley Esmaili** [bekah@umd.edu](mailto:bekah@umd.edu)
* Note: These resources are NOT official. Use at you own risk.

## More Information
* [Panoply](https://www.giss.nasa.gov/tools/panoply/)
* GOES-16 input data can be downloaded from NOAA's [Comprehensive Large Array-data Stewardship System (CLASS)](https://www.class.noaa.gov/)
