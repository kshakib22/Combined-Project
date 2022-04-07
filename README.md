# Combined-Project-IS
 
This project combines projects [StrokeStrip](https://github.com/davepagurek/StrokeStrip), [StrokeAggregator](https://www.cs.ubc.ca/labs/imager/tr/2018/StrokeAggregator/), and [StrokeAggregator Labeller](https://github.com/davepagurek/StrokeAggregatorLabeller).

## Usage
The .SVG file to be processed needs to be copied into the folder `/strokeaggregator/core/input`. A script named `script.sh` has been provided for Mac users (tested on Macbook Air M1 2020, macOS Monterey). This allows the user to enter the .SVG filename through the command line as follows
```
sh script.sh filename.svg
```
#### *IMPORTANT*

The browser page needs to be **reloaded** once it has been opened by the script. This is because the server is started immediately *after* the browser has been already opened.
___

The script will convert the .SVG file to .scap and open the Javascript application to label this .scap file. After labeling, the user must download the file and paste the file in `strokestrip/examples/study_inputs`. The user should navigate back to `strokestrip/` folder and run the following command through terminal:
```
build/strokestrip examples/study_inputs/filename_cleaned.scap
```
where `filename_cleaned` would be the filename of the newly labeled .scap file. The outputs will be produced in the same `study_inputs` folder as the input.
