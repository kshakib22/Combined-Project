# Disclaimer
--- 
By using this software you accept the Terms and Conditions as described in 'Evaluation Software License Agreement.docx'

# About
---
The package is based on our paper:
Liu Chenxi, Enrique Rosales, and Alla Sheffer. "StrokeAggregator: consolidating raw sketches into artist-intended curve drawings." ACM Transactions on Graphics (TOG) 37.4 (2018): 97.
Emails: {chenxil | albertr | sheffa}@cs.ubc.ca

This package includes two ways of using StrokeAggregator:
	1- Command line;
	2- User interface (UI).

# Notes
---
Test data to be loaded can be found in the 'data' directory.
More data that we showed in the paper and the supplementary material can be found here:
	- Supplementary material of "Closure-aware Sketch Simplification, Xueting Liu, Tien-Tsin Wong and Pheng-Ann Heng, 2015".
	http://www.cse.cuhk.edu.hk/~ttwong/papers/sketch/sketch.html
	- Data of "Visual Design and Engineering Laboratory, Gunay Orbay and Levent Burak Kara, 2011"
	http://vdel.me.cmu.edu/publications/2011ieee/index.html

The supported input strokes are polygonal curves represented by a sequence of points. Using 'svg_to_scap.py' provided in this package, SVG parametric curves are also supported. However, note that paths represented by their contours (
# Command line
---
By running StrokeAggregator under the command line, one does not need to install Python and required packages. Yet the executables only take *.scap inputs (examples located in 'strokeaggregator/data/'). To run on SVG inputs, one has to install Python and svgpathtools package (see the Command line: SVG inputs).

Three executables are located under the folder 'strokeaggregator/assets/exe_windows/':
	- strokeaggregator_single.exe for sequencial launching;
	- strokeaggregator_multi4.exe for 4 threads;
	- strokeaggregator_multi8.exe for 8 threads.

# Command line: Usage
---
To use the executable, open a cmd terminal (by pressing win+R and entering 'cmd.exe') or other preferred terminals.
Enter the command:
	[PATH_TO_EXE]\strokeaggregator_[single|multi4|multi8].exe [OPTIONS] INPUT_SCAP_FILE -o OUTPUT_SCAP_OR_SVG_FILE

	- Program Options:
    	-p  --precomputed    Skip the preprocessing.
    	-t  --post           Turn OFF the optional connection enforcement.
    	-c  --conservative   A slightly more conservative setting, which handles shading better than our default.
    	-v  --viz            Visualize the input and output:
    	                     Use +/- keys or mouse wheel to zoom.
    	                     Use mouse right click to look at.
    	                     Use R key to reset preview.
    - Example (after setting current directory to '[PATH_TO_PACKAGE]/strokeaggregator/assets/exe_windows/'):
    	- strokeaggregator_single.exe -t ../../data/Bowtie01.scap -o ../../data/Bowtie01_out.svg
    	  (This command generates the result Bowtie01_out.svg from the example Bowtie01.scap in the data folder, using a single thread and the optional connection enforcement step)

# Command line: SVG inputs
---
The SVG to SCAP converter (strokeaggregator/core/svg_to_scap.py) requires Python and svgpathtools, see UI: Installation for installation.

The script converts the file format and also reparameterizes the path from SVG. The new sampling step size can be controlled by SAMPLE_STEP_MM.
Usage:  python svg-to-scap.py [-r SAMPLE_STEP_MM] path_filename.svg -o out.svg|out.scap

	- Program Option:
    	-r         Change the path sampling step size to SAMPLE_STEP_MM. The default value is 2.
    			   Note the resampling and step size are applied to parametric curves (for instance, arcs, bezier curves) and not to piecewise liner curves.
    - You may want to use smaller step size when the input contains small details.

# UI
---
The UI mode provides the abilities to preview the inputs and the results, and also runs the command for the user. To launch the UI, one has to install Python and required packages.

# UI: Installation
---
The provided software runs with Python 2 or 3 and the required Python packages are:
- svgpathtools
	Install with PIP: 'pip install --user svgpathtools'
- svgwrite
	Install with PIP: 'pip install --user svgwrite'
- pyqt4
	Windows: Install from the precompiled .whl file. Download the compatible .whl (32/64-bit, matching python version) from https://www.lfd.uci.edu/~gohlke/pythonlibs/#pyqt4 and then run 'pip install --user PyQt4???4.11.4???XXX.whl'

For a more detailed instruction, see 'strokeaggregator\detailed_python_setup\Detailed Python Installation Instruction.docx'.

# UI: Usage
---
The StrokeAggregator software can be run from the command line in the top-level directory with the following command:
cmd: python stroke_aggregator.py
(Or double-clicking 'stroke_aggregator.py' in the explorer.)

In the GUI, the preview allows zooms controlled by the mouse wheel or +/- keys, and pans controlled by the mouse dragging.

Running the 'Consolidation' would generate result based on the current opened file. The result scap and SVG files are saved in the same directory with the input file and named with an extra '_out'.

The implementation is single-threaded by default. It can also run with 4 or 8 threads.

# Scap file format
---
This file format can be used in the input and output files (scap).
Strokes are stored as polylines (a list of 2D points) surrounded by brackets.

#canvas_width	canvas_height
@stroke_thickness
{
	#stroke_index	internal_index
	x y 0
	x y 0
	...
}
...

Here, stroke_index and internal_index are only used internally. They can be assigned to arbitrary values in the input.