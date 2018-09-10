#!/usr/bin/env bash
#-----------------------------------------------------------
# Description: Runs a batch version of PanoplyCL to iteratively 
# plot multiple ABI input files
#
# Author: Rebekah Bradley Esmaili (bekah@umd.edu)
#-----------------------------------------------------------

# PanoplyCL path and working directory (need full path for cron jobs)
panoply_path=path/to/panoply/PanoplyCL
working_dir_path=$(pwd)

# Name of config/pcl file to use:
#config_file=ABI-L2-AOD.pcl
config_file=ABI-L1b-RadC.pcl

# Variable to plot
#ncvarname=AOD
ncvarname=Rad

# Input files:
inputdir=input/
searchFor=*.nc

# Output plot directory:
outputdir=output/

#----------------------------------
escBackslash(){
    echo $(echo "$1" | sed 's/\//\\\//g')
}

inputdir2=$(escBackslash $inputdir)
outputdir2=$(escBackslash $outputdir)

line2="var inputdir=\"${inputdir2}\""
line3="var outputdir=\"${outputdir2}\""
line4="var varname=\"${ncvarname}\""

sed -i "2s/.*/${line2}/" ${working_dir_path}/config/${config_file}
sed -i "3s/.*/${line3}/" ${working_dir_path}/config/${config_file}
sed -i "4s/.*/${line4}/" ${working_dir_path}/config/${config_file}

for f in ${inputdir}${searchFor}; do
    
    if [ ! -f "${outputdir}AOD_$(basename $f).gif" ]; then
        echo "Plotting $(basename $f).gif"

        line1="var fname=\"$(basename $f)\""
        sed -i "1s/.*/${line1}/" ${working_dir_path}/config/${config_file}
        
        java -jar ${panoply_path}/PanoplyCL.jar ${working_dir_path}/config/${config_file}
        
    fi
done